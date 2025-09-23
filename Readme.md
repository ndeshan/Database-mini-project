# 🎓 University of Ruhuna - ICT Level 1 Semester 2 Student Management System

> **Course**: ICT1222 - Database Management Systems Practicum  
> **Project**: Mini Project - Student Marks, Attendance & Result Management System  
> **Compliance**: UGC Circular No. 12-2024  
> **Submitted to**: Mr. P.H.P. Nuwan Laksiri  
> **Group**: <Your Group Number>  
> **Submitted by**:  
> - `<Index No> - <Full Name>`  
> - `<Index No> - <Full Name>`  

---

## 📌 Overview

This project implements a **relational database system** for managing **student records, attendance, continuous assessment (CA) marks, final grades, SGPA/CGPA**, and **eligibility** according to **UGC Circular No. 12-2024** for the **Department of ICT, Faculty of Technology, University of Ruhuna**.

The system supports:
- Proper, Repeat, and Suspended student types
- Theory & Practical attendance tracking (with medical exemptions)
- CA and Final Exam marks recording (all out of 100)
- Automatic grade calculation (A+, A, B+, ..., F) with caps for Repeat (max 'C') and Suspended (display 'WH') students
- SGPA/CGPA computation
- Role-based access control (Admin, Dean, Lecturer, Technical Officer, Student)

---

## ✅ Features & Compliance

### 🎯 UGC 12-2024 Compliance
- ✅ Grade Scale: A+ (90-100) to F (0-49.99) with Grade Points
- ✅ Repeat Students → Max Grade = 'C'
- ✅ Suspended Students → All Grades = 'WH'
- ✅ Medical Certificate (MC) → Display 'MC' if medical submitted for CA/Final
- ✅ Attendance Eligibility → ≥80% (Theory + Practical separately or combined)
- ✅ CA Eligibility → CA Marks ≥40 to sit Final Exam

### 📊 Data Coverage
- ✅ 10+ Proper Students
- ✅ 5+ Repeat Students
- ✅ 5+ Suspended Students
- ✅ 5+ Lecturers
- ✅ 5+ Technical Officers
- ✅ Attendance: ≥80%, <80%, with/without medical
- ✅ Marks: Quiz, Assessment, Mid-Semester, Mid-Practical, Mid-Theory, Final-Theory, Final-Practical

### 🔐 Security & User Roles
| Role | Privileges |
|------|------------|
| `admin` | All privileges + `WITH GRANT OPTION` |
| `dean` | All privileges (no grant) |
| `lecturer` | All privileges (no grant, no user creation) |
| `to` (Technical Officer) | Read/Write/Update on `ATTENDENCE`, `MEDICAL_RECORD` |
| `student` | Read-only on final grades & attendance views |

---

## 🗃️ Database Schema

### 🖼️ ER Diagram
*(Insert screenshot of your ER Diagram here — e.g., `er_diagram.png`)*

### 📄 Relational Schema
See `schema.sql` for full table structure.

Key Tables:
- `USER`, `STUDENT`, `COURSE_UNIT`
- `MARK`, `ATTENDENCE`, `MEDICAL_RECORD`
- `GRADE_SCALE`, `STUDENT_RESULT`, `COURSE_ENROLLMENT`
- `USER_ROLE`, `USER_CONTACT`, `STUDENT_COURSE`

---

## ⚙️ Technologies Used

- **Database**: MySQL 8.0+
- **Tools**: MySQL Workbench, VS Code, GitHub
- **Platform**: Localhost (XAMPP / Docker / Cloud-ready)

---

## 🚀 Setup & Installation

### 1. Clone the Repository
```bash
git clone https://github.com/ndeshan/Database-mini-project.git
cd ict1222-mini-project