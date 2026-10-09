# Ripal Design Flutter Widget Tree

Every screen in `lib/screen/` in the same full format.
Each tree covers all main widgets: shell, AppBar (leading / title / actions), body, FAB, BottomNav.

```text
How to read this file
├── └── = child widget (indentation = inside parent)
├── (...) = what the widget shows / does
├── AppBar always split into leading / title / actions
└── body / FloatingActionButton / CustomBottomNavBar always shown when present
```

## Shared Shell

```text
MainScaffold (StatefulWidget - shell for admin / client / dashboard / settings)
└── Scaffold
    ├── AppBar
    │   ├── leading
    │   │   └── IconButton (grid icon -> DashboardScreen, or custom per screen)
    │   ├── title
    │   │   └── Text (screen title)
    │   └── actions
    │       ├── AppNotificationIcon (bell)
    │       └── profile photo button (-> SettingsScreen)
    ├── body (screen content)
    ├── FloatingActionButton (only when onFabPressed is set)
    │   └── Icon (add +)
    └── CustomBottomNavBar
        └── Container
            └── Row
                ├── nav item (icon + label Home)
                ├── nav item (icon + label Leave / Project)
                ├── space for FAB
                ├── nav item (icon + label Upload / Finance / Contact)
                └── nav item (icon + label Profile / Settings)
```

---

## Auth Screens (`lib/screen/auth/`)

### auth/splashscreen.dart - SplashScreen (StatefulWidget)

```text
SplashScreen (StatefulWidget)
└── Scaffold
    └── SafeArea
        └── Stack (full screen layers)
            ├── Positioned (top left)
            │   └── CustomPaint (corner lines)
            ├── Positioned (bottom right)
            │   └── CustomPaint (corner lines)
            └── Center
                └── Column
                    ├── Image.asset (app logo)
                    ├── Text (Ripal Design)
                    └── Text (ARCHITECTURAL EXCELLENCE)
```

### auth/login_screen.dart - LoginScreen (StatefulWidget, file class is LoginScreen / login_Screen)

```text
login_Screen (StatefulWidget)
└── Scaffold
    └── SafeArea
        └── Column
            ├── Expanded (top logo area)
            │   └── SizedBox (full width)
            │       └── Stack
            │           └── Padding
            │               └── Text (Ripal Design)
            └── Expanded (white login card)
                └── Container (white, round top)
                    └── SingleChildScrollView
                        └── Column
                            ├── Text (Welcome Back)
                            ├── Container (small divider line)
                            ├── CustomTextField (email)
                            ├── CustomTextField (password)
                            ├── Align (right)
                            │   └── TextButton (Forgot Password?)
                            ├── CustomButton (Sign In)
                            ├── Row (Or sign in with line)
                            │   ├── Divider
                            │   ├── Text (Or sign in with)
                            │   └── Divider
                            ├── OutlinedButton (Continue With Google)
                            │   └── Row
                            │       ├── Image (google logo)
                            │       └── Text (Continue With Google)
                            └── Row (no account row)
                                ├── Text (Don't have an account?)
                                └── GestureDetector (-> SignupScreen)
                                    └── Text (Sign Up)
```

### auth/signup_screen.dart - SignupScreen (StatefulWidget)

```text
SignupScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    │   ├── leading
    │   │   └── IconButton (back arrow -> back)
    │   ├── title
    │   │   └── Text (Ripal Design)
    │   └── actions (none)
    ├── body
    │   └── SafeArea
    │       └── SingleChildScrollView
    │           └── Column
    │               ├── Text (Begin Your Journey)
    │               ├── Text (Choose your role message)
    │               ├── CustomTextField (FULL NAME)
    │               ├── CustomTextField (EMAIL ADDRESS)
    │               ├── CustomTextField (PASSWORD)
    │               ├── CustomTextField (CONFIRM PASSWORD)
    │               ├── Row (terms row)
    │               │   ├── Checkbox (agree terms)
    │               │   └── RichText (Terms of Service and Privacy Policy)
    │               ├── CustomButton (Create Account)
    │               └── Row (have account row)
    │                   ├── Text (Already have an account?)
    │                   └── GestureDetector (-> back to Login)
    │                       └── Text (Sign In)
```

### auth/forgot_password_screen.dart - ForgotPasswordScreen (StatefulWidget)

```text
ForgotPasswordScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    │   ├── leading
    │   │   └── IconButton (back arrow -> back)
    │   ├── title
    │   │   └── Text (Ripal Design)
    │   └── actions (none)
    ├── body
    │   └── SafeArea
    │       └── LayoutBuilder
    │           └── SingleChildScrollView
    │               └── Column
    │                   ├── Text (Reset Password)
    │                   ├── Text (Enter your email message)
    │                   ├── CustomTextField (EMAIL ADDRESS)
    │                   ├── CustomButton (Send Reset Link)
    │                   └── Center
    │                       └── TextButton.icon (Back to Login)
    │                           ├── Icon (back arrow)
    │                           └── Text (Back to Login)
```

### auth/upload_profile_photo_screen.dart - UploadProfilePhotoScreen (StatefulWidget)

```text
UploadProfilePhotoScreen (StatefulWidget)
└── MainScaffold
    ├── AppBar (from MainScaffold)
    │   ├── leading
    │   │   └── IconButton (back arrow)
    │   ├── title
    │   │   └── Text (Profile Photo)
    │   └── actions
    │       ├── AppNotificationIcon
    │       └── profile image button
    ├── body
    │   └── SafeArea
    │       └── SingleChildScrollView
    │           └── Column
    │               ├── Center (photo circle)
    │               │   └── Stack
    │               │       ├── CustomPaint (dashed circle border)
    │               │       └── Container (photo circle)
    │               │           └── ClipOval (profile image)
    │               ├── Text (Refine Your Identity)
    │               ├── Text (update photo message)
    │               ├── ElevatedButton.icon (Upload Photo)
    │               ├── ElevatedButton.icon (Take Photo)
    │               └── Container (info box)
    │                   └── Row
    │                       ├── Icon (info)
    │                       └── Text (MAX SIZE 5MB note)
    ├── FloatingActionButton
    │   └── Icon (add)
    └── CustomBottomNavBar
```

---

## Shared Screens (`lib/screen/` root)

### dashboard_screen.dart - DashboardScreen (StatefulWidget, role branches)

```text
DashboardScreen - Client View (StatefulWidget)
└── MainScaffold (role: client)
    ├── AppBar (from MainScaffold)
    │   ├── leading
    │   │   └── IconButton (grid icon)
    │   ├── title
    │   │   └── Text (Ripal Design)
    │   └── actions
    │       ├── AppNotificationIcon
    │       └── profile image button
    ├── body
    │   └── IndexedStack (tab switcher)
    │       ├── Home tab
    │       │   └── SafeArea
    │       │       └── SingleChildScrollView
    │       │           └── Column
    │       │               ├── Text (Welcome our Side)
    │       │               ├── Text (subtitle message)
    │       │               ├── Row (Active Portfolio + View Management link)
    │       │               ├── PortfolioCard (Sahara Retreat)
    │       │               ├── PortfolioCard (Vertical Garden)
    │       │               └── PortfolioCard (Lake Obsidian)
    │       ├── Projects tab
    │       │   └── ClientProjectView
    │       ├── Contact tab
    │       │   └── ClientContactus
    │       └── Settings tab
    │           └── SettingsScreen
    ├── FloatingActionButton
    │   └── Icon (add)
    └── CustomBottomNavBar
```

