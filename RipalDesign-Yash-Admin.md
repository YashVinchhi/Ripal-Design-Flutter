# Ripal Design — Flutter App | Module Owner: Yash | Scope: ADMIN

**Figma source:** https://www.figma.com/design/N6q4lkJkzvuVW96qlWpEUR/Ripal-Design?node-id=19-20
**Team split:** Yash — Admin · Rachit — Login & Client · Rajibul — Worker · Employee module — built jointly by all three
**Backend:** Extends the existing ripaldesign.studio PHP/MySQL platform (PDO, PHPMailer, PSR-4, `ui_permissions` + `PermissionService` RBAC) via a versioned REST API consumed by the Flutter app.

---

## 1. PRD — Product Requirements Document

### 1.1 Purpose
Give Ripal Design's firm leadership (owner/partners + office managers) a mobile control center to run the firm remotely: see every project's status, assign and reassign people, approve requests, and track performance — without needing a laptop open to the web panel.

### 1.2 Goals
- Real-time visibility into all active projects, both offices (Rajkot, Khambhalia).
- Centralize approvals that currently happen over WhatsApp/calls (leave, material, payment milestones).
- Surface the existing worker/vendor performance-scoring engine as an actionable admin view.
- Let admins manage users and role permissions on the go (mirroring the web `ui_permissions` model).
- Push targeted notifications to Client / Worker / Employee roles.

### 1.3 Primary persona
**Admin / Owner-Partner** — non-technical to semi-technical, checks the app multiple times a day between site visits and office work, needs speed over depth.

### 1.4 Core user stories
1. As an Admin, I can see a dashboard of all active projects with status, health flag, and pending approvals count.
2. As an Admin, I can open a project and see its full team (client, assigned workers, assigned employees), timeline, and documents.
3. As an Admin, I can create/edit a project and assign Workers/Employees to it.
4. As an Admin, I can approve or reject leave requests, material requests, and expense/payment milestone requests.
5. As an Admin, I can create, edit, deactivate users and assign roles/permissions per the existing RBAC model.
6. As an Admin, I can view each worker's performance score (exponential-decay/consistency model) and score history.
7. As an Admin, I can broadcast a notification to one role, one project's team, or everyone.
8. As an Admin, I can view firm-level analytics (project throughput, on-time %, office-wise load) in a simple chart view.
9. As an Admin, I can drill into audit logs (who approved what, when) for accountability.

### 1.5 Out of scope (v1)
- In-app payment processing/gateway (approvals only; actual payment stays offline/web).
- AutoCAD/Revit/Lumion file rendering — only document metadata + download link.
- Multi-firm/white-label switching inside this app (single-tenant for Ripal Design only in v1).

### 1.6 Success metrics
- 100% of leave/material/payment approvals routed through the app within 4 weeks of launch.
- Admin dashboard load time < 2s on 4G.
- Admin session frequency ≥ 3x/day (proxy for "replaces WhatsApp check-ins").

---

## 2. TRD — Technical Requirements Document

