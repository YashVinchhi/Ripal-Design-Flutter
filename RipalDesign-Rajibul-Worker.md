# Ripal Design — Flutter App | Module Owner: Rajibul | Scope: WORKER

**Figma source:** https://www.figma.com/design/N6q4lkJkzvuVW96qlWpEUR/Ripal-Design?node-id=19-20
**Team split:** Yash — Admin · Rachit — Login & Client · Rajibul — Worker · Employee module — built jointly by all three
**Backend:** Extends the existing ripaldesign.studio PHP/MySQL platform (PDO, PHPMailer, PSR-4, `ui_permissions` + `PermissionService` RBAC) via a versioned REST API. This module also surfaces the firm's existing vendor/worker performance-scoring engine (exponential decay, consistency, confidence, cold-start handling).

---

## 1. PRD — Product Requirements Document

### 1.1 Purpose
Give site workers/vendors (largely non-desk, on-site staff) a simple phone tool to receive assignments, log attendance at site, report progress, and request materials — replacing verbal/WhatsApp-only coordination with the firm.

### 1.2 Goals
- Workers always know what they're assigned to and where, without calling the office.
- Site attendance/check-in is location-verifiable (GPS-stamped), feeding the performance-scoring engine.
- Daily progress updates (photo + note) become the project's visual record for Admin and Client.
- Material requests get logged and routed to Admin approval instead of informal asks.
- Workers can see their own performance score to understand how it's calculated (transparency reduces disputes).

### 1.3 Primary persona
**Worker/Site Vendor** — low to moderate smartphone literacy, works with gloves/on-site conditions often, needs very large tap targets, minimal typing, and offline resilience (site signal is often weak).

### 1.4 Core user stories
1. As a Worker, I can see my list of assigned tasks/site visits across projects, sorted by date/priority.
2. As a Worker, I can check in / check out at a site with GPS location captured automatically.
3. As a Worker, I can update a task's status (not started / in progress / done) and add a photo + short note.
4. As a Worker, I can request materials for a project (item, quantity, urgency) — goes to Admin approval.
5. As a Worker, I can view my own performance score and a plain-language explanation of what affects it.
6. As a Worker, I can view basic project info relevant to my task (address, contact, scope note) — not full client/financial data.
7. As a Worker, I receive notifications when a new task is assigned or a material request is decided.

### 1.5 Out of scope (v1)
- Payroll/wage calculation (performance score informs it offline; no in-app payout).
- Worker-to-worker messaging (only worker-to-firm, via task notes/comments).
- Inventory management system (material *requests* only, not stock tracking).

### 1.6 Success metrics
- ≥ 90% of site check-ins happen via app (vs. verbal reporting) within 6 weeks of rollout.
- Median time from task assignment to worker acknowledgment < 2 hours.
- Material request turnaround (request → decision) tracked and visibly faster than the prior informal process.

---

## 2. TRD — Technical Requirements Document

### 2.1 Stack
- **Client:** Flutter, `geolocator` for GPS check-in/out, `image_picker` + client-side compression before upload (site photos, weak connections), local queue (Hive/sqflite) for offline-first actions that sync when back online.
- **Auth:** consumes the shared token/routing contract from Rachit's Login module.
- **Push:** FCM, subscribed to `role_worker` topic + `worker_{id}` for personal assignment pushes.
- **Offline strategy:** check-in/out, status updates, and material requests must queue locally and sync on reconnect — this is the single most important non-functional requirement for this module given real site conditions.

### 2.2 Non-functional requirements
- GPS check-in must tolerate poor accuracy gracefully (accept with a "low accuracy" flag rather than blocking the worker from checking in).
- Photo uploads compressed client-side (target < 500KB) before hitting the network to survive weak site signal.
- All offline-queued actions must be idempotent server-side (duplicate submission on retry should not double-count attendance or duplicate a material request).
- Performance score view is read-only and must never expose the raw scoring formula/weights (transparency in plain language, not the algorithm itself) — confirm exact wording with Admin/firm before writing UI copy, since this is a sensitive number for vendors.

