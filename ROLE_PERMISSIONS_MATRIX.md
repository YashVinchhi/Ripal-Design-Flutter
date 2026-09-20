# Role Access & Permissions Matrix

This document defines the Role-Based Access Control (RBAC) permissions matrix for all screens in the **Ripal Design** Flutter project.

### Access Notation Legend
- **R**: Read-only access (View screen / view data)
- **W**: Write access (Create / Edit / Submit data)
- **D**: Delete access (Remove records / files)
- **X**: Restricted (Do NOT show screen to this role at all)

---

## 1. Matrix View: Roles (Y-Axis) vs Screens (X-Axis)

| Role / Screen | Splash Screen | Login Screen | Signup Screen | Forgot Password Screen | Dashboard Screen | Settings Screen | Edit Profile Screen | Upload Profile Photo Screen | Admin Activity Screen | Admin Create Invoice Screen | Admin Create Project | Admin File View Screen | Admin Finance Screen | Admin Invoice Screen | Admin Leave History Screen | Admin Leave Screen | Admin Project Detail Screen | Admin Team Screen | Admin Upload File Screen | Admin User Management Screen | Client Apply Screen | Client Contact Us Screen | Client Project View Screen | Invoice PDF Preview Screen | Placeholder Screen |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Admin** | R | W | W | W | R | W | W | W | R | W | W | R | W | W | W | W | W | W | W | W | X | X | R | R | X |
| **Client** | R | W | W | W | R | W | W | W | X | X | X | R | X | R | X | X | R | R | X | X | W | W | R | R | X |
| **Employee** | R | W | W | W | R | W | W | W | R | W | W | R | R | W | R | X | W | W | W | X | X | X | R | R | X |
| **Worker** | R | W | W | W | R | W | W | W | X | X | R | R | X | X | R | X | R | R | W | X | X | X | R | R | X |

---

## 2. Screen Reference Table & Transposed Matrix (Screens as Rows)

| # | Screen Name | File Path | Class Name | Admin | Client | Employee | Worker |
| :-: | :--- | :--- | :--- | :---: | :---: | :---: | :---: |
| 1 | **Splash Screen** | `lib/screen/splashscreen.dart` | `SplashScreen` | R | R | R | R |
| 2 | **Login Screen** | `lib/screen/login_screen.dart` | `LoginScreen` | W | W | W | W |
| 3 | **Signup Screen** | `lib/screen/signup_screen.dart` | `SignupScreen` | W | W | W | W |
| 4 | **Forgot Password Screen** | `lib/screen/forgot_password_screen.dart` | `ForgotPasswordScreen` | W | W | W | W |
| 5 | **Dashboard Screen** | `lib/screen/dashboard_screen.dart` | `DashboardScreen` | R | R | R | R |
| 6 | **Settings Screen** | `lib/screen/settings_screen.dart` | `SettingsScreen` | W | W | W | W |
| 7 | **Edit Profile Screen** | `lib/screen/edit_profile_screen.dart` | `EditProfileScreen` | W | W | W | W |
| 8 | **Upload Profile Photo Screen** | `lib/screen/upload_profile_photo_screen.dart` | `UploadProfilePhotoScreen` | W | W | W | W |
| 9 | **Admin Activity Screen** | `lib/screen/admin_activity_screen.dart` | `AdminActivityScreen` | R | X | R | X |
| 10 | **Admin Create Invoice Screen** | `lib/screen/admin_create_invoice_screen.dart` | `AdminCreateInvoiceScreen` | W | X | W | X |
| 11 | **Admin Create Project Screen** | `lib/screen/admin_create_project.dart` | `AdminCreateProject` | W | X | W | R |
| 12 | **Admin File View Screen** | `lib/screen/admin_file_view_screen.dart` | `AdminFileViewScreen` | R | R | R | R |
| 13 | **Admin Finance Screen** | `lib/screen/admin_finance_screen.dart` | `AdminFinanceScreen` | W | X | R | X |
| 14 | **Admin Invoice Screen** | `lib/screen/admin_invoice_screen.dart` | `AdminInvoiceScreen` | W | R | W | X |
| 15 | **Admin Leave History Screen** | `lib/screen/admin_leave_history_screen.dart` | `AdminLeaveHistoryScreen` | W | X | R | R |
| 16 | **Admin Leave Screen** | `lib/screen/admin_leave_screen.dart` | `AdminLeaveScreen` | W | X | X | X |
| 17 | **Admin Project Detail Screen** | `lib/screen/admin_project_detail_screen.dart` | `AdminProjectDetailScreen` | W | R | W | R |
| 18 | **Admin Team Screen** | `lib/screen/admin_team_screen.dart` | `AdminTeamScreen` | W | R | W | R |
| 19 | **Admin Upload File Screen** | `lib/screen/admin_upload_file_screen.dart` | `AdminUploadFileScreen` | W | X | W | W |
| 20 | **Admin User Management Screen** | `lib/screen/admin_user_management_screen.dart` | `AdminUserManagementScreen` | W | X | X | X |
| 21 | **Client Apply Screen** | `lib/screen/client_applay.dart` | `ClientApplay` | X | W | X | X |
| 22 | **Client Contact Us Screen** | `lib/screen/client_contactus.dart` | `ClientContactus` | X | W | X | X |
| 23 | **Client Project View Screen** | `lib/screen/client_project_view.dart` | `ClientProjectView` | R | R | R | R |
| 24 | **Invoice PDF Preview Screen** | `lib/screen/invoice_pdf_preview_screen.dart` | `InvoicePdfPreviewScreen` | R | R | R | R |
| 25 | **Placeholder Screen** | `lib/screen/placeholder_screen.dart` | `PlaceholderScreen` | X | X | X | X |
