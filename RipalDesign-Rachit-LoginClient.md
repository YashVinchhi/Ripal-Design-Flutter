# Ripal Design — Flutter App | Module Owner: Rachit | Scope: LOGIN + CLIENT

**Figma source:** https://www.figma.com/design/N6q4lkJkzvuVW96qlWpEUR/Ripal-Design?node-id=19-20
**Team split:** Yash — Admin · Rachit — Login & Client · Rajibul — Worker · Employee module — built jointly by all three
**Backend:** Extends the existing ripaldesign.studio PHP/MySQL platform (PDO, PHPMailer, PSR-4, `ui_permissions` + `PermissionService` RBAC) via a versioned REST API.

---

## 1. PRD — Product Requirements Document

### 1.1 Purpose
Two things bundled because they're sequential in the user journey: (1) the single front door every role passes through, and (2) the Client experience — letting Ripal Design's architecture clients track their project from their phone instead of calling the office.

### 1.2 Goals
- One login flow, four destinations: route each authenticated user to their correct role home (Admin/Client/Worker/Employee).
- Reduce "what's the status of my project?" calls by giving clients self-serve visibility.
- Let clients view drawings/documents, milestones, and raise requests without a site visit.
- Keep auth secure and reusable — Rachit's token contract is what every other module (Admin, Worker, Employee) consumes.

### 1.3 Primary personas
- **Any user (Login):** first-time or returning, needs a fast, low-friction entry (phone/OTP preferred over password given non-technical clients).
- **Client:** homeowner/business owner who commissioned Ripal Design; checks in occasionally, wants clarity, not complexity.

### 1.4 Core user stories — Login
1. As any user, I can log in with phone number + OTP (primary) or email/password (fallback for staff).
2. As any user, I'm routed automatically to my role's home screen after login.
3. As any user, I can reset a forgotten password / re-request OTP.
4. As an Admin, I can invite a new Client/Worker/Employee (pre-provisioned account, first login sets password) — this endpoint is triggered from Yash's Admin module but the invite-accept screen is Rachit's.
5. As any user, my session persists (refresh token) until I explicitly log out or an admin deactivates me.

### 1.5 Core user stories — Client
1. As a Client, I can see my active project(s) with a status and current phase.
2. As a Client, I can view the project timeline/milestones (design → approval → execution → handover).
3. As a Client, I can view and download drawings/documents shared by the firm.
4. As a Client, I can see payment milestones and their status (paid/pending) — read-only, no in-app payment in v1.
5. As a Client, I can raise a service request or query, which becomes an approval/ticket the Admin sees.
6. As a Client, I can message the firm (lightweight thread, not full chat) about my project.
7. As a Client, I receive notifications on milestone changes and document uploads.

### 1.6 Out of scope (v1)
- Social/Google login (phone+OTP and email/password only, matching existing web auth).
- In-app payments.
- Client-to-Worker direct messaging (client only talks to "the firm," routed to admin/assigned employee).

### 1.7 Success metrics
- < 30s median time from app open to logged-in dashboard.
- ≥ 70% of clients check project status in-app at least weekly.
- Support-call volume for "status check" drops measurably post-launch (qualitative, tracked by office staff).

---

## 2. TRD — Technical Requirements Document

### 2.1 Stack
- **Client:** Flutter, `flutter_secure_storage` for token storage, `dio` with interceptor for auto-refresh.
- **Auth:** JWT (access token short-lived ~15min + refresh token ~30 days) issued by `/api/v1/auth/*`. OTP via SMS gateway already used by the firm's site (reuse existing provider/PHPMailer-adjacent SMS integration if one exists; otherwise a lightweight SMS API — flag this as a decision needed with backend before Phase 1).
- **Routing contract:** on successful login, backend returns `{ token, refresh_token, role, permissions[] }`; Flutter app's root router reads `role` and pushes to the matching module's home route — this is the shared contract every other module depends on.
- **Push:** FCM token registered right after login (`/api/v1/auth/device-token`), subscribed to `role_client` topic + `project_{id}` topic per active project.

### 2.2 Non-functional requirements
- OTP rate-limited server-side (max 5 requests / 15 min / number) to prevent abuse.
- Passwords (staff fallback) bcrypt-hashed server-side, never handled in plaintext beyond transit (TLS only, matching the pen-test hardening already done on the web platform).
- Token refresh must be silent/automatic — client never sees a raw "please log in again" unless refresh token itself is expired/revoked.
- Client-facing screens must gracefully handle "no active project yet" (newly invited client with nothing assigned).

