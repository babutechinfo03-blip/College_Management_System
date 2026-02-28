# Quick Start Guide - College ERP System

## ✅ Current Status

### Frontend
- **Status**: ✅ Running on `http://localhost:5173`
- **Command**: `npm run dev` (already running in terminal)
- **Location**: `f:/Full Stack App/frontend`

### Backend
- **Status**: ⚠️ Needs to be started from IntelliJ IDEA
- **Location**: `f:/Full Stack App/backend`

---

## 🚀 How to Run Backend

Since Maven is not in your system PATH, use IntelliJ IDEA:

1. **Open IntelliJ IDEA**
2. **Navigate to**: `ErpApplication.java` 
   - Path: `backend/src/main/java/com/college/erp/ErpApplication.java`
3. **Click the green ▶️ Run button** next to the `main` method
4. **Wait for**: "Started ErpApplication" message in console
5. **Backend will run on**: `http://localhost:8080`

---

## 🧪 Testing the New Features

Once both servers are running:

### 1. Login as Office Staff
- Go to: `http://localhost:5173`
- Click: **Institution Portal** → **Office**
- Login with Office credentials

### 2. Test Student Entry
- Navigate to: **Add Student** (in Office Dashboard)
- **Verify**:
  - ✅ "Program Type" dropdown appears above Department
  - ✅ Select "UG" → Only UG departments show
  - ✅ Select "PG" → Only PG departments show
  - ✅ Year dropdown shows 1-4 for UG, 1-2 for PG
  - ✅ Email field says "Student Email" (not "Institutional Email")
  - ✅ Password field exists for setting credentials

### 3. Test Staff Entry
- Navigate to: **Add Staff**
- **Verify**:
  - ✅ Same Program Type → Department filtering works
  - ✅ Password field exists

### 4. Create Test Student
- Fill all fields
- Set Student ID (e.g., `ST2024001`)
- Set Password (e.g., `test123`)
- Submit

### 5. Test Student Login
- Logout from Office
- Go to: **Student Portal**
- Login with the Student ID and password you just created
- **Verify**: Student cannot access settings to change credentials

---

## 📝 Summary of Changes

### Backend
- ✅ Fixed `Section` entity (added missing `@Id`)
- ✅ Added `findByType()` to `DepartmentRepository`
- ✅ Updated `OfficeController` for dynamic filtering
- ✅ Password now set by Office (not hardcoded)

### Frontend
- ✅ Program Type dropdown (UG/PG)
- ✅ Dynamic Department filtering
- ✅ Dynamic Year selection
- ✅ "Student Email" label
- ✅ Password field for Office

---

## 🔧 Troubleshooting

**Backend won't start?**
- Check if MySQL is running
- Verify database `college_erp` exists
- Check `application.properties` for correct DB credentials

**Frontend issues?**
- Clear browser cache
- Check console for errors (F12)
- Restart dev server if needed

**Department dropdown empty?**
- Ensure departments are seeded in database
- Check department `type` field is set to `UG` or `PG`