```text
DashboardScreen - Admin View (StatefulWidget)
└── MainScaffold (role: admin)
    ├── AppBar (from MainScaffold, same as above)
    ├── body
    │   └── SafeArea
    │       └── SingleChildScrollView
    │           └── Column
    │               ├── Text (DASHBOARD OVERVIEW)
    │               ├── Text (Welcome Yash)
    │               ├── RichText (You have 12 Active Projects)
    │               ├── Container (stat card TOTAL REVENUE)
    │               ├── Container (stat card ACTIVE PROJECTS)
    │               ├── Container (stat card TEAM VELOCITY)
    │               ├── Row (Projects + EXPLORE PROJECTS link)
    │               ├── ListView (project cards side scroll)
    │               │   ├── project card (Skyline Plaza)
    │               │   └── project card (Azure Heights)
    │               ├── Text (Quick Actions)
    │               └── GridView (8 action buttons: New Project, Upload, Users, Files, Leave, Finance, Invoice, Settings)
    ├── FloatingActionButton
    │   └── Icon (add)
    └── CustomBottomNavBar
```

```text
DashboardScreen - Worker View (StatefulWidget)
└── MainScaffold (role: worker)
    ├── AppBar (from MainScaffold, same as above)
    ├── body
    │   └── SafeArea
    │       └── SingleChildScrollView
    │           └── Column
    │               ├── Text (DASHBOARD OVERVIEW)
    │               ├── Text (Welcome, user name)
    │               ├── RichText (You have 12 Active Projects)
    │               ├── Container (stat card ACTIVE PROJECTS 15)
    │               ├── Container (stat card TEAM VELOCITY 30)
    │               ├── Row (Assigned Projects + EXPLORE link)
    │               ├── ListView (assigned project cards)
    │               ├── Text (Quick Actions)
    │               └── GridView (6 actions: View Project, Upload Files, Team View, File Views, Leave, Activity)
    ├── FloatingActionButton
    │   └── Icon (add)
    └── CustomBottomNavBar
```

### settings_screen.dart - SettingsScreen (StatefulWidget)

```text
SettingsScreen (StatefulWidget)
└── MainScaffold
    ├── AppBar (from MainScaffold)
    │   ├── leading
    │   │   └── IconButton (grid icon)
    │   ├── title
    │   │   └── Text (Settings)
    │   └── actions
    │       ├── AppNotificationIcon
    │       └── profile image button (-> upload photo)
    ├── body
    │   └── SafeArea
    │       └── SingleChildScrollView
    │           └── Column
    │               ├── Column (profile top)
    │               │   ├── GestureDetector (-> upload photo)
    │               │   │   └── Stack
    │               │   │       ├── CircleAvatar (profile image)
    │               │   │       └── Container (edit dot)
    │               │   │           └── Icon (edit)
    │               │   ├── Text (user name)
    │               │   └── Text (user email)
    │               ├── SettingGroup (ACCOUNT)
    │               │   ├── SettingTile (Profile Information)
    │               │   └── SettingTile (Security and Password)
    │               ├── SettingGroup (NOTIFICATIONS)
    │               │   ├── SettingSwitchTile (Push Notifications)
    │               │   └── SettingSwitchTile (Email Reports)
    │               ├── SettingGroup (PREFERENCES)
    │               │   ├── SettingTile (Appearance)
    │               │   └── SettingTile (Language)
    │               ├── SettingGroup (ABOUT and HELP)
    │               │   ├── SettingTile (Help and Support)
    │               │   ├── SettingTile (Privacy Policy)
    │               │   └── SettingTile (About Ripal Design)
    │               └── OutlinedButton.icon (Logout)
    ├── FloatingActionButton
    │   └── Icon (add)
    └── CustomBottomNavBar
```

### edit_profile_screen.dart - EditProfileScreen (StatefulWidget)

```text
EditProfileScreen (StatefulWidget)
└── MainScaffold
    ├── AppBar (from MainScaffold)
    │   ├── leading
    │   │   └── IconButton (back arrow)
    │   ├── title
    │   │   └── Text (Edit Profile)
    │   └── actions
    │       ├── AppNotificationIcon
    │       └── profile image button
    ├── body
    │   └── SafeArea
    │       └── SingleChildScrollView
    │           └── Column
    │               ├── Center (photo)
    │               │   └── GestureDetector (-> upload photo)
    │               │       └── Stack
    │               │           ├── Container (photo + camera dot)
    │               │           ├── ClipOval (profile image)
    │               │           └── Container (camera dot)
    │               │                └── Icon (camera)
    │               ├── Center
    │               │   └── Text (CHANGE PHOTO)
    │               ├── Text (BASIC INFORMATION)
    │               ├── input field (FULL NAME)
    │               ├── input field (EMAIL ADDRESS)
    │               ├── input field (PHONE NUMBER)
    │               ├── input field (MAILING ADDRESS)
    │               ├── input field (CITY)
    │               ├── input field (STATE)
    │               ├── input field (PIN CODE)
    │               └── ElevatedButton (Save Profile)
    ├── FloatingActionButton
    └── CustomBottomNavBar
```

### placeholder_screen.dart - PlaceholderScreen (StatelessWidget)

```text
PlaceholderScreen (StatelessWidget)
└── Scaffold
    ├── AppBar
    │   ├── leading
    │   │   └── IconButton (back arrow -> back)
    │   ├── title
    │   │   └── Text (screen title)
    │   └── actions (none)
    └── body
        └── Center
            └── Column
                ├── Icon (construction icon)
                ├── Text (screen title)
                └── Text (under development message)
```

### invoice_pdf_preview_screen.dart - InvoicePdfPreviewScreen (StatelessWidget)

```text
InvoicePdfPreviewScreen (StatelessWidget)
└── Scaffold
    ├── AppBar
    │   ├── leading
    │   │   └── IconButton (back arrow -> back)
    │   ├── title
    │   │   └── Text (invoice ID + PDF Preview)
    │   └── actions (none)
    └── body
        └── PdfPreview (pdf viewer)
            └── Invoice PDF page
                ├── Row (company header RIPAL DESIGN + TAX INVOICE)
                ├── Table (invoice items)
                ├── Row (subtotal and tax)
                └── Row (total and signature)
```

---

## Admin Screens (`lib/screen/admin/`)

### admin/admin_activity_screen.dart - AdminActivityScreen (StatefulWidget)

```text
AdminActivityScreen (StatefulWidget)
└── RoleGuardedScreen (allows admin, employee)
    └── MainScaffold
        ├── AppBar (from MainScaffold)
        │   ├── leading
        │   │   └── IconButton (back arrow -> back)
        │   ├── title
        │   │   └── Text (SITE LOG)
        │   └── actions
        │       └── AppNotificationIcon
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── Row (step tracker)
        │               │   ├── GestureDetector (step 1 DETAILS)
        │               │   │   └── Column (circle + Text)
        │               │   ├── Expanded (divider line)
        │               │   ├── GestureDetector (step 2 Team)
        │               │   │   └── Column (circle + Text)
        │               │   ├── Expanded (divider line)
        │               │   ├── GestureDetector (step 3 Files)
        │               │   │   └── Column (circle + Text)
        │               │   ├── Expanded (divider line)
        │               │   └── GestureDetector (step 4 Activity - active)
        │               │       └── Column (circle + Text)
        │               ├── Text (ACTIVITY FEED)
        │               ├── Text (Live Construction Log)
        │               ├── Container (feed card file uploaded + icon + time)
        │               ├── Container (feed card progress updated + progress bar)
        │               ├── Container (feed card team member added)
        │               ├── Container (feed card planning complete)
        │               ├── Container (feed card image uploaded)
        │               ├── SizedBox (full width)
        │               │   └── OutlinedButton (Save Draft)
        │               └── SizedBox (full width)
        │                   └── ElevatedButton (Finish Project)
        │                       └── Row
        │                           ├── Text (Finish Project)
        │                           └── Icon (check circle)
        ├── FloatingActionButton
        │   └── Icon (add)
        └── CustomBottomNavBar
```

### admin/admin_user_management_screen.dart - AdminUserManagementScreen (StatefulWidget)