### 2.3 API surface
```
GET  /api/v1/worker/tasks?status=&project_id=
GET  /api/v1/worker/tasks/{id}
POST /api/v1/worker/checkin              { task_id, lat, lng, accuracy, timestamp }
POST /api/v1/worker/checkout             { task_id, lat, lng, accuracy, timestamp }
PUT  /api/v1/worker/tasks/{id}/status    { status, note, photo_url }
POST /api/v1/worker/materials            { project_id, item, quantity, urgency, note }
GET  /api/v1/worker/materials?status=
GET  /api/v1/worker/performance
GET  /api/v1/worker/performance/history
GET  /api/v1/worker/projects/{id}/summary   -- limited fields only (address, contact, scope)
POST /api/v1/worker/device-token
```

### 2.4 Integration points with other modules
- Tasks originate from Admin's `project_assignments` (Yash's module) — Worker module is the consuming side of that assignment flow.
- Material requests land in the same shared `approvals` table Admin decides on.
- Performance scores are computed by the existing engine (already live on the web platform) — this module is a read-only mobile surface for it, not a rebuild.
- Status updates with photos should be visible to Client's Timeline/Documents view (Rachit's module) where relevant — confirm with Rachit whether worker photos flow into `project_documents` or a separate `task_updates` feed (recommend the latter to avoid cluttering the client-facing document list; see schema below).

---

## 3. Implementation Plan

| Phase | Weeks | Deliverable |
|---|---|---|
| 0. Setup | Wk 1 | Flutter scaffold reusing shared design tokens, auth integration with Rachit's module, offline-queue architecture spike |
| 1. Task list | Wk 2–3 | Assigned task list, task detail (limited project info) |
| 2. Check-in/out | Wk 4 | GPS check-in/out with offline queue + sync |
| 3. Progress updates | Wk 5 | Status update flow with photo capture/compression + note |
| 4. Material requests | Wk 6 | Request form, request history/status list |
| 5. Performance view | Wk 7 | Score display + history, plain-language breakdown (copy reviewed with Admin) |
| 6. Notifications | Wk 8 | FCM registration, assignment/decision push handling |
| 7. Hardening | Wk 9 | Offline sync edge cases (conflict/duplicate handling), low-connectivity field testing at an actual site, joint Employee-module integration test with Yash & Rachit |
| 8. Release | Wk 10 | Beta with a small group of real site workers |

**Dependencies:** Login/token contract (Rachit) before Phase 0 exit. Confirm task-update visibility rules with Rachit before Phase 3 (whether worker photos surface to Client).

---

## 4. UI/UX Flow

**Bottom nav (Worker):** Tasks · Check-in · Materials · Score · Profile

1. **Splash → Auth check** → role = Worker → **Task List**.
2. **Task List**: cards grouped by "Today" / "Upcoming" / "Overdue", each showing project name, address snippet, status chip. Large tap target per card.
3. **Task Detail** → limited project summary (address, contact person, scope note) → big **Check In** button (if not yet checked in for this task today) → after check-in, big **Update Status** button + **Check Out** button appear.
4. **Check-in screen**: single-tap GPS capture with map pin confirmation ("You're checking in near [location] — confirm?") → confirm → done, minimal typing.
5. **Update Status**: three large status buttons (Not started / In progress / Done) → photo capture (camera-first, gallery fallback) → short note field (optional, voice-to-text friendly) → submit.
6. **Materials tab** → "Request material" button → simple form (item name, quantity, urgency: low/normal/urgent) → submit → list of past requests with status chip.
7. **Score tab** → large score number/gauge → plain-language explanation card ("Your score reflects on-time check-ins and completed tasks over the last 3 months") → history chart (simple line, monthly).
8. **Profile** → contact info (read-only), notification toggle, logout.

**Key UX rules:** everything usable one-handed, on-site, in sunlight (high contrast); no screen should require more than 2 taps + 1 optional text field to complete an action; offline actions show a clear "queued, will sync" state rather than failing silently.

---

## 5. Application Flow

**A. Task assignment to check-in**
`Admin assigns worker to project (Yash's module) → project_assignments row created → task auto-generated (or admin creates explicit task) → FCM push (worker_{id}) → worker opens Task List → sees new "Today" card → taps → Check In → GPS captured → POST /worker/checkin (or queued offline) → attendance row written → feeds performance engine`

**B. Offline progress update**
`Worker at site with no signal → Update Status → photo + note captured locally → action queued in local store (sqflite) → app shows "Queued — will sync" badge → connectivity restored → background sync job flushes queue → PUT /worker/tasks/{id}/status sent with idempotency key → server dedupes on key → status confirmed → badge clears`

