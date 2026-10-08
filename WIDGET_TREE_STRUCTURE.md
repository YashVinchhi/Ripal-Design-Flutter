# Ripal Design Flutter Widget Tree

Concrete, simplified widget trees for every screen in `lib/screen/`. Repeated widgets use `x N`.

## App Entry And Shared Shell

```text
MainApp (StatelessWidget)
└── MaterialApp
    └── SplashScreen
        └── SharedPreferences
            ├── logged in -> DashboardScreen
            └── logged out -> login_Screen
```

```text
MainScaffold
├── AppBar
│   ├── menu/dashboard button
│   ├── title
│   ├── notification button
│   └── profile image -> settings screen
├── body
├── optional FloatingActionButton
└── CustomBottomNavBar
```

## Authentication And Startup

### `splashscreen.dart` - `SplashScreen`

```text
SplashScreen (StatefulWidget)
└── Scaffold
    └── SafeArea
        └── Stack
            ├── Positioned -> CustomPaint (CornerLinesPainter)
            ├── Positioned -> CustomPaint (CornerLinesPainter)
            └── Center
                └── Column
                    ├── Image.asset (logo)
                    ├── Text (Ripal Design)
                    └── Text (ARCHITECTURAL EXCELLENCE)
```

### `login_screen.dart` - `login_Screen`

```text
login_Screen (StatefulWidget)
└── Scaffold
    └── SafeArea
        └── Column
            ├── Expanded -> SizedBox -> Stack -> Padding -> Text (Ripal Design)
            └── Expanded
                └── Container
                    └── SingleChildScrollView
                        └── Column
                            ├── CustomTextField (email)
                            ├── CustomTextField (password)
                            ├── TextButton (forgot password)
                            ├── CustomButton (login)
                            ├── Row -> Divider / Text / Divider
                            ├── OutlinedButton -> Row -> Image.asset / Text
                            └── Row -> Text / GestureDetector -> Text (Sign Up)
```

### `signup_screen.dart` - `SignupScreen`

```text
SignupScreen (StatefulWidget)
└── Scaffold
    └── SafeArea
        └── SingleChildScrollView
            └── Column
                ├── Text (title and intro)
                ├── TextField (name)
                ├── TextField (email)
                ├── TextField (password)
                ├── TextField (Confirm password)
                ├── Row -> Checkbox / RichText (Terms of Service ...)
                ├── ElevatedButton (create account)
                └── Row -> Text(Already have an account?) / GestureDetector -> Text (Log In)
```

### `forgot_password_screen.dart` - `ForgotPasswordScreen`

```text
ForgotPasswordScreen (StatefulWidget)
└── Scaffold
    └── SafeArea
        └── LayoutBuilder
            └── SingleChildScrollView
                └── ConstrainedBox -> IntrinsicHeight -> Padding -> Column
                    ├── Text (title)
                    ├── Text (instructions)
                    ├── TextField (email)
                    ├── ElevatedButton (reset password)
                    └── Center -> TextButton.icon (back to login)
```

### `upload_profile_photo_screen.dart` - `UploadProfilePhotoScreen`

```text
UploadProfilePhotoScreen (StatefulWidget)
└── MainScaffold
    └── SafeArea
        └── SingleChildScrollView
            └── Column
                ├── Center -> SizedBox -> Stack
                │   ├── CustomPaint (dashed circle)
                │   └── Container -> ClipOval -> profile image
                ├── Text (instructions)
                ├── ElevatedButton (choose photo)
                └── OutlinedButton (skip/continue)
```

## Shared Account Screens

### `dashboard_screen.dart` - `DashboardScreen`

```text
DashboardScreen (StatefulWidget)
└── MainScaffold
    └── IndexedStack
        ├── SafeArea -> SingleChildScrollView -> client home body
        ├── ClientProjectView
        ├── ClientContactus
        └── SettingsScreen
```

Admin and worker dashboard bodies use:

```text
MainScaffold (role: admin/worker)
└── SafeArea
    └── SingleChildScrollView
        └── Column
            ├── role welcome/header
            ├── summary/stat cards
            ├── quick actions
            └── project/activity sections
```