```text
AdminUserManagementScreen (StatefulWidget)
└── RoleGuardedScreen (allows admin)
    └── MainScaffold
        ├── AppBar (from MainScaffold)
        │   ├── leading (default grid icon)
        │   ├── title
        │   │   └── Text (Management)
        │   └── actions
        │       ├── IconButton (add user +)
        │       └── AppNotificationIcon
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── Container (stat card TOTAL USERS + icon)
        │               ├── Container (stat card ACTIVE NOW + icon)
        │               ├── Container (stat card NEW THIS WEEK + icon)
        │               ├── SingleChildScrollView (horizontal)
        │               │   └── Row (filter chips)
        │               │       ├── filter chip (All Users)
        │               │       ├── filter chip (Clients)
        │               │       ├── filter chip (Workers)
        │               │       └── filter chip (Architects)
        │               ├── Row (Sort by Recently Active + filter icon)
        │               └── Container (user table card)
        │                   └── Column
        │                       ├── Container
        │                       │   └── Row (table header USER PROFILE / ROLE)
        │                       ├── Row (user row: photo + name + email + role badge)
        │                       ├── Row (user row: photo + name + email + role badge)
        │                       ├── Row (user row: photo + name + email + role badge)
        │                       └── Row (page info + prev / next buttons)
        └── CustomBottomNavBar
```

### admin/admin_team_screen.dart - AdminTeamScreen (StatefulWidget)

```text
AdminTeamScreen (StatefulWidget)
└── RoleGuardedScreen (allows admin, employee)
    └── MainScaffold
        ├── AppBar (from MainScaffold)
        │   ├── leading
        │   │   └── IconButton (back arrow -> back)
        │   ├── title
        │   │   └── Text (project name)
        │   └── actions (none)
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── Row (top workflow header)
        │               │   ├── Row
        │               │   │   ├── Icon (folder)
        │               │   │   └── Text (PROJECT WORKFLOW)
        │               │   └── Container (pill)
        │               │       └── Text (PROGRESS 50%)
        │               ├── Text (project name big)
        │               ├── Row (step tracker, step 2 Team active)
        │               │   ├── GestureDetector (step 1 DETAILS)
        │               │   │   └── Column (circle + Text)
        │               │   ├── Expanded (divider line)
        │               │   ├── GestureDetector (step 2 Team - active)
        │               │   │   └── Column (circle + Text)
        │               │   ├── Expanded (divider line)
        │               │   ├── GestureDetector (step 3 Files)
        │               │   │   └── Column (circle + Text)
        │               │   ├── Expanded (divider line)
        │               │   └── GestureDetector (step 4 Activity)
        │               │       └── Column (circle + Text)
        │               ├── Container (search box)
        │               │   └── TextField (Search by name, department + search icon)
        │               ├── Row (section header)
        │               │   ├── Text (Add Team Member)
        │               │   └── Row
        │               │       ├── Icon (filter list)
        │               │       └── Text (FILTERS)
        │               ├── Container (team member card x 3)
        │               │   └── Row
        │               │       ├── Container (initials box DD / RS / YV)
        │               │       │   └── Text (initials)
        │               │       └── Expanded
        │               │           └── Column
        │               │               ├── Text (member name)
        │               │               ├── Text (role)
        │               │               └── Text (email)
        │               ├── SizedBox (full width)
        │               │   └── OutlinedButton (Add Member -> crew picker popup)
        │               ├── SizedBox (full width)
        │               │   └── OutlinedButton (Add Manually -> add form popup)
        │               ├── SizedBox (full width)
        │               │   └── OutlinedButton (Save Draft)
        │               └── SizedBox (full width)
        │                   └── ElevatedButton (Next -> Upload Files)
        │                       └── Row
        │                           ├── Text (Next)
        │                           └── Icon (forward arrow)
        ├── FloatingActionButton
        │   └── Icon (add)
        └── CustomBottomNavBar
```

Popups from this screen:

```text
Add Member popup
└── DraggableScrollableSheet
    └── Padding
        └── Column
            ├── Row (popup header)
            │   ├── Row
            │   │   ├── IconButton (back arrow -> close)
            │   │   └── Column
            │   │       ├── Text (PROJECT DETAILS small)
            │   │       └── Text (Test 1)
            │   └── ElevatedButton (Save -> close)
            ├── Text (Execution Crew)
            └── Expanded
                └── ListView (crew list)
                    └── Container (crew card)
                        └── Row
                            ├── Container (initials box)
                            │   └── Text (initials)
                            ├── Expanded
                            │   └── Column
                            │       ├── Text (name)
                            │       ├── Text (role)
                            │       └── Text (email)
                            └── ElevatedButton (Assign / Assigned)
```

```text
Add Manually popup
└── Padding
    └── SingleChildScrollView
        └── Column
            ├── Row (popup header)
            │   ├── IconButton (close X)
            │   └── Text (Add Team Member)
            ├── Column (NAME field)
            │   ├── Text (NAME label)
            │   └── TextField (Enter Worker Name)
            ├── Column (ROLE field)
            │   ├── Text (ROLE label)
            │   └── TextField (Enter Role)
            ├── Column (CONTACT field)
            │   ├── Text (CONTACT label)
            │   └── TextField (Enter contact details)
            └── Row (bottom buttons)
                ├── Expanded
                │   └── OutlinedButton (Cancel)
                └── Expanded
                    └── ElevatedButton (Add Member)
```

### admin/admin_leave_screen.dart - AdminLeaveScreen (StatefulWidget)

```text
AdminLeaveScreen (StatefulWidget)
└── RoleGuardedScreen (allows admin, employee)
    └── MainScaffold
        ├── AppBar (from MainScaffold)
        │   ├── leading
        │   │   └── IconButton (grid icon, does nothing)
        │   ├── title
        │   │   └── Text (Leave Management)
        │   └── actions
        │       ├── IconButton (history -> Leave History screen)
        │       └── AppNotificationIcon (bell)
        ├── body
        │   └── SafeArea
        │       ├── IF loading
        │       │   └── Center
        │       │       └── CircularProgressIndicator
        │       └── ELSE
        │           └── SingleChildScrollView
        │               └── Column
        │                   ├── Container (stat card Pending Requests)
        │                   │   └── Column
        │                   │       ├── Row
        │                   │       │   ├── Text (Pending Requests)
        │                   │       │   └── Container (badge Urgent / All Clear)
        │                   │       └── Text (pending count big)
        │                   ├── Container (stat card On Leave Today)
        │                   │   └── Column
        │                   │       ├── Text (On Leave Today)
        │                   │       ├── Row (count + / 20 total)
        │                   │       └── Row (3 overlapping circle photos)
        │                   ├── Container (stat card Available Staff)
        │                   │   └── Column
        │                   │       ├── Row (Available Staff + Optimal badge)
        │                   │       ├── Text (available count big)
        │                   │       └── Row (tick Icon + Studio at 80% capacity)
        │                   ├── Row (section header)
        │                   │   ├── Expanded
        │                   │   │   └── Text (Priority Requests)
        │                   │   └── GestureDetector (-> Leave History)
        │                   │       └── Container (red button: history Icon + Leave History Text)
        │                   ├── IF no pending
        │                   │   └── Container (empty box: green tick Icon +2 Texts)
        │                   └── ELSE (one card per request)
        │                       └── Padding
        │                           └── Container (leave request card)
        │                               └── Column
        │                                   ├── Row (person top)
        │                                   │   ├── CircleAvatar (name first letter)
        │                                   │   └── Expanded
        │                                   │       └── Column
        │                                   │           ├── Text (applicant name)
        │                                   │           ├── Text (role and leave type)
        │                                   │           └── Row (calendar Icon + date range)
        │                                   └── Row (bottom buttons)
        │                                       ├── Expanded
        │                                       │   └── OutlinedButton (Reject)
        │                                       └── Expanded
        │                                           └── ElevatedButton (Approve)
        ├── FloatingActionButton (-> Create Project)
        │   └── Icon (add)
        └── CustomBottomNavBar
```

### admin/admin_leave_history_screen.dart - AdminLeaveHistoryScreen (StatefulWidget)