**C. Material request**
`Worker → Materials → Request → fill form → POST /worker/materials → row in shared approvals table (type=material) → FCM to role_admin → (Yash's module) Admin approves/rejects → decision notification to worker_{id} → worker's Materials list status updates`

**D. Performance score refresh**
`Existing scoring engine recomputes monthly (server-side batch job, already live on web) → worker_scores row inserted → worker opens Score tab → GET /worker/performance → latest score + trend rendered → GET /worker/performance/history for the chart`

---

## 6. Backend Schema (Worker-relevant tables)

```sql
-- Shared core
users (                        -- role=worker rows relevant here
  id INT PK AUTO_INCREMENT,
  name VARCHAR(120), phone VARCHAR(20) UNIQUE,
  role ENUM('admin','client','worker','employee'),
  status ENUM('invited','active','inactive'),
  created_at DATETIME
);

project_assignments (           -- shared with Admin module
  id INT PK AUTO_INCREMENT,
  project_id INT, user_id INT,   -- FK projects.id, FK users.id
  role_on_project VARCHAR(50),
  assigned_by INT, assigned_at DATETIME
);

-- Worker-specific
tasks (
  id INT PK AUTO_INCREMENT,
  project_id INT,                 -- FK projects.id
  worker_id INT,                   -- FK users.id
  title VARCHAR(150), scope_note TEXT,
  due_date DATE,
  status ENUM('not_started','in_progress','done') DEFAULT 'not_started',
  created_by INT,                   -- FK users.id (admin)
  created_at DATETIME
);

attendance (
  id INT PK AUTO_INCREMENT,
  worker_id INT,                     -- FK users.id
  task_id INT NULL,                   -- FK tasks.id
  project_id INT,                      -- FK projects.id
  type ENUM('checkin','checkout'),
  lat DECIMAL(9,6), lng DECIMAL(9,6), accuracy_m DECIMAL(6,2),
  client_idempotency_key VARCHAR(64) UNIQUE,   -- for offline-sync dedupe
  recorded_at DATETIME
);

task_updates (                        -- separate from Client's project_documents by design
  id INT PK AUTO_INCREMENT,
  task_id INT,                          -- FK tasks.id
  worker_id INT,                         -- FK users.id
  status ENUM('not_started','in_progress','done'),
  note TEXT NULL,
  photo_url VARCHAR(255) NULL,
  client_idempotency_key VARCHAR(64) UNIQUE,
  created_at DATETIME
);

material_requests (                     -- rows also visible via shared 'approvals' queue
  id INT PK AUTO_INCREMENT,
  project_id INT,                         -- FK projects.id
  worker_id INT,                           -- FK users.id
  item VARCHAR(150), quantity INT, urgency ENUM('low','normal','urgent'),
  note TEXT NULL,
  status ENUM('pending','approved','rejected') DEFAULT 'pending',
  decided_by INT NULL,                       -- FK users.id (admin)
  created_at DATETIME, decided_at DATETIME NULL
);

worker_scores (                            -- read surface; engine owned/computed centrally
  id INT PK AUTO_INCREMENT,
  worker_id INT,                              -- FK users.id
  period DATE,
  score DECIMAL(5,2), consistency DECIMAL(5,2), confidence DECIMAL(5,2),
  computed_at DATETIME
);
```

---

## Appendix — Employee Module (shared, built jointly by Yash / Rachit / Rajibul)

Because the Employee role is co-owned, this section is intentionally identical across all three team documents — align on it together before splitting implementation.

**Scope:** office staff (design/drafting employees) — not site Workers, not Clients.
**Core features:** clock-in/out (office-based, distinct from AttendX's separate attendance product), leave request submission, assigned task list per project, timesheet entry, internal messaging/notice board, document upload for project deliverables.
**Shared tables:** `users` (role=employee), `project_assignments`, `approvals` (type=leave), plus a jointly-owned `employee_tasks` and `timesheets` table (to be finalized together — not detailed per-person here to avoid drift; whoever picks up Employee screens first should draft `employee_tasks`/`timesheets` and circulate for the other two to review before building against it).
**Coordination rule:** any schema or endpoint under `/api/v1/employee/*` needs sign-off from all three before merging, since Admin (approvals/assignment), Client (document/timeline visibility), and Worker (shared site/task coordination, similar `tasks`/`task_updates` pattern) all touch it indirectly.