### `settings_screen.dart` - `SettingsScreen`

```text
SettingsScreen (StatefulWidget)
└── MainScaffold
    └── SafeArea -> SingleChildScrollView -> Column
        ├── GestureDetector -> Column -> Stack -> CircleAvatar
        ├── SettingGroup -> SettingTile / SettingSwitchTile
        ├── SettingGroup -> SettingTile / SettingSwitchTile
        ├── SettingGroup -> SettingTile
        ├── SettingGroup -> SettingTile
        └── OutlinedButton.icon (logout)
```

### `worker_settings_screen.dart` - `WorkerSettingsScreen`

```text
WorkerSettingsScreen (StatefulWidget)
└── Scaffold
    └── SafeArea -> SingleChildScrollView -> Column
        ├── Center -> GestureDetector -> Stack -> profile image
        ├── Text (name)
        ├── Text (role)
        ├── SettingGroup -> SettingTile
        ├── SettingGroup -> SettingSwitchTile
        ├── SettingGroup -> SettingTile
        ├── SettingGroup -> SettingTile
        └── OutlinedButton.icon (logout)
```

### `edit_profile_screen.dart` - `EditProfileScreen`

```text
EditProfileScreen (StatefulWidget)
└── MainScaffold
    └── SafeArea -> SingleChildScrollView -> Column
        ├── Center -> GestureDetector -> Stack -> CircleAvatar
        ├── Center -> GestureDetector -> Text (change photo)
        ├── Text (profile details)
        ├── _buildField x 7
        └── SizedBox -> ElevatedButton (save changes)
```

### `placeholder_screen.dart` - `PlaceholderScreen`

```text
PlaceholderScreen (StatelessWidget)
└── Scaffold
    ├── AppBar -> IconButton / Text
    └── Center -> Column
        ├── Icon
        ├── Text (screen title)
        └── Text (placeholder message)
```

### `invoice_pdf_preview_screen.dart` - `InvoicePdfPreviewScreen`

```text
InvoicePdfPreviewScreen (StatelessWidget)
└── Scaffold
    ├── AppBar
    └── PdfPreview
        └── InvoicePdfHelper.generateInvoicePdf -> pw.Page
            ├── pw.Row (header)
            ├── pw.Table (items)
            ├── pw.Row (subtotal/tax)
            └── pw.Row (total/signature)
```

## Admin Screens

### `admin_activity_screen.dart` - `AdminActivityScreen`

```text
AdminActivityScreen (StatefulWidget)
└── MainScaffold (role: admin)
    └── SafeArea -> SingleChildScrollView -> Column
        ├── Row -> _buildStep / _buildStepDivider
        ├── Text / Text / Container (header and filter)
        ├── _buildFeedItem
        ├── _buildFeedItem -> Column -> RichText / ClipRRect
        ├── _buildFeedItem -> Column -> RichText
        └── _buildFeedItem
```

### `admin_user_management_screen.dart` - `AdminUserManagementScreen`

```text
AdminUserManagementScreen (StatefulWidget)
└── MainScaffold (role: admin)
    └── SafeArea -> SingleChildScrollView -> Column
        ├── _buildStatCard x 3
        ├── SingleChildScrollView -> Row -> _buildFilterChip x 4
        ├── Row -> Text / Icon
        └── Container -> Column
            ├── Container -> Row (table header)
            ├── _buildUserRow x 3
            └── Padding -> Row -> _buildPaginationButton x 2
```

### `admin_team_screen.dart` - `AdminTeamScreen`

```text
AdminTeamScreen (StatefulWidget)
└── MainScaffold (role: admin)
    └── SafeArea -> SingleChildScrollView -> Column
        ├── Row -> _buildStep / _buildStepDivider
        ├── TextField (search)
        ├── _buildTeamMemberCard x 2
        └── ElevatedButton (add member)
```

### `admin_leave_screen.dart` - `AdminLeaveScreen`