```text
AdminLeaveHistoryScreen (StatefulWidget)
└── RoleGuardedScreen (allows admin, employee)
    └── MainScaffold
        ├── AppBar (from MainScaffold)
        │   ├── leading
        │   │   └── IconButton (back arrow -> back)
        │   ├── title
        │   │   └── Text (Leave History)
        │   └── actions
        │       └── AppNotificationIcon (bell)
        ├── body
        │   └── SafeArea
        │       ├── IF loading
        │       │   └── Center
        │       │       └── CircularProgressIndicator
        │       └── ELSE
        │           └── SingleChildScrollView
        │               └── Column
        │                   ├── Row (top metric cards)
        │                   │   ├── Expanded
        │                   │   │   └── Container (metric card BALANCE)
        │                   │   │       └── Stack
        │                   │   │           ├── Container (left red side bar)
        │                   │   │           └── Column (BALANCE label + 12 Days value)
        │                   │   └── Expanded
        │                   │       └── Container (metric card PENDING)
        │                   │           └── Stack
        │                   │               ├── Container (left red side bar)
        │                   │               └── Column (PENDING label + requests value)
        │                   ├── Row (section header)
        │                   │   ├── Container (3px red bar)
        │                   │   └── Text (Request History)
        │                   ├── IF no records
        │                   │   └── Center
        │                   │       └── Text (No leave records found)
        │                   └── ELSE (one card per record)
        │                       └── Padding
        │                           └── Container (history card)
        │                               └── Column
        │                                   ├── Row (top row)
        │                                   │   ├── Text (applied date + applicant name)
        │                                   │   └── Container (status badge PENDING/APPROVED/REJECTED)
        │                                   ├── Text (leave type big)
        │                                   └── Row (bottom row: type Icon + date range + duration)
        ├── FloatingActionButton (-> Create Project)
        │   └── Icon (add)
        └── CustomBottomNavBar
```

### admin/admin_finance_screen.dart - AdminFinanceScreen (StatefulWidget)

```text
AdminFinanceScreen (StatefulWidget)
└── RoleGuardedScreen (allows admin)
    └── MainScaffold
        ├── AppBar (from MainScaffold)
        │   ├── leading
        │   │   └── IconButton (grid icon)
        │   ├── title
        │   │   └── Text (Finance)
        │   └── actions (none)
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── Text (STUDIO FINANCIAL GATEWAY)
        │               ├── Text (Q3 Project Portfolios)
        │               ├── Container (budget card)
        │               │   └── Column
        │               │       ├── Text (TOTAL PROJECT BUDGET + amount)
        │               │       ├── Text (AMOUNT INVOICED + progress bar)
        │               │       └── Text (OUTSTANDING BALANCE + progress bar)
        │               ├── Container (round gauge card)
        │               │   └── Column
        │               │       ├── Stack (round gauge)
        │               │       │   ├── CustomPaint (donut gauge)
        │               │       │   └── Column (68% + REVENUE GOAL)
        │               │       ├── Text (Budget Utilization)
        │               │       └── Text (description)
        │               ├── Row (Recent Transactions + VIEW ALL link -> Invoice)
        │               └── Container (transactions card)
        │                   └── Column
        │                       ├── Row (DETAILS / STATUS header)
        │                       ├── Row (transaction: name + amount + status badge)
        │                       ├── Row (transaction: name + amount + status badge)
        │                       └── Row (transaction: name + amount + status badge)
        └── CustomBottomNavBar
```

### admin/admin_invoice_screen.dart - AdminInvoiceScreen (StatefulWidget)

```text
AdminInvoiceScreen (StatefulWidget)
└── RoleGuardedScreen (allows admin)
    └── MainScaffold
        ├── AppBar (from MainScaffold)
        │   ├── leading
        │   │   └── IconButton (back arrow -> back)
        │   ├── title
        │   │   └── Text (Invoice)
        │   └── actions (none, add button is in body)
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── Row (studio header)
        │               │   ├── Column (RIPAL DESIGN STUDIO + Tax Invoice)
        │               │   └── IconButton (add + -> Create Invoice)
        │               ├── Row (invoice no + PENDING badge)
        │               ├── Text (ISSUED date)
        │               ├── Container (client card)
        │               │   └── Column
        │               │       ├── Text (CLIENT + client name)
        │               │       └── Row (DUE DATE + TOTAL DUE)
        │               ├── Text (SERVICE BREAKDOWN)
        │               ├── Column (service row: title + amount)
        │               ├── Column (service row: title + amount)
        │               ├── Column (service row: title + amount)
        │               ├── Row (SUBTOTAL + amount)
        │               ├── Text (HISTORY)
        │               ├── Row (timeline item: dot + date + text generated)
        │               ├── Row (timeline item: dot + date + text viewed)
        │               ├── SizedBox (full width)
        │               │   └── ElevatedButton.icon (SHARE PDF)
        │               └── SizedBox (full width)
        │                   └── OutlinedButton.icon (DOWNLOAD RECEIPT)
        └── CustomBottomNavBar
```

### admin/admin_create_invoice_screen.dart - AdminCreateInvoiceScreen (StatefulWidget, plain Scaffold)

```text
AdminCreateInvoiceScreen (StatefulWidget)
└── RoleGuardedScreen (allows admin)
    └── Scaffold
        ├── AppBar
        │   ├── leading
        │   │   └── IconButton (close X -> back)
        │   ├── title
        │   │   └── Text (Create Invoice)
        │   └── actions
        │       └── Container (DRAFTS badge Text)
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── Text (CLIENT label)
        │               ├── Container
        │               │   └── DropdownButton (select client)
        │               ├── Text (INVOICE NUMBER + number)
        │               ├── Text (ISSUE DATE + date)
        │               ├── Text (DUE DATE + date)
        │               ├── Text (SERVICE BREAKDOWN)
        │               ├── Container (item card: title + price)
        │               ├── GestureDetector (add line item row: + Icon + Text)
        │               ├── Row (TAX box + DISCOUNT box)
        │               ├── Container (totals card)
        │               │   └── Column
        │               │       ├── Row (Subtotal + amount)
        │               │       ├── Row (Tax + amount)
        │               │       ├── Row (Discount + amount)
        │               │       └── Row (Total + amount)
        │               ├── SizedBox (full width)
        │               │   └── ElevatedButton (Generate Invoice)
        │               └── SizedBox (full width)
        │                   └── ElevatedButton (Save Draft)
```

### admin/admin_create_project.dart - AdminCreateProject (StatefulWidget)

```text
AdminCreateProject (StatefulWidget)
└── RoleGuardedScreen (allows admin, employee)
    └── MainScaffold
        ├── AppBar (from MainScaffold)
        │   ├── leading
        │   │   └── IconButton (close X -> back)
        │   ├── title
        │   │   └── Text (New Project)
        │   └── actions (none)
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── Row (step tracker, step 1 DETAILS active)
        │               │   ├── step (DETAILS circle + Text)
        │               │   ├── Expanded (divider)
        │               │   ├── step (Team circle + Text)
        │               │   ├── Expanded (divider)
        │               │   ├── step (Files circle + Text)
        │               │   ├── Expanded (divider)
        │               │   └── step (Activity circle + Text)
        │               ├── Text (Project Vision)
        │               ├── Text (description)
        │               ├── Column (input PROJECT NAME: label + TextField)
        │               ├── Column (dropdown SECTOR/TYPOLOGY)
        │               ├── Column (input ESTIMATED TIMELINE + TextField)
        │               ├── Column (input PROJECT DESCRIPTION + TextField)
        │               ├── Column (input TARGET BUDGET RANGE + TextField)
        │               ├── Text (Owner / Client)
        │               ├── Column (input Owner Name + TextField)
        │               ├── Column (input Owner Email + TextField)
        │               ├── Column (input Owner phone + TextField)
        │               ├── SizedBox (full width)
        │               │   └── OutlinedButton (Save Draft)
        │               └── SizedBox (full width)
        │                   └── ElevatedButton (Next)
        │                       └── Row
        │                           ├── Text (Next)
        │                           └── Icon (forward arrow)
        └── CustomBottomNavBar
```

