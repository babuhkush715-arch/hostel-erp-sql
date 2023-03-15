# Hostel ERP — SQL Database Project

A complete **Hostel Management System** built using SQLite, demonstrating real-world database design with 12 tables, 318+ records, 20 analytical SQL queries, and Python visualizations.

---

## Project Structure

```
hostel-erp-sql/
├── data/
│   └── hostel_erp.db             # SQLite database
├── sql/
│   ├── schema.sql                # 12 tables, constraints, 41 indexes
│   ├── seed_data.sql             # 318 realistic dummy records
│   └── queries.sql               # 20 analytical queries
├── analysis/
│   ├── analysis.py               # Python visualization script
│   └── charts/                   # 6 generated PNG charts
│       ├── 01_dept_student_count.png
│       ├── 02_block_occupancy.png
│       ├── 03_fee_payment_status.png
│       ├── 04_complaint_types.png
│       ├── 05_staff_attendance_heatmap.png
│       └── 06_maintenance_cost.png
└── README.md
```

---

## Database Schema — 12 Tables

| Module | Tables | Description |
|--------|--------|-------------|
| Core | `students`, `rooms`, `room_allotments` | Student and room master data |
| Finance | `fee_structure`, `fee_payments` | Fee rates and payment ledger |
| Staff | `staff`, `staff_attendance` | Staff records and daily attendance |
| Operations | `complaints`, `maintenance_requests` | Issue and repair tracking |
| Facilities | `mess_menu`, `visitor_log`, `gate_pass` | Daily hostel operations |

---

## Seed Data Summary

| Table | Records |
|-------|---------|
| students | 30 |
| rooms | 20 |
| room_allotments | 28 |
| staff | 10 |
| fee_structure | 12 |
| fee_payments | 50 |
| staff_attendance | 60 |
| complaints | 20 |
| maintenance_requests | 15 |
| mess_menu | 28 |
| visitor_log | 20 |
| gate_pass | 25 |
| **Total** | **318** |

---

## Key Features

- **Normalized schema** with proper foreign keys and referential integrity
- **CHECK constraints** for data validation — status, gender, room_type, payment_mode etc.
- **41 indexes** across all tables for query optimization
- **ON DELETE RESTRICT / SET NULL** rules to prevent orphan records
- **UNIQUE constraints** — roll number, phone, email, employee code, mess menu slot
- **20 analytical SQL queries** covering real hostel management scenarios
- **Python visualizations** using Pandas, Matplotlib, and Seaborn

---

## SQL Concepts Demonstrated

| Concept | Example Query |
|---------|--------------|
| Multi-table JOIN | Student + Room + Allotment details |
| LEFT JOIN | Complete student profile with fees |
| Aggregate functions | Fee collection summary, attendance % |
| CASE WHEN | Gender-wise count, payment status breakdown |
| CTE | Complete student profile (Query 19) |
| Subqueries | Hostel dashboard summary (Query 20) |
| Date functions | Resolution time, gate pass overstay |
| GROUP BY + HAVING | Department-wise, block-wise analysis |
| Window concepts | Cost variance analysis |

---

## Sample Queries

```sql
-- Defaulters list
SELECT s.roll_number, s.full_name, s.department,
       SUM(fp.amount_due) AS total_due
FROM fee_payments fp
JOIN students s ON fp.student_id = s.student_id
WHERE fp.status IN ('partial', 'pending', 'overdue')
GROUP BY s.student_id
ORDER BY total_due DESC;

-- Block-wise occupancy
SELECT block_name,
       SUM(capacity)          AS total_capacity,
       SUM(current_occupancy) AS current_occupancy,
       ROUND(SUM(current_occupancy) * 100.0 / SUM(capacity), 1) AS occupancy_pct
FROM rooms
GROUP BY block_name
ORDER BY occupancy_pct DESC;

-- Hostel dashboard summary
SELECT
    (SELECT COUNT(*) FROM students WHERE status = 'active')      AS total_students,
    (SELECT COUNT(*) FROM rooms WHERE status = 'available')      AS available_rooms,
    (SELECT COUNT(*) FROM complaints WHERE status = 'open')      AS open_complaints,
    (SELECT COUNT(*) FROM fee_payments WHERE status = 'overdue') AS overdue_payments,
    (SELECT ROUND(SUM(current_occupancy)*100.0/SUM(capacity),1)
     FROM rooms)                                                  AS overall_occupancy_pct;
```

---

## Charts Generated

| # | Chart | Insight |
|---|-------|---------|
| 01 | Department-wise student count by gender | CS has highest enrollment (10 students) |
| 02 | Block-wise room occupancy % | B Block most occupied at 84.6% |
| 03 | Fee payment status distribution | 82% payments completed on time |
| 04 | Complaint type breakdown | Electrical issues most common |
| 05 | Staff attendance summary | Per-staff present/absent/half-day |
| 06 | Maintenance cost: estimated vs actual | Electrical shows cost overrun |

---

## How to Run

### Prerequisites
- Python 3.x
- SQLite3 (comes with Python)

### 1. Clone the repository
```bash
git clone https://github.com/babuhkush715-arc/hostel-erp-sql.git
cd hostel-erp-sql
```

### 2. Setup database
```bash
sqlite3 data/hostel_erp.db < sql/schema.sql
sqlite3 data/hostel_erp.db < sql/seed_data.sql
```

### 3. Run analytical queries
```bash
sqlite3 data/hostel_erp.db < sql/queries.sql
```

### 4. Install Python dependencies
```bash
pip install pandas matplotlib seaborn
```

### 5. Generate charts
```bash
python analysis/analysis.py
```

---

## Tools & Technologies

| Tool | Purpose |
|------|---------|
| SQLite 3 | Database engine |
| Python 3 | Data analysis and visualization |
| Pandas | Data manipulation |
| Matplotlib | Chart generation |
| Seaborn | Statistical visualization |
| VS Code | Development environment |
| DB Browser for SQLite | Database GUI |

---

## Author

**Babusingh Kushwaha**
Technical Associate | Deputed in VNIT College (Principal Security & Allied Services Pvt. Ltd.)
M.Sc. Electronics | IoT & Industrial Data Analytics

[![GitHub](https://img.shields.io/badge/GitHub-babuhkush715--arch-blue)](https://github.com/babuhkush715-arch)

---

## Related Projects

- [India Air Quality Analytics](https://github.com/babuhkush715-arch/india-air-quality-analytics) — End-to-end AQI analysis using Python, SQLite, and Power BI