### 2.3 API surface
```
POST /api/v1/auth/otp/request          { phone }
POST /api/v1/auth/otp/verify           { phone, otp }
POST /api/v1/auth/login                { email, password }   -- staff fallback
POST /api/v1/auth/refresh              { refresh_token }
POST /api/v1/auth/logout
POST /api/v1/auth/password/forgot      { email }
POST /api/v1/auth/password/reset       { token, new_password }
POST /api/v1/auth/invite/accept        { invite_token, password }
POST /api/v1/auth/device-token         { fcm_token }

GET  /api/v1/client/projects
GET  /api/v1/client/projects/{id}
GET  /api/v1/client/projects/{id}/timeline
GET  /api/v1/client/projects/{id}/documents
GET  /api/v1/client/projects/{id}/payments
POST /api/v1/client/requests                 { project_id, type, message }
GET  /api/v1/client/messages/{project_id}
POST /api/v1/client/messages/{project_id}    { body }
GET  /api/v1/client/notifications
```

### 2.4 Integration points with other modules
- Every other module's app-open flow calls into Rachit's `/auth/*` first — this is the critical shared dependency; Yash and Rajibul's modules cannot start real integration testing until this is stable (target: end of Phase 0).
- Client service requests land in the same `approvals`/ticket surface Yash's Admin module reads from.
- Document/timeline data is written by Admin (project CRUD) and Employee (uploads) — Client module is read-only here.

---

## 3. Implementation Plan

| Phase | Weeks | Deliverable |
|---|---|---|
| 0. Auth foundation | Wk 1–2 | OTP + password login, token refresh, role-based root routing — **this unblocks Yash & Rajibul, prioritize first** |
| 1. Onboarding | Wk 3 | Invite-accept flow, forgot password, empty/first-run states |
| 2. Client dashboard | Wk 4 | Project list, project overview card |
| 3. Client detail views | Wk 5–6 | Timeline/milestones, documents list + download, payment status |
| 4. Client requests & messaging | Wk 7 | Service request form, lightweight message thread |
| 5. Notifications | Wk 8 | FCM registration, notification center, milestone/document push triggers |
| 6. Hardening | Wk 9 | Token edge cases (expired/revoked), empty states, joint Employee-module integration test with Yash & Rajibul |
| 7. Release | Wk 10 | Beta with a handful of real clients |

**Dependencies:** none upstream — this module is the critical path for everyone else. Confirm SMS/OTP provider decision with backend team by end of Week 1.

---

## 4. UI/UX Flow

### Login flow
1. **Splash** → check stored token → valid → route by role; invalid/none → **Login screen**.
2. **Login screen**: phone number input (primary) → "Send OTP" → **OTP screen** (auto-read if possible) → verify → success → role-based redirect. Small "Login with email instead" link for staff fallback → **Email/password screen**.
3. **Forgot password** (email flow only) → enter email → reset link/OTP → **Set new password** → back to login.
4. **Invite accept** (deep link from SMS/email) → **Set password** screen → auto-login → role home.

### Client flow
**Bottom nav (Client):** Home · Projects · Documents · Messages · Profile

1. **Home**: active project summary card(s), current phase badge, "next milestone" highlight, notification bell.
2. **Projects tab** → list (if multiple) → tap → **Project Overview** (tabs: Timeline · Documents · Payments · Requests).
   - **Timeline tab**: vertical stepper (Planning → Design → Approval → Execution → Handover) with dates and current-stage highlight.
   - **Documents tab**: list of drawings/files with type icon, upload date, download/share action.
   - **Payments tab**: milestone list with amount + status chip (Paid/Pending/Overdue) — read-only.
   - **Requests tab**: "Raise a request" button → form (type: query/change-request/complaint + message) → submitted list with status.
3. **Messages tab** → single thread per active project with the firm → simple chat-style UI, no typing indicators needed for v1.
4. **Profile** → contact details (read-only, edit via office), notification preferences, logout.

**Key UX rules:** empty state for a client with zero projects must be reassuring ("Your project will appear here once our team sets it up") not an error screen; document downloads must show progress for large CAD/PDF files.

---

## 5. Application Flow

**A. First login (existing client)**
`Open app → Splash checks token (none) → Login screen → enter phone → Send OTP → POST /auth/otp/request → SMS delivered → enter OTP → POST /auth/otp/verify → backend validates, issues { token, refresh_token, role: 'client' } → app stores tokens securely → root router reads role → pushes Client Home → GET /client/projects fetched and cached`

**B. Client raises a request**
`Client → Project → Requests tab → Raise a request → fill form → POST /client/requests → row created in shared approvals/tickets table (type=client_request) → FCM notification to role_admin → (Yash's module) Admin sees it in their queue → decision → notification back to client via role/user-targeted push → client's request list status updates`

**C. Document appears for a client**
`Employee/Admin uploads a document against a project (Employee module) → document row linked to project_id → FCM push to project_{id} topic → client app receives push → Documents tab badge increments → client taps → GET /client/projects/{id}/documents → new file listed`