### admin/admin_project_detail_screen.dart - AdminProjectDetailScreen (StatefulWidget)

```text
AdminProjectDetailScreen (StatefulWidget)
└── RoleGuardedScreen (allows admin, employee)
    └── MainScaffold
        ├── AppBar (from MainScaffold)
        │   ├── leading
        │   │   └── IconButton (back arrow -> back)
        │   ├── title
        │   │   └── Text (project name upper case)
        │   └── actions
        │       └── AppNotificationIcon
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── Row (step tracker, step 1 active)
        │               ├── Container (big project photo banner)
        │               │   └── Stack
        │               │       ├── project image (checkered placeholder + gradient)
        │               │       └── Column (status badges + name + location)
        │               │           ├── Row (UNDER CONSTRUCTION + 75% COMPLETE badges)
        │               │           ├── Text (project name)
        │               │           └── Row (location Icon + location Text)
        │               ├── Column (info CLIENT + name)
        │               ├── Column (info BUDGET + amount)
        │               ├── Column (info TIMELINE + dates)
        │               ├── Column (info TYPE + type)
        │               ├── Text (Key Milestones)
        │               ├── Container (milestone card: title + status)
        │               ├── Container (milestone card: title + status)
        │               ├── Container (milestone card: title + status)
        │               ├── Text (PROJECT TEAM)
        │               ├── Container (team card: photo + name + role + tick Icon)
        │               ├── Container (team card: photo + name + role + tick Icon)
        │               ├── Row (SITE GALLERY + VIEW ALL)
        │               └── Row (3 gallery photo boxes)
        └── CustomBottomNavBar
```

### admin/admin_upload_file_screen.dart - AdminUploadFileScreen (StatefulWidget)

```text
AdminUploadFileScreen (StatefulWidget)
└── RoleGuardedScreen (allows admin, employee)
    └── MainScaffold
        ├── AppBar (from MainScaffold)
        │   ├── leading
        │   │   └── IconButton (back arrow -> back)
        │   ├── title
        │   │   └── Text (Upload Files)
        │   └── actions (none)
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── Row (step tracker, step 3 Files active)
        │               ├── Text (Submit Blueprints)
        │               ├── Text (file type message)
        │               ├── GestureDetector (dashed upload box)
        │               │   └── Container
        │               │       └── Column
        │               │           ├── Container (circle upload Icon)
        │               │           ├── Text (Drop files here or browse)
        │               │           ├── Text (max size note)
        │               │           ├── ElevatedButton (Select Project Files)
        │               │           └── ElevatedButton (View Project Files)
        │               ├── Row (Active Syncing + files count)
        │               ├── Container (sync file card: file Icon + name + progress bar + % + close Icon)
        │               ├── SizedBox (full width)
        │               │   └── OutlinedButton (Save Draft)
        │               └── SizedBox (full width)
        │                   └── ElevatedButton (Next)
        │                       └── Row (Text Next + forward Icon)
        └── CustomBottomNavBar
```

### admin/admin_file_view_screen.dart - AdminFileViewScreen (StatefulWidget)

```text
AdminFileViewScreen (StatefulWidget)
└── RoleGuardedScreen (allows admin, employee)
    └── MainScaffold
        ├── AppBar (from MainScaffold)
        │   ├── leading
        │   │   └── IconButton (back arrow -> back)
        │   ├── title
        │   │   └── Text (File View)
        │   └── actions
        │       └── AppNotificationIcon
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── Text (View Project Files)
        │               ├── Text (description message)
        │               ├── Container (search box)
        │               │   └── TextField (Search blueprints + search Icon)
        │               ├── SizedBox (full width)
        │               │   └── ElevatedButton.icon (Upload File -> Upload screen)
        │               ├── SingleChildScrollView (horizontal)
        │               │   └── Row (filter chips Contracts / All Assets / Blueprints)
        │               ├── Row (Blueprints + View All)
        │               ├── ListView (blueprint cards side scroll: preview + file name + meta)
        │               ├── Text (Contracts)
        │               ├── Container (contract row: file name + status)
        │               ├── Container (contract row: file name + status)
        │               ├── Container (contract row: file name + status)
        │               ├── Row (Site Photos + Browse Gallery)
        │               ├── GridView (4 site photo boxes)
        │               ├── Text (WalkThrough)
        │               ├── Container (video box + play button + title)
        │               ├── Container (media row: thumb + file name)
        │               ├── Container (media row: thumb + file name)
        │               └── Container (media row: thumb + file name)
        └── CustomBottomNavBar
```

---

## Client Screens (`lib/screen/client/`)

### client/client_project_view.dart - ClientProjectView (StatefulWidget)

```text
ClientProjectView (StatefulWidget)
└── MainScaffold (role: client)
    ├── AppBar (from MainScaffold)
    │   ├── leading
    │   │   └── IconButton (grid icon)
    │   ├── title
    │   │   └── Text (Projects)
    │   └── actions
    │       ├── AppNotificationIcon
    │       └── profile image button
    ├── body
    │   └── SafeArea
    │       └── Column
    │           ├── Padding
    │           │   └── TextField (Search projects + search Icon)
    │           ├── SingleChildScrollView (horizontal)
    │           │   └── Row (filter chips ALL / RESIDENTIAL / COMMERCIAL / INTERIOR + count badge)
    │           └── Expanded (project list, 2 columns)
    │               ├── Column (left projects)
    │               │   └── ProjectCard (-> Project Detail)
    │               └── Column (right projects)
    │                   └── ProjectCard (-> Project Detail)
    ├── FloatingActionButton (-> Apply form / Create Project)
    │   └── Icon (add)
    └── CustomBottomNavBar
```

### client/client_project_detail_screen.dart - ClientProjectDetailScreen (StatelessWidget)

```text
ClientProjectDetailScreen (StatelessWidget)
└── Scaffold
    ├── AppBar
    │   ├── leading
    │   │   └── IconButton (back arrow -> back)
    │   ├── title
    │   │   └── Text (project name upper case)
    │   └── actions
    │       ├── AppNotificationIcon
    │       └── SizedBox (spacing)
    ├── body
    │   └── SafeArea
    │       └── SingleChildScrollView
    │           └── Column
    │               ├── Container (big photo banner)
    │               │   └── Stack
    │               │       ├── project image
    │               │       └── Column (type badge + name + progress row)
    │               ├── Text (PROJECT GALLERY label)
    │               ├── SizedBox
    │               │   └── ListView (gallery photos side scroll)
    │               ├── Text (PROJECT PROGRESS label)
    │               ├── Container (progress card + progress bar)
    │               ├── Text (PROJECT DETAILS label)
    │               ├── Container (details card TYPE / TIMELINE / LOCATION / CLIENT / BUDGET rows)
    │               ├── Text (MILESTONE STATUS label)
    │               └── Container (milestone timeline with tick icons)
```

### client/client_applay.dart - ClientApplay (StatefulWidget, job apply form)