```text
AdminLeaveScreen (StatefulWidget)
└── MainScaffold (role: admin)
    └── SafeArea -> SingleChildScrollView -> Column
        ├── _buildStatCard -> Row -> _buildAvatarPlaceholder x 3
        ├── _buildStatCard -> Row -> Icon / Text
        ├── Row -> Text / GestureDetector (view all)
        └── _buildLeaveRequestCard x 3
            └── approve/reject actions
```

### `admin_leave_history_screen.dart` - `AdminLeaveHistoryScreen`

```text
AdminLeaveHistoryScreen (StatefulWidget)
└── MainScaffold (role: admin)
    └── SafeArea -> SingleChildScrollView -> Column
        ├── Row -> Expanded -> _buildMetricCard x 2
        ├── Row -> Container / Text (filter and title)
        └── _buildHistoryCard x 5
```

### `admin_finance_screen.dart` - `AdminFinanceScreen`

```text
AdminFinanceScreen (StatefulWidget)
└── MainScaffold (role: admin)
    └── SafeArea -> SingleChildScrollView -> Column
        ├── Text / Text (title and subtitle)
        ├── Container -> Column -> LinearProgressIndicator x 2
        ├── Container -> Column -> SizedBox -> Stack
        │   ├── CustomPaint (donut gauge)
        │   └── Column (gauge labels)
        ├── Row -> Text / GestureDetector
        └── Container -> Column -> _buildTransactionRow x 3
```

### `admin_invoice_screen.dart` - `AdminInvoiceScreen`

```text
AdminInvoiceScreen (StatefulWidget)
└── MainScaffold (role: admin)
    └── SafeArea -> SingleChildScrollView -> Column
        ├── Row -> Column (heading) / IconButton (create)
        ├── Row -> Text / Container (filter)
        ├── Container -> Column -> Row -> Column x 2 (summary)
        ├── _buildServiceItem x 3
        ├── Row -> Text / Text (total)
        └── _buildTimelineItem x 2
```

### `admin_create_invoice_screen.dart` - `AdminCreateInvoiceScreen`

```text
AdminCreateInvoiceScreen (StatefulWidget)
└── Scaffold
    └── SafeArea -> SingleChildScrollView -> Column
        ├── Container -> DropdownButtonHideUnderline -> DropdownButton
        ├── Text x 3 (invoice/customer fields)
        ├── Text / Divider (items heading)
        ├── Container -> Column -> Row (item editor)
        ├── GestureDetector -> Row (add item)
        ├── Row -> Column / Column (totals)
        └── ElevatedButton (create invoice)
```

### `admin_create_project.dart` - `AdminCreateProject`

```text
AdminCreateProject (StatefulWidget)
└── MainScaffold (role: admin)
    └── SafeArea -> SingleChildScrollView -> Column
        ├── Row -> _buildStep / _buildStepDivider
        ├── _buildStep1Details -> Column
        │   ├── _buildTextField
        │   └── _buildDropdownField
        ├── SizedBox -> OutlinedButton (files)
        └── SizedBox -> ElevatedButton -> Row (next/create)
```

### `admin_project_detail_screen.dart` - `AdminProjectDetailScreen`

```text
AdminProjectDetailScreen (StatefulWidget)
└── MainScaffold (role: admin)
    └── SafeArea -> SingleChildScrollView -> Column
        ├── Row -> _buildStep / _buildStepDivider
        ├── Container -> Stack
        │   ├── CustomPaint (placeholder)
        │   ├── Container (project image)
        │   └── Padding (title/status)
        ├── _buildInfoItem x 4
        ├── _buildMilestoneItem x 3
        ├── _buildTeamMemberCard x 2
        └── Row -> _buildGallerySquare x 3
```

### `admin_upload_file_screen.dart` - `AdminUploadFileScreen`

```text
AdminUploadFileScreen (StatefulWidget)
└── MainScaffold (role: admin)
    └── SafeArea -> SingleChildScrollView -> Column
        ├── Row -> _buildStep / _buildStepDivider
        ├── Text (title/instructions)
        ├── GestureDetector -> CustomPaint -> Container -> Column
        │   ├── Container -> Icon
        │   ├── Text (drop files)
        │   └── ElevatedButton (browse)
        ├── _buildSyncingFileCard
        ├── OutlinedButton (cancel)
        └── ElevatedButton (upload)
```