**D. Session refresh**
`Any authenticated request returns 401 → dio interceptor catches it → POST /auth/refresh with stored refresh_token → new access token issued → original request retried transparently → if refresh_token itself invalid/expired → force logout → Login screen`

---

## 6. Backend Schema (Login + Client-relevant tables)

```sql
-- Auth (new/extended on top of existing users table)
users (                        -- shared table, see note
  id INT PK AUTO_INCREMENT,
  name VARCHAR(120),
  phone VARCHAR(20) UNIQUE,
  email VARCHAR(150) UNIQUE NULL,
  password_hash VARCHAR(255) NULL,   -- null until invite accepted, for staff-style login
  role ENUM('admin','client','worker','employee'),
  status ENUM('invited','active','inactive') DEFAULT 'invited',
  created_at DATETIME, updated_at DATETIME
);

otp_requests (
  id INT PK AUTO_INCREMENT,
  phone VARCHAR(20),
  code_hash VARCHAR(255),
  expires_at DATETIME,
  attempts INT DEFAULT 0,
  created_at DATETIME
);

refresh_tokens (
  id INT PK AUTO_INCREMENT,
  user_id INT,                  -- FK users.id
  token_hash VARCHAR(255),
  expires_at DATETIME,
  revoked BOOLEAN DEFAULT FALSE,
  created_at DATETIME
);

invites (
  id INT PK AUTO_INCREMENT,
  user_id INT,                   -- FK users.id (pre-provisioned by admin)
  invite_token VARCHAR(255) UNIQUE,
  expires_at DATETIME,
  accepted_at DATETIME NULL
);

device_tokens (
  id INT PK AUTO_INCREMENT,
  user_id INT,                   -- FK users.id
  fcm_token VARCHAR(255),
  updated_at DATETIME
);

-- Client-facing data
projects (                       -- shared with Admin module, Client reads only
  id INT PK AUTO_INCREMENT,
  name VARCHAR(160),
  client_id INT,                 -- FK users.id (role=client)
  status ENUM('planning','in_progress','on_hold','completed'),
  current_phase VARCHAR(50),
  start_date DATE, target_end_date DATE
);

project_milestones (
  id INT PK AUTO_INCREMENT,
  project_id INT,                 -- FK projects.id
  title VARCHAR(150),
  phase VARCHAR(50),
  planned_date DATE, actual_date DATE NULL,
  status ENUM('pending','in_progress','done')
);

project_documents (
  id INT PK AUTO_INCREMENT,
  project_id INT,                  -- FK projects.id
  uploaded_by INT,                  -- FK users.id (admin/employee)
  title VARCHAR(150), file_url VARCHAR(255), file_type VARCHAR(30),
  uploaded_at DATETIME
);

payment_milestones (
  id INT PK AUTO_INCREMENT,
  project_id INT,                   -- FK projects.id
  label VARCHAR(120), amount DECIMAL(10,2),
  status ENUM('pending','paid','overdue'),
  due_date DATE, paid_date DATE NULL
);

client_requests (
  id INT PK AUTO_INCREMENT,
  project_id INT,                    -- FK projects.id
  client_id INT,                      -- FK users.id
  type ENUM('query','change_request','complaint'),
  message TEXT,
  status ENUM('open','in_review','resolved') DEFAULT 'open',
  created_at DATETIME
);

project_messages (
  id INT PK AUTO_INCREMENT,
  project_id INT,                      -- FK projects.id
  sender_id INT,                        -- FK users.id (client or firm rep)
  body TEXT,
  created_at DATETIME
);
```

---

## Appendix — Employee Module (shared, built jointly by Yash / Rachit / Rajibul)

Because the Employee role is co-owned, this section is intentionally identical across all three team documents — align on it together before splitting implementation.

**Scope:** office staff (design/drafting employees) — not site Workers, not Clients.
**Core features:** clock-in/out (office-based, distinct from AttendX's separate attendance product), leave request submission, assigned task list per project, timesheet entry, internal messaging/notice board, document upload for project deliverables (this is the upload path feeding Client's Documents tab above).
**Shared tables:** `users` (role=employee), `project_assignments`, `approvals` (type=leave), `project_documents` (as uploader), plus a jointly-owned `employee_tasks` and `timesheets` table (to be finalized together — not detailed per-person here to avoid drift; whoever picks up Employee screens first should draft `employee_tasks`/`timesheets` and circulate for the other two to review before building against it).
**Coordination rule:** any schema or endpoint under `/api/v1/employee/*` needs sign-off from all three before merging, since Admin (approvals/assignment), Client (document/timeline visibility), and Worker (shared site coordination) all touch it indirectly.