```text
ClientApplay (StatefulWidget)
└── MainScaffold (role: client)
    ├── AppBar (from MainScaffold)
    │   ├── leading
    │   │   └── IconButton (grid icon)
    │   ├── title
    │   │   └── Text (Ripal Design)
    │   └── actions
    │       ├── AppNotificationIcon
    │       └── profile image button
    ├── body
    │   └── SafeArea
    │       └── SingleChildScrollView
    │           └── Form
    │               └── Column
    │                   ├── Text (Join the Firm)
    │                   ├── Text (subtitle message)
    │                   ├── SectionHeader (PERSONAL DETAILS)
    │                   ├── CustomTextField (FULL NAME)
    │                   ├── CustomTextField (EMAIL ADDRESS)
    │                   ├── CustomTextField (PHONE NUMBER)
    │                   ├── SectionHeader (PROFESSIONAL PATH)
    │                   ├── CustomTextField (DESIRED ROLE)
    │                   ├── CustomTextField (YEAR OF EXPERIENCE)
    │                   ├── SectionHeader (CREDENTIALS and WORK)
    │                   ├── Text (CURRICULUM VITAE label)
    │                   ├── GestureDetector (upload CV box: upload Icon + texts / picked file row)
    │                   ├── CustomTextField (PORTFOLIO LINK)
    │                   ├── Text (ABOUT YOU label)
    │                   ├── TextFormField (ABOUT YOU box)
    │                   ├── CustomButton (Submit Application)
    │                   └── Center
    │                       └── Text (privacy note)
    ├── FloatingActionButton
    │   └── Icon (add)
    └── CustomBottomNavBar
```

Success popup from this screen:

```text
Success Dialog
└── Dialog
    └── Column
        ├── Container (green tick circle Icon)
        ├── Text (Form Submitted)
        ├── Text (thank you message)
        ├── Container (Ref number row)
        └── ElevatedButton (Return to Dashboard)
```

### client/client_contactus.dart - ClientContactus (StatefulWidget)

```text
ClientContactus (StatefulWidget)
└── MainScaffold (role: client)
    ├── AppBar (from MainScaffold)
    │   ├── leading
    │   │   └── IconButton (grid icon)
    │   ├── title
    │   │   └── Text (Ripal Design)
    │   └── actions
    │       ├── AppNotificationIcon
    │       └── profile image button
    ├── body
    │   └── SafeArea
    │       └── SingleChildScrollView
    │           └── Form
    │               └── Column
    │                   ├── Text (Get in Touch)
    │                   ├── Text (subtitle message)
    │                   ├── SectionHeader (START A CONVERSATION)
    │                   ├── CustomTextField (FULL NAME)
    │                   ├── CustomTextField (EMAIL ADDRESS)
    │                   ├── Column (PROJECT TYPE)
    │                   │   ├── Text (PROJECT TYPE label)
    │                   │   └── DropdownButtonFormField (Select Project Type)
    │                   ├── Column (MESSAGE)
    │                   │   ├── Text (MESSAGE label)
    │                   │   └── TextFormField (MESSAGE box)
    │                   ├── CustomButton (Send Inquiry)
    │                   ├── Divider
    │                   ├── ContactInfoRow (CALL US)
    │                   ├── ContactInfoRow (MAIL US)
    │                   └── ContactInfoRow (LOCATION)
    ├── FloatingActionButton (-> Apply form)
    │   └── Icon (add)
    └── CustomBottomNavBar
```

Success popup from this screen:

```text
Success Dialog
└── Dialog
    └── Column
        ├── Container (mail tick circle Icon)
        ├── Text (Inquiry Sent)
        ├── Text (thank you message)
        ├── Container (Ticket Ref row)
        └── ElevatedButton (Done)
```

---

## Worker Screens (`lib/screen/worker/`, own Scaffold + own AppBar + FAB + BottomNav)

### worker/worker_project_view_screen.dart - WorkerProjectViewScreen (StatefulWidget)

```text
WorkerProjectViewScreen (StatefulWidget)
└── RoleGuardedScreen (allows worker)
    └── Scaffold
        ├── AppBar
        │   ├── leading
        │   │   └── IconButton (back arrow -> back)
        │   ├── title
        │   │   └── Text (project name upper case)
        │   └── actions
        │       ├── AppNotificationIcon
        │       └── SizedBox (spacing)
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── WorkerStepHeader (step 1)
        │               ├── Container (big project photo + status badges + name + location)
        │               ├── Column (CLIENT label + name)
        │               ├── Column (BUDGET label + amount)
        │               ├── Column (TIMELINE label + dates)
        │               ├── Column (TYPE label + type)
        │               ├── Divider
        │               ├── Text (Key Milestones)
        │               ├── Container (milestone card: title + status)
        │               ├── Container (milestone card: title + status)
        │               ├── Container (milestone card: title + status)
        │               ├── Text (PROJECT TEAM label)
        │               ├── Container (team card: photo + name + role + tick Icon)
        │               ├── Container (team card: photo + name + role + tick Icon)
        │               ├── Row (SITE GALLERY + VIEW ALL)
        │               └── Row (3 gallery photo boxes)
        ├── FloatingActionButton (-> Upload Files)
        │   └── Icon (add)
        └── CustomBottomNavBar (role: worker)
```

### worker/worker_project_files_screen.dart - WorkerProjectFilesScreen (StatefulWidget)

```text
WorkerProjectFilesScreen (StatefulWidget)
└── RoleGuardedScreen (allows worker)
    └── Scaffold
        ├── AppBar
        │   ├── leading
        │   │   └── IconButton (back arrow -> back, or grid icon)
        │   ├── title
        │   │   └── Text (File View)
        │   └── actions
        │       ├── AppNotificationIcon
        │       └── SizedBox (spacing)
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── Text (View Project Files)
        │               ├── Text (subtitle message)
        │               ├── Container (search box)
        │               │   └── Row (search Icon + TextField)
        │               ├── SizedBox (full width)
        │               │   └── ElevatedButton.icon (Upload File -> Upload screen)
        │               ├── Row (filter chips Contracts / All Assets / Blueprint)
        │               ├── Row (Blueprints header + View All)
        │               ├── Container (blueprint card: preview + file name + meta)
        │               ├── Container (blueprint card: preview + file name + meta)
        │               ├── Row (Contracts header)
        │               ├── Container (contracts list card: 3 contract rows)
        │               ├── Row (Site Photos + Browse Gallery)
        │               ├── GridView (4 site photos)
        │               ├── Row (WalkThrough header)
        │               ├── Container (video box + play button + title)
        │               ├── Container (media row: thumb + file name)
        │               ├── Container (media row: thumb + file name)
        │               └── Container (media row: thumb + file name)
        ├── FloatingActionButton (-> Upload Files)
        │   └── Icon (add)
        └── CustomBottomNavBar (role: worker)
```

### worker/worker_upload_files_screen.dart - WorkerUploadFilesScreen (StatefulWidget)

```text
WorkerUploadFilesScreen (StatefulWidget)
└── RoleGuardedScreen (allows worker)
    └── Scaffold
        ├── AppBar
        │   ├── leading
        │   │   └── IconButton (back arrow -> back)
        │   ├── title
        │   │   └── Text (Upload Files)
        │   └── actions
        │       ├── AppNotificationIcon
        │       └── SizedBox (spacing)
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── WorkerStepHeader (step 3)
        │               ├── Text (Submit Blueprints)
        │               ├── Text (file type message)
        │               ├── Container (dashed upload box)
        │               │   └── Column
        │               │       ├── Container (circle upload Icon)
        │               │       ├── Text (Drop files here or browse)
        │               │       ├── Text (max size note)
        │               │       ├── ElevatedButton (Select Project Files)
        │               │       └── ElevatedButton (View Project Files)
        │               ├── Row (Active Syncing + files count)
        │               ├── Container (sync file card: name + progress bar + % + close Icon)
        │               ├── SizedBox (full width)
        │               │   └── OutlinedButton (Save Draft)
        │               ├── SizedBox (full width)
        │               │   └── ElevatedButton (Next)
        │               │       └── Row (Text Next + forward Icon)
        │               └── Row (info Icon + auto save note)
        ├── FloatingActionButton (pick files)
        │   └── Icon (add)
        └── CustomBottomNavBar (role: worker)
```

### worker/worker_activity_screen.dart - WorkerActivityScreen (StatefulWidget)