### `admin_file_view_screen.dart` - `AdminFileViewScreen`

```text
AdminFileViewScreen (StatefulWidget)
└── MainScaffold (role: admin)
    └── SafeArea -> SingleChildScrollView -> Column
        ├── Text / Text (project and file metadata)
        ├── TextField (search)
        ├── ElevatedButton.icon (upload)
        ├── SingleChildScrollView -> Row -> _buildFilterChip x 3
        ├── SizedBox -> ListView -> _buildBlueprintCard x 2
        ├── _buildContractItem x 3
        ├── GridView.count -> CustomPaint (placeholders)
        └── _buildRenderItem x 3
```

## Client Screens

### `client_project_view.dart` - `ClientProjectView`

```text
ClientProjectView (StatefulWidget)
└── MainScaffold (role: client)
    └── SafeArea -> Column
        ├── Padding -> TextField (search)
        ├── SingleChildScrollView -> Row -> _buildFilterChip
        └── Expanded -> ListView.builder -> ProjectCard
```

### `client_project_detail_screen.dart` - `ClientProjectDetailScreen`

```text
ClientProjectDetailScreen (StatelessWidget)
└── Scaffold
    └── SafeArea -> SingleChildScrollView -> Column
        ├── _HeroBanner
        ├── SizedBox -> ListView.builder -> Image.asset (gallery)
        ├── _ProgressCard
        ├── _InfoCard
        └── _MilestoneTimeline
```

### `client_applay.dart` - `ClientApplay`

```text
ClientApplay (StatefulWidget)
└── MainScaffold (role: client)
    └── SafeArea -> SingleChildScrollView -> Form -> Column
        ├── Text / Text (title and instructions)
        ├── SectionHeader
        ├── CustomTextField x 7
        ├── GestureDetector -> Container -> Row (attachment)
        ├── CustomButton (submit application)
        └── Text (supporting note)
```

### `client_contactus.dart` - `ClientContactus`

```text
ClientContactus (StatefulWidget)
└── MainScaffold (role: client)
    └── SafeArea -> SingleChildScrollView -> Form -> Column
        ├── Text / Text (title and instructions)
        ├── SectionHeader
        ├── CustomTextField x 2
        ├── DropdownButtonFormField (subject)
        ├── CustomTextField (message)
        ├── ContactInfoRow x 3
        └── CustomButton (send message)
```

## Worker Screens

Worker screens use their own `Scaffold`, app bar, floating action button, and bottom navigation.

### `worker_project_view_screen.dart` - `WorkerProjectViewScreen`

```text
WorkerProjectViewScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    ├── body: SafeArea -> SingleChildScrollView -> Column
    │   ├── WorkerStepHeader
    │   ├── Container -> ClipRRect -> Stack
    │   │   ├── CheckeredPlaceholder
    │   │   ├── Container (project image)
    │   │   └── Positioned -> Column (status)
    │   ├── _buildMetaItem x 4
    │   ├── _buildMilestoneTimeline
    │   ├── _buildTeamMemberCard x 2
    │   └── Row -> _buildGallerySquare x 3
    ├── FloatingActionButton
    └── CustomBottomNavBar
```

### `worker_project_files_screen.dart` - `WorkerProjectFilesScreen`

```text
WorkerProjectFilesScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    ├── body: SafeArea -> SingleChildScrollView -> Column
    │   ├── Text / Text (title and subtitle)
    │   ├── Container -> Row -> TextField (search)
    │   ├── ElevatedButton.icon (upload)
    │   ├── Row -> _buildFilterChip x 3
    │   ├── _buildBlueprintCard x 2
    │   ├── _buildContractsContainer
    │   ├── _buildSitePhotosGrid
    │   ├── _buildWalkThroughVideo
    │   └── _buildMediaItem x 3
    ├── FloatingActionButton
    └── CustomBottomNavBar
```

### `worker_upload_files_screen.dart` - `WorkerUploadFilesScreen`

