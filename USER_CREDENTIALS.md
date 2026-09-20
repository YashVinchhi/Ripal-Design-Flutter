# Demo User Credentials & Access Roles

This document lists the pre-configured test user accounts, passwords, and assigned system roles for the **Ripal Design** Flutter application.

---

## 1. Summary Credentials Table

| Name | Role | Email | Password | Primary Purpose / Access Level |
| :--- | :---: | :--- | :--- | :--- |
| **Yash** | `admin` | `yash@gmail.com` | `zxcv` | Full Admin Dashboard & System Access |
| **Admin** | `admin` | `admin@gmail.com` | `admin123` | System Administrator Account |
| **Rachit** | `employee` | `rachit@gmail.com` | `zxcv` *(or `rachit123`)* | Staff / Employee Management & Reports |
| **Niku** | `worker` | `niku@gmail.com` | `zxcv` | Site Worker / On-site Execution |
| **Rohan** | `client` | `rohan@gmail.com` | `zxcv` | Client Portal & Project Portfolio View |

---

## 2. Account Details & Role Breakdown

### 1. Yash (`admin`)
- **Email:** `yash@gmail.com`
- **Password:** `zxcv`
- **Role:** `Admin`
- **Scope:** Complete access to project creation, user management, financial gateways, invoice generation, leave approvals, and site logs.

### 2. Admin (`admin`)
- **Email:** `admin@gmail.com`
- **Password:** `admin123`
- **Role:** `Admin`
- **Scope:** System administrator account with full administrative privileges.

### 3. Rachit (`employee`)
- **Email:** `rachit@gmail.com`
- **Password:** `zxcv` *(or `rachit123`)*
- **Role:** `Employee`
- **Scope:** Access to project workflows, leave history, file uploads, financial reports, and task tracking.

### 4. Niku (`worker`)
- **Email:** `niku@gmail.com`
- **Password:** `zxcv`
- **Role:** `Worker`
- **Scope:** Access to assigned project details, site file uploads, and leave balance/history.

### 5. Rohan (`client`)
- **Email:** `rohan@gmail.com`
- **Password:** `zxcv`
- **Role:** `Client`
- **Scope:** Access to active portfolio progress, consultation requests, job applications, invoices, and studio contact.

---

## 3. Code Reference

These credentials are wired in [`lib/screen/login_screen.dart`](file:///D:/Ripal-Design-Flutter/lib/screen/login_screen.dart):