```text
WorkerActivityScreen (StatefulWidget)
└── RoleGuardedScreen (allows worker)
    └── Scaffold
        ├── AppBar
        │   ├── leading
        │   │   └── IconButton (back arrow -> back)
        │   ├── title
        │   │   └── Text (SITE LOG)
        │   └── actions
        │       ├── AppNotificationIcon
        │       └── SizedBox (spacing)
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── WorkerStepHeader (step 4)
        │               ├── Text (ACTIVITY FEED)
        │               ├── Text (Live Construction Log)
        │               ├── Container (feed card: file uploaded + icon + time)
        │               ├── Container (feed card: progress updated + progress bar)
        │               ├── Container (feed card: team member added)
        │               ├── Container (feed card: milestone completed)
        │               └── Container (feed card: file uploaded)
        ├── FloatingActionButton (-> Upload Files)
        │   └── Icon (add)
        └── CustomBottomNavBar (role: worker)
```

### worker/worker_leave_request_screen.dart - WorkerLeaveRequestScreen (StatefulWidget)

```text
WorkerLeaveRequestScreen (StatefulWidget)
└── RoleGuardedScreen (allows worker)
    └── Scaffold
        ├── AppBar
        │   ├── leading
        │   │   └── IconButton (grid icon -> back)
        │   ├── title
        │   │   └── Text (Leave Request)
        │   └── actions
        │       ├── AppNotificationIcon
        │       └── SizedBox (spacing)
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column (form view)
        │               ├── Text (Request Leave)
        │               ├── Text (subtitle message)
        │               ├── Container (form card)
        │               │   └── Column
        │               │       ├── Text (LEAVE TYPE label)
        │               │       ├── DropdownButton (Annual / Wellness / Conference / Sick)
        │               │       ├── Text (START DATE label)
        │               │       ├── Container (input START DATE + calendar Icon)
        │               │       ├── Text (END DATE label)
        │               │       ├── Container (input END DATE + calendar Icon)
        │               │       ├── Text (CONTEXT / REASON label)
        │               │       ├── Container (input REASON box)
        │               │       ├── Container (TOTAL DURATION box: calendar Icon + days Text)
        │               │       ├── SizedBox (full width)
        │               │       │   └── ElevatedButton (Submit Request)
        │               │       └── SizedBox (full width)
        │               │           └── OutlinedButton (Past Submissions -> History)
        ├── FloatingActionButton (-> Upload Files)
        │   └── Icon (add)
        └── CustomBottomNavBar (role: worker)
```

```text
WorkerLeaveRequestScreen - Success View (same shell)
└── Scaffold (same AppBar / FAB / BottomNav as above)
    └── body
        └── Column
            ├── Center
            │   └── Container (big tick circle Icon)
            ├── Text (Request Submitted)
            ├── Text (request details message)
            ├── Container (CURRENT STATUS card: icon + Pending Approval + dots)
            ├── SizedBox (full width)
            │   └── ElevatedButton (Back to Dashboard)
            └── SizedBox (full width)
                └── ElevatedButton (View My Requests -> History)
```

### worker/worker_leave_history_screen.dart - WorkerLeaveHistoryScreen (StatefulWidget)

```text
WorkerLeaveHistoryScreen (StatefulWidget)
└── RoleGuardedScreen (allows worker)
    └── Scaffold
        ├── AppBar
        │   ├── leading
        │   │   └── IconButton (grid icon / back arrow)
        │   ├── title
        │   │   └── Text (Leave History)
        │   └── actions
        │       ├── AppNotificationIcon
        │       └── SizedBox (spacing)
        ├── body
        │   └── SafeArea
        │       ├── IF loading
        │       │   └── Center
        │       │       └── CircularProgressIndicator
        │       └── ELSE
        │           └── SingleChildScrollView
        │               └── Column
        │                   ├── Row (top cards)
        │                   │   ├── Expanded
        │                   │   │   └── Container (BALANCE card: label + days)
        │                   │   └── Expanded
        │                   │       └── Container (PENDING card: label + requests)
        │                   ├── Row (section header: red bar + Request History)
        │                   ├── IF empty
        │                   │   └── Center
        │                   │       └── Text (No leave records found)
        │                   └── ELSE (one card per record)
        │                       └── Container (history card: date + status badge + leave type + dates row)
        ├── FloatingActionButton (-> Leave Request)
        │   └── Icon (add)
        └── CustomBottomNavBar (role: worker)
```

### worker/worker_password_update_screen.dart - WorkerPasswordUpdateScreen (StatefulWidget)

```text
WorkerPasswordUpdateScreen (StatefulWidget)
└── Scaffold (no RoleGuard in code)
    ├── AppBar
    │   ├── leading
    │   │   └── IconButton (back arrow -> back)
    │   ├── title
    │   │   └── Text (Security Settings)
    │   └── actions
    │       ├── AppNotificationIcon
    │       └── SizedBox (spacing)
    ├── body
    │   └── SafeArea
    │       └── SingleChildScrollView
    │           └── Column
    │               ├── Center
    │               │   └── Container (lock icon circle)
    │               │       └── Icon (lock)
    │               ├── Text (Update Password)
    │               ├── Text (change password message)
    │               ├── Column (CURRENT PASSWORD: label + TextField + eye Icon)
    │               ├── Column (NEW PASSWORD: label + TextField + eye Icon)
    │               ├── Column (CONFIRM PASSWORD: label + TextField + eye Icon)
    │               ├── Container (requirements card)
    │               │   └── Column
    │               │       ├── Text (Password Requirements)
    │               │       ├── Row (Icon + At least 8 characters)
    │               │       ├── Row (Icon + One uppercase letter)
    │               │       ├── Row (Icon + One number)
    │               │       └── Row (Icon + One special character)
    │               └── SizedBox (full width)
    │                   └── ElevatedButton (Update Password)
    ├── FloatingActionButton
    │   └── Icon (add)
    └── CustomBottomNavBar
```

### worker/worker_view_member_screen.dart - WorkerViewMemberScreen (StatefulWidget)

```text
WorkerViewMemberScreen (StatefulWidget)
└── RoleGuardedScreen (allows worker)
    └── Scaffold
        ├── AppBar
        │   ├── leading
        │   │   └── IconButton (back arrow -> back)
        │   ├── title
        │   │   └── Column
        │   │       ├── Text (PROJECT DETAILS small)
        │   │       └── Text (project name big)
        │   └── actions
        │       ├── AppNotificationIcon
        │       └── SizedBox (spacing)
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── WorkerStepHeader (step 2)
        │               ├── Text (Execution Crew)
        │               └── Container (crew list card)
        │                   └── Column
        │                       ├── Container (member tile: initials box + name + role + email)
        │                       ├── Container (member tile: initials box + name + role + email)
        │                       ├── Container (member tile: initials box + name + role + email)
        │                       └── Container (member tile: initials box + name + role + email)
        ├── FloatingActionButton (-> Upload Files)
        │   └── Icon (add)
        └── CustomBottomNavBar (role: worker)
```

### worker/worker_settings_screen.dart - WorkerSettingsScreen (StatefulWidget)

```text
WorkerSettingsScreen (StatefulWidget)
└── RoleGuardedScreen (allows worker)
    └── Scaffold
        ├── AppBar
        │   ├── leading
        │   │   └── IconButton (close X -> back)
        │   ├── title
        │   │   └── Text (Settings)
        │   └── actions
        │       ├── AppNotificationIcon
        │       └── profile image button (-> upload photo)
        ├── body
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── GestureDetector (-> upload photo)
        │               │   └── Stack
        │               │       ├── Container (photo circle)
        │               │       │   └── ClipOval (profile image)
        │               │       └── Container (edit dot)
        │               │           └── Icon (edit)
        │               ├── Text (user name)
        │               ├── Text (user email)
        │               ├── SettingGroup (ACCOUNT)
        │               │   ├── SettingTile (Profile Information)
        │               │   └── SettingTile (Security and Password -> Password screen)
        │               ├── SettingGroup (NOTIFICATIONS)
        │               │   ├── SettingSwitchTile (Push)
        │               │   └── SettingSwitchTile (Email Reports)
        │               ├── SettingGroup (PREFERENCES)
        │               │   ├── SettingTile (Language)
        │               │   └── SettingTile (Theme)
        │               ├── SettingGroup (ABOUT and HELP)
        │               │   ├── SettingTile (Help and Support)
        │               │   ├── SettingTile (Privacy Policy)
        │               │   └── SettingTile (About)
        │               ├── SizedBox (full width)
        │               │   └── OutlinedButton.icon (Log Out)
        │               └── Text (Logged in as ... message)
        ├── FloatingActionButton (-> Upload Files)
        │   └── Icon (add)
        └── CustomBottomNavBar (role: worker)
```