### 2.1 Stack
- **Client:** Flutter (single codebase, Android priority — most firm staff/admins are on Android), Riverpod or Provider for state, `dio` for networking.
- **Backend:** Existing PHP (PDO) REST endpoints under `/api/v1/admin/*`, reusing `PermissionService` for every route.
- **Auth:** JWT issued by the shared Login module (Rachit's scope) — Admin app only *consumes* the token, doesn't issue it.
- **Push:** FCM (Firebase Cloud Messaging) — the one Firebase dependency, used only for notification delivery, not data storage.
- **Charts:** `fl_chart` for the analytics screen.
- **File handling:** signed URL download from the existing document store; no new file storage layer for v1.

### 2.2 Non-functional requirements
- Every admin write endpoint must check `ui_permissions` server-side (never trust client-side role gating alone).
- All admin actions (approve/reject/assign/deactivate) written to an `audit_log` table.
- Offline-tolerant read: last-fetched dashboard/project list cached locally (Hive/SharedPreferences) and shown with a "stale data" banner if the network call fails.
- Role check on app open: if the logged-in user's role ≠ Admin, app must route to the correct role's home (shared routing logic with Rachit's login module).

### 2.3 API surface (admin-scoped)
```
GET  /api/v1/admin/dashboard
GET  /api/v1/admin/projects?status=&office=&page=
GET  /api/v1/admin/projects/{id}
POST /api/v1/admin/projects
PUT  /api/v1/admin/projects/{id}
POST /api/v1/admin/projects/{id}/assign        { user_id, role }
GET  /api/v1/admin/approvals?type=leave|material|payment&status=pending
POST /api/v1/admin/approvals/{id}/decision     { decision: approve|reject, note }
GET  /api/v1/admin/users?role=
POST /api/v1/admin/users
PUT  /api/v1/admin/users/{id}
PUT  /api/v1/admin/users/{id}/permissions
GET  /api/v1/admin/performance/{worker_id}
GET  /api/v1/admin/performance/{worker_id}/history
POST /api/v1/admin/notifications/broadcast     { target_role|target_project|target_user, title, body }
GET  /api/v1/admin/analytics/overview?range=
GET  /api/v1/admin/audit-log?range=&actor=
```

### 2.4 Integration points with other modules
- Reads `users` and `projects` tables owned jointly, but only Admin can write role/permission changes.
- Consumes Worker performance data produced by the existing scoring engine (read-only from Admin side).
- Sends `target_role=employee/client/worker` notifications that the other modules must subscribe to via FCM topics `role_client`, `role_worker`, `role_employee`.

---

## 3. Implementation Plan

| Phase | Weeks | Deliverable |
|---|---|---|
| 0. Setup | Wk 1 | Flutter project scaffold, shared design tokens (ЯD brand red `#94180C`), API client, auth token handoff contract agreed with Rachit |
| 1. Dashboard + Project list | Wk 2–3 | Dashboard, project list/filter, project detail (read-only) |
| 2. Project CRUD + Assignment | Wk 4 | Create/edit project, assign worker/employee, team view |
| 3. Approvals | Wk 5 | Leave / material / payment approval queues + decision flow |
| 4. User & Role Management | Wk 6 | User list, create/edit, permission toggles mapped to `ui_permissions` |
| 5. Performance & Analytics | Wk 7 | Worker score view, history chart, firm analytics overview |
| 6. Notifications + Audit Log | Wk 8 | Broadcast composer, audit log viewer |
| 7. Hardening | Wk 9 | Offline caching, error states, permission-edge-case QA, joint Employee-module integration test with Rachit & Rajibul |
| 8. Release | Wk 10 | Internal beta with firm's 2 offices, staged rollout |

**Dependencies:** Login/token contract from Rachit before Phase 0 exit. Worker performance data model confirmed with Rajibul before Phase 5.

---

## 4. UI/UX Flow (Admin)

**Bottom nav (Admin):** Home (Dashboard) · Projects · Approvals · Team · More (Users / Analytics / Audit Log / Settings)

1. **Splash → Auth check** → if role = Admin → **Dashboard**
2. **Dashboard**: firm-wide stat cards (active projects, pending approvals, offices), "needs attention" list (overdue tasks, low-score workers), quick-broadcast button.
3. **Projects tab** → list (filter: status, office, client) → tap → **Project Detail** (tabs: Overview · Team · Documents · Timeline) → Assign button → bottom-sheet picker (Worker/Employee, searchable) → confirm.
4. **Approvals tab** → segmented control (Leave / Material / Payment) → swipeable cards → tap → detail sheet with Approve/Reject + note field → decision confirmation toast.
5. **Team/Users (More → Users)** → list grouped by role → tap user → profile → **Permissions** screen (toggle list mirroring `ui_permissions`) → save.
6. **Performance (More → Analytics → Performance)** → worker list sorted by score → tap → score breakdown (consistency, confidence, trend chart) → history.
7. **Audit Log (More → Audit Log)** → chronological feed, filter by actor/action type.
8. **Settings** → notification preferences, office selector default, logout.

**Key UX rules:** every destructive/approval action needs a confirm step; permission screen changes require a second "Apply" tap (no accidental role escalation); dashboard refresh is pull-to-refresh + auto every 60s while foregrounded.

---

## 5. Application Flow (Admin)

**A. Approve a leave request**
`Employee submits leave (Employee module) → notification (role_admin, FCM) → Admin opens Approvals tab → sees pending card → opens detail → Approve/Reject → POST /admin/approvals/{id}/decision → audit_log write → notification back to requester → dashboard "pending" count decrements`

**B. Assign a worker to a project**
`Admin opens Project Detail → Team tab → tap Assign → search worker by name/skill → select → POST /admin/projects/{id}/assign → project_assignments row created → FCM notification to worker (role_worker, project-scoped) → worker's task list updates (Rajibul's module)`

**C. Update a user's permissions**
`Admin → Users → select user → Permissions → toggle capability → tap Apply → PUT /admin/users/{id}/permissions → PermissionService cache invalidated server-side → user's next API call re-evaluates against new ui_permissions row → audit_log entry`

**D. Broadcast notification**
`Admin → Quick broadcast (dashboard) or More → Notifications → compose → choose target (role/project/user) → POST /admin/notifications/broadcast → backend resolves FCM topic/token(s) → push delivered → delivery count shown back to admin`

---

## 6. Backend Schema (Admin-relevant tables)

```sql
-- Core, shared across all modules (owned jointly; Admin has write access to most)
users (
  id INT PK AUTO_INCREMENT,
  name VARCHAR(120),
  phone VARCHAR(20) UNIQUE,
  email VARCHAR(150) UNIQUE NULL,
  password_hash VARCHAR(255),
  role ENUM('admin','client','worker','employee'),
  office_id INT NULL,          -- FK offices.id, null for client
  status ENUM('active','inactive') DEFAULT 'active',
  created_at DATETIME, updated_at DATETIME
);

offices (
  id INT PK AUTO_INCREMENT,
  name VARCHAR(80),            -- 'Rajkot', 'Khambhalia'
  address TEXT
);

ui_permissions (              -- existing RBAC table, reused as-is
  id INT PK AUTO_INCREMENT,
  role ENUM('admin','client','worker','employee'),
  user_id INT NULL,            -- null = role-default, set = per-user override
  permission_key VARCHAR(100), -- e.g. 'project.assign', 'approval.payment.decide'
  allowed BOOLEAN DEFAULT TRUE
);

projects (
  id INT PK AUTO_INCREMENT,
  name VARCHAR(160),
  client_id INT,               -- FK users.id (role=client)
  office_id INT,                -- FK offices.id
  status ENUM('planning','in_progress','on_hold','completed'),
  start_date DATE, target_end_date DATE,
  created_by INT,               -- FK users.id (admin)
  created_at DATETIME, updated_at DATETIME
);

project_assignments (
  id INT PK AUTO_INCREMENT,
  project_id INT,               -- FK projects.id
  user_id INT,                  -- FK users.id (worker/employee)
  role_on_project VARCHAR(50),  -- e.g. 'site_worker', 'site_engineer'
  assigned_by INT,               -- FK users.id (admin)
  assigned_at DATETIME
);

-- Approvals (leave / material / payment) unified queue
approvals (
  id INT PK AUTO_INCREMENT,
  type ENUM('leave','material','payment'),
  requested_by INT,             -- FK users.id
  project_id INT NULL,          -- FK projects.id (material/payment usually project-scoped)
  payload JSON,                 -- type-specific fields (dates, item list, amount, etc.)
  status ENUM('pending','approved','rejected') DEFAULT 'pending',
  decided_by INT NULL,          -- FK users.id (admin)
  decision_note TEXT NULL,
  created_at DATETIME, decided_at DATETIME NULL
);

-- Worker/vendor performance (read surface for Admin; engine owned with Rajibul's module)
worker_scores (
  id INT PK AUTO_INCREMENT,
  worker_id INT,                -- FK users.id
  period DATE,                  -- month bucket
  score DECIMAL(5,2),
  consistency DECIMAL(5,2),
  confidence DECIMAL(5,2),
  computed_at DATETIME
);

audit_log (
  id INT PK AUTO_INCREMENT,
  actor_id INT,                 -- FK users.id
  action VARCHAR(100),          -- 'approval.decide','user.permission.update','project.assign', ...
  target_type VARCHAR(50),
  target_id INT,
  meta JSON,
  created_at DATETIME
);

notifications (
  id INT PK AUTO_INCREMENT,
  sender_id INT,                 -- FK users.id (admin) NULL if system-generated
  target_type ENUM('role','project','user'),
  target_value VARCHAR(100),     -- role name / project_id / user_id as string
  title VARCHAR(150), body TEXT,
  created_at DATETIME
);
```

---

## Appendix — Employee Module (shared, built jointly by Yash / Rachit / Rajibul)

Because the Employee role is co-owned, this section is intentionally identical across all three team documents — align on it together before splitting implementation.

**Scope:** office staff (design/drafting employees) — not site Workers, not Clients.
**Core features:** clock-in/out (office-based, distinct from AttendX's separate attendance product), leave request submission, assigned task list per project, timesheet entry, internal messaging/notice board, document upload for project deliverables.
**Shared tables:** `users` (role=employee), `project_assignments`, `approvals` (type=leave), plus a jointly-owned `employee_tasks` and `timesheets` table (to be finalized together — not detailed per-person here to avoid drift; whoever picks up Employee screens first should draft `employee_tasks`/`timesheets` and circulate for the other two to review before building against it).
**Coordination rule:** any schema or endpoint under `/api/v1/employee/*` needs sign-off from all three before merging, since Admin (approvals/assignment), Client (visibility into who's on their project), and Worker (shared site coordination) all touch it indirectly.