```text
WorkerUploadFilesScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    ├── body: SafeArea -> SingleChildScrollView -> Column
    │   ├── WorkerStepHeader
    │   ├── Text / Text (title and instructions)
    │   ├── _buildDashedDropZone
    │   ├── Row -> Text / Text (file count)
    │   ├── _buildSyncFileCard x 2
    │   ├── OutlinedButton (cancel)
    │   ├── ElevatedButton -> Row (upload)
    │   └── Row -> Icon / Text (note)
    ├── FloatingActionButton
    └── CustomBottomNavBar
```

### `worker_activity_screen.dart` - `WorkerActivityScreen`

```text
WorkerActivityScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    ├── body: SafeArea -> SingleChildScrollView -> Column
    │   ├── WorkerStepHeader
    │   ├── Text / Text / Container (header and filter)
    │   ├── _buildFeedCard x 4
    │   │   └── one card contains ClipRRect (image)
    ├── FloatingActionButton
    └── CustomBottomNavBar
```

### `worker_leave_request_screen.dart` - `WorkerLeaveRequestScreen`

```text
WorkerLeaveRequestScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    ├── body: SafeArea -> SingleChildScrollView
    │   ├── _buildRequestFormView -> Column
    │   │   ├── Text / Text (title and instructions)
    │   │   └── Container -> Column -> _buildInputField x 3
    │   └── _buildSubmittedSuccessView -> Column
    │       ├── Center -> Container -> Icon
    │       └── ElevatedButton (new request)
    ├── FloatingActionButton
    └── CustomBottomNavBar
```

### `worker_leave_history_screen.dart` - `WorkerLeaveHistoryScreen`

```text
WorkerLeaveHistoryScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    ├── body: SafeArea -> Stack
    │   ├── SingleChildScrollView -> Column
    │   │   ├── Row -> Expanded -> Container x 2 (metrics)
    │   │   ├── Row -> Container / Text (filter and title)
    │   │   └── _buildLeaveCard x 5
    │   └── Positioned -> GestureDetector -> Container -> Icon
    ├── FloatingActionButton
    └── CustomBottomNavBar
```

### `worker_password_update_screen.dart` - `WorkerPasswordUpdateScreen`

```text
WorkerPasswordUpdateScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    ├── body: SafeArea -> SingleChildScrollView -> Column
    │   ├── Center -> Container -> Icon
    │   ├── Text / Text (title and instructions)
    │   ├── _buildPasswordField x 3
    │   ├── Container -> Column -> _buildRequirementRow x 4
    │   └── ElevatedButton (update password)
    ├── FloatingActionButton
    └── CustomBottomNavBar
```

### `worker_view_member_screen.dart` - `WorkerViewMemberScreen`

```text
WorkerViewMemberScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    ├── body: SafeArea -> SingleChildScrollView -> Column
    │   ├── WorkerStepHeader
    │   ├── Text (member title)
    │   └── Container -> Column -> Padding -> _buildMemberTile
    ├── FloatingActionButton
    └── CustomBottomNavBar
```

## Reusable Resource Widget Trees

```text
CustomTextField (StatefulWidget)
└── TextFormField / TextField
    ├── label and hint
    ├── prefix/suffix icon
    └── validation and password visibility state

CustomButton
└── SizedBox -> ElevatedButton or InkWell -> label/icon

CustomBottomNavBar
└── Container -> Row -> navigation items
    ├── selected/unselected icon
    └── label

ProjectCard
└── Card / Container -> Column
    ├── image or CheckeredPlaceholder
    ├── project title/status
    ├── metadata
    └── progress/action area

PortfolioCard
└── Card / Container -> Column or Stack
    ├── project image or placeholder
    ├── project title
    └── project metadata/action

SettingGroup
└── Column -> group heading / SettingTile / SettingSwitchTile children

SettingTile
└── ListTile -> leading icon / title-subtitle / trailing action

SettingSwitchTile
└── SwitchListTile -> title-subtitle / switch value-onChanged

ContactInfoRow
└── Row -> icon / text content

SectionHeader
└── Row -> section title / optional action

WorkerStepHeader
└── Row / Column -> step indicator / title / supporting text

CheckeredPlaceholder
└── CustomPaint -> CheckeredPainter
```