---

## Employee Screens (`lib/screen/employee/`, own Scaffold + own AppBar + BottomNav, no FAB)

### employee/employee_dashboard_screen.dart - EmployeeDashboardScreen (StatefulWidget)

```text
EmployeeDashboardScreen (StatefulWidget)
└── RoleGuardedScreen (allows employee, admin)
    └── Scaffold
        ├── AppBar
        │   ├── leading (none, title starts directly)
        │   ├── title
        │   │   └── Text (Employee Dashboard)
        │   └── actions
        │       ├── AppNotificationIcon
        │       └── CircleAvatar (person icon button)
        ├── body
        │   └── SingleChildScrollView
        │       └── Column
        │           ├── Container (welcome banner gradient)
        │           │   └── Column
        │           │       ├── Text (Welcome back, Team Member!)
        │           │       └── Text (Manage your daily tasks message)
        │           ├── Text (Work Overview)
        │           ├── Row (metric cards)
        │           │   ├── Expanded
        │           │   │   └── Container (metric card Active Tasks 12 + icon)
        │           │   └── Expanded
        │           │       └── Container (metric card Completed 48 + icon)
        │           ├── Row (metric cards)
        │           │   ├── Expanded
        │           │   │   └── Container (metric card Leave Days 14 + icon)
        │           │   └── Expanded
        │           │       └── Container (metric card Projects 4 Active + icon)
        │           ├── Row (Recent Activity + View All)
        │           └── Column (activity rows: icon + title + subtitle + time)
        │               ├── activity row (Design Spec Approved)
        │               ├── activity row (New Task Assigned)
        │               └── activity row (Leave Request Approved)
        └── CustomBottomNavBar (role: employee)
```

### employee/employee_project_view_screen.dart - EmployeeProjectViewScreen (StatefulWidget)

```text
EmployeeProjectViewScreen (StatefulWidget)
└── RoleGuardedScreen (allows employee, admin)
    └── Scaffold
        ├── AppBar
        │   ├── leading (none)
        │   ├── title
        │   │   └── Text (Assigned Projects)
        │   └── actions
        │       ├── AppNotificationIcon
        │       └── SizedBox (spacing)
        ├── body
        │   └── ListView
        │       └── Column
        │           ├── Text (Active Work Assignments)
        │           ├── Text (View projects assigned to you subtitle)
        │           ├── Container (project card: title + company + deadline + status badge + progress)
        │           ├── Container (project card: title + company + deadline + status badge + progress)
        │           └── Container (project card: title + company + deadline + status badge + progress)
        └── CustomBottomNavBar (role: employee)
```

### employee/employee_activity_screen.dart - EmployeeActivityScreen (StatefulWidget)

```text
EmployeeActivityScreen (StatefulWidget)
└── RoleGuardedScreen (allows employee, admin)
    └── Scaffold
        ├── AppBar
        │   ├── leading (none)
        │   ├── title
        │   │   └── Text (Employee Activity)
        │   └── actions
        │       ├── AppNotificationIcon
        │       └── SizedBox (spacing)
        ├── body
        │   └── ListView
        │       └── Column
        │           ├── Text (Activity and Log History)
        │           ├── Text (Track your daily contributions subtitle)
        │           ├── Container (activity card: icon + title + subtitle + time)
        │           ├── Container (activity card: icon + title + subtitle + time)
        │           ├── Container (activity card: icon + title + subtitle + time)
        │           └── Container (activity card: icon + title + subtitle + time)
        └── CustomBottomNavBar (role: employee)
```

### employee/employee_leave_history_screen.dart - EmployeeLeaveHistoryScreen (StatefulWidget)

```text
EmployeeLeaveHistoryScreen (StatefulWidget)
└── RoleGuardedScreen (allows employee, admin)
    └── Scaffold
        ├── AppBar
        │   ├── leading (none)
        │   ├── title
        │   │   └── Text (Leave Requests and History)
        │   └── actions
        │       ├── AppNotificationIcon
        │       └── SizedBox (spacing)
        ├── body
        │   └── ListView
        │       └── Column
        │           ├── Container (leave summary card: balance + types Casual/Sick/Earned)
        │           ├── Text (Recent Leave Requests)
        │           ├── Container (leave card: type + dates + reason + Approved badge)
        │           ├── Container (leave card: type + dates + reason + Approved badge)
        │           ├── Container (leave card: type + dates + reason + Pending badge)
        │           └── SizedBox (full width)
        │               └── ElevatedButton (Apply Leave)
        └── CustomBottomNavBar (role: employee)
```

### employee/employee_settings_screen.dart - EmployeeSettingsScreen (StatefulWidget)

```text
EmployeeSettingsScreen (StatefulWidget)
└── RoleGuardedScreen (allows employee, admin)
    └── Scaffold
        ├── AppBar
        │   ├── leading (none)
        │   ├── title
        │   │   └── Text (Employee Settings)
        │   └── actions
        │       ├── AppNotificationIcon
        │       └── SizedBox (spacing)
        ├── body
        │   └── SingleChildScrollView
        │       └── Column
        │           ├── Container (profile card)
        │           │   └── Row
        │           │       ├── CircleAvatar (person icon)
        │           │       └── Expanded
        │           │           └── Column
        │           │               ├── Text (user name)
        │           │               ├── Text (user email)
        │           │               └── Container (Role: Employee badge)
        │           ├── SettingGroup (Notifications and Alerts)
        │           │   ├── SettingSwitchTile (Push Notifications)
        │           │   └── SettingSwitchTile (Email Daily Reports)
        │           ├── SettingGroup (Account and Security)
        │           │   ├── SettingTile (Change Password)
        │           │   └── SettingTile (Privacy Policy)
        │           └── SizedBox (full width)
        │               └── OutlinedButton.icon (Logout)
        └── CustomBottomNavBar (role: employee)
```

---

## Reusable Widget Trees

```text
CustomTextField (StatefulWidget)
└── Column
    ├── Text (field label)
    └── TextFormField
        ├── hint text
        ├── prefix / suffix icon
        └── password show-hide button (if password field)
```

```text
CustomButton (StatelessWidget)
└── SizedBox (full width button)
    └── ElevatedButton
        └── Text (button label)
```

```text
ProjectCard (StatelessWidget)
└── Card
    └── Column
        ├── project image
        ├── Text (project title + status)
        ├── Text (project details)
        └── progress bar area
```

```text
PortfolioCard (StatelessWidget)
└── Card
    └── Column
        ├── project image
        ├── Text (project title)
        └── Text (project details)
```

```text
SettingGroup (StatelessWidget)
└── Column
    ├── Text (group title)
    ├── SettingTile
    └── SettingSwitchTile
```

```text
SettingTile (StatelessWidget)
└── ListTile
    ├── leading Icon
    ├── Text (title + subtitle)
    └── trailing Icon (arrow)
```

```text
SettingSwitchTile (StatelessWidget)
└── SwitchListTile
    ├── Text (title + subtitle)
    └── Switch (on / off button)
```

```text
ContactInfoRow (StatelessWidget)
└── Row
    ├── Icon
    └── Text (contact text)
```

```text
SectionHeader (StatelessWidget)
└── Row
    ├── Text (section title)
    └── action link (if any)
```

```text
WorkerStepHeader (StatelessWidget)
└── Row
    ├── step circle (1-2-3-4)
    ├── connecting line
    ├── step circle
    └── step title text
```
