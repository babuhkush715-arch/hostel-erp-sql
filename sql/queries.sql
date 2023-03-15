-- =============================================
-- HOSTEL ERP — Analytical Queries
-- =============================================

-- =============================================
-- MODULE 1: CORE QUERIES
-- =============================================

-- Query 1: Department-wise student count
SELECT department,
       COUNT(*) AS total_students,
       SUM(CASE WHEN gender = 'male'   THEN 1 ELSE 0 END) AS male,
       SUM(CASE WHEN gender = 'female' THEN 1 ELSE 0 END) AS female
FROM students
WHERE status = 'active'
GROUP BY department
ORDER BY total_students DESC;

-- Query 2: Room occupancy status summary
SELECT room_type,
       COUNT(*)                                                      AS total_rooms,
       SUM(CASE WHEN status = 'available'         THEN 1 ELSE 0 END) AS available,
       SUM(CASE WHEN status = 'occupied'          THEN 1 ELSE 0 END) AS occupied,
       SUM(CASE WHEN status = 'under_maintenance' THEN 1 ELSE 0 END) AS under_maintenance,
       ROUND(SUM(current_occupancy) * 100.0 / SUM(capacity), 1)     AS occupancy_pct
FROM rooms
GROUP BY room_type
ORDER BY room_type;

-- Query 3: Block-wise occupancy
SELECT block_name,
       SUM(capacity)          AS total_capacity,
       SUM(current_occupancy) AS current_occupancy,
       ROUND(SUM(current_occupancy) * 100.0 / SUM(capacity), 1) AS occupancy_pct
FROM rooms
GROUP BY block_name
ORDER BY occupancy_pct DESC;

-- Query 4: Students with room details (JOIN)
SELECT s.roll_number, s.full_name, s.department, s.year_of_study,
       r.room_number, r.block_name, r.room_type
FROM students s
JOIN room_allotments ra ON s.student_id = ra.student_id
JOIN rooms r            ON ra.room_id   = r.room_id
WHERE ra.status = 'active'
ORDER BY r.block_name, r.room_number;

-- Query 5: Available rooms list
SELECT room_number, block_name, floor_number, room_type, 
       capacity, rent_per_month
FROM rooms
WHERE status = 'available'
ORDER BY block_name, room_number;
-- =============================================
-- MODULE 2: FINANCE QUERIES
-- =============================================

-- Query 6: Fee collection summary by payment mode
SELECT payment_mode,
       COUNT(*)            AS total_transactions,
       SUM(amount_paid)    AS total_collected,
       SUM(amount_due)     AS total_pending
FROM fee_payments
GROUP BY payment_mode
ORDER BY total_collected DESC;

-- Query 7: Defaulters list (students with pending dues)
SELECT s.roll_number, s.full_name, s.department,
       SUM(fp.amount_due) AS total_due
FROM fee_payments fp
JOIN students s ON fp.student_id = s.student_id
WHERE fp.status IN ('partial', 'pending', 'overdue')
GROUP BY s.student_id
ORDER BY total_due DESC;

-- Query 8: Monthly fee collection
SELECT strftime('%Y-%m', payment_date) AS month,
       COUNT(*)                         AS transactions,
       SUM(amount_paid)                 AS total_collected
FROM fee_payments
WHERE status IN ('paid', 'partial')
GROUP BY month
ORDER BY month;

-- Query 9: Payment status breakdown
SELECT status,
       COUNT(*)         AS count,
       SUM(amount_paid) AS amount_paid,
       SUM(amount_due)  AS amount_due
FROM fee_payments
GROUP BY status
ORDER BY count DESC;

-- =============================================
-- MODULE 3: STAFF QUERIES
-- =============================================

-- Query 10: Staff attendance summary
SELECT s.full_name, s.role, s.shift,
       COUNT(*)  AS total_days,
       SUM(CASE WHEN sa.attendance_status = 'present'  THEN 1 ELSE 0 END) AS present,
       SUM(CASE WHEN sa.attendance_status = 'absent'   THEN 1 ELSE 0 END) AS absent,
       SUM(CASE WHEN sa.attendance_status = 'half_day' THEN 1 ELSE 0 END) AS half_day,
       ROUND(SUM(CASE WHEN sa.attendance_status = 'present'
                      THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1)           AS attendance_pct
FROM staff s
JOIN staff_attendance sa ON s.staff_id = sa.staff_id
GROUP BY s.staff_id
ORDER BY attendance_pct DESC;

-- Query 11: Average working hours per role
SELECT s.role,
       ROUND(AVG(
           (strftime('%H', sa.check_out_time) * 60 + strftime('%M', sa.check_out_time)) -
           (strftime('%H', sa.check_in_time)  * 60 + strftime('%M', sa.check_in_time))
       ) / 60.0, 2) AS avg_hours_per_day
FROM staff_attendance sa
JOIN staff s ON sa.staff_id = s.staff_id
WHERE sa.attendance_status = 'present'
  AND sa.check_out_time IS NOT NULL
  AND sa.check_in_time  IS NOT NULL
GROUP BY s.role
ORDER BY avg_hours_per_day DESC;
-- =============================================
-- MODULE 4: OPERATIONS QUERIES
-- =============================================

-- Query 12: Complaint status summary
SELECT complaint_type,
       COUNT(*) AS total,
       SUM(CASE WHEN status = 'open'        THEN 1 ELSE 0 END) AS open,
       SUM(CASE WHEN status = 'in_progress' THEN 1 ELSE 0 END) AS in_progress,
       SUM(CASE WHEN status = 'resolved'    THEN 1 ELSE 0 END) AS resolved,
       SUM(CASE WHEN status = 'closed'      THEN 1 ELSE 0 END) AS closed
FROM complaints
GROUP BY complaint_type
ORDER BY total DESC;

-- Query 13: Average complaint resolution time
SELECT complaint_type,
       COUNT(*)  AS resolved_count,
       ROUND(AVG(julianday(resolved_on) - julianday(raised_on)), 1) AS avg_days
FROM complaints
WHERE status IN ('resolved', 'closed')
  AND resolved_on IS NOT NULL
GROUP BY complaint_type
ORDER BY avg_days DESC;

-- Query 14: Most complaint-prone rooms
SELECT r.room_number, r.block_name, r.room_type,
       COUNT(c.complaint_id) AS total_complaints
FROM complaints c
JOIN rooms r ON c.room_id = r.room_id
GROUP BY r.room_id
ORDER BY total_complaints DESC
LIMIT 5;

-- Query 15: Maintenance cost analysis
SELECT request_type,
       COUNT(*)                                        AS total_requests,
       SUM(estimated_cost)                             AS total_estimated,
       SUM(actual_cost)                                AS total_actual,
       ROUND(SUM(actual_cost) - SUM(estimated_cost),2) AS cost_overrun
FROM maintenance_requests
WHERE status = 'completed'
GROUP BY request_type
ORDER BY total_actual DESC;

-- =============================================
-- MODULE 5: FACILITIES QUERIES
-- =============================================

-- Query 16: Gate pass analysis by type
SELECT pass_type,
       COUNT(*) AS total,
       SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed,
       SUM(CASE WHEN status = 'approved'  THEN 1 ELSE 0 END) AS approved,
       SUM(CASE WHEN status = 'pending'   THEN 1 ELSE 0 END) AS pending,
       SUM(CASE WHEN status = 'rejected'  THEN 1 ELSE 0 END) AS rejected
FROM gate_pass
GROUP BY pass_type
ORDER BY total DESC;

-- Query 17: Late return students
SELECT s.full_name, s.roll_number,
       gp.pass_type, gp.destination,
       ROUND((julianday(gp.actual_return)
            - julianday(gp.expected_return)) * 24, 1) AS hours_late
FROM gate_pass gp
JOIN students s ON gp.student_id = s.student_id
WHERE gp.actual_return > gp.expected_return
ORDER BY hours_late DESC;

-- Query 18: Visitor frequency per student
SELECT s.full_name, s.roll_number, s.department,
       COUNT(vl.visitor_id)  AS total_visits,
       SUM(vl.num_visitors)  AS total_visitors
FROM visitor_log vl
JOIN students s ON vl.student_id = s.student_id
GROUP BY s.student_id
ORDER BY total_visits DESC
LIMIT 10;

-- =============================================
-- BONUS: CROSS-MODULE QUERIES
-- =============================================

-- Query 19: Complete student profile (CTE)
WITH student_fees AS (
    SELECT student_id,
           SUM(amount_paid) AS total_paid,
           SUM(amount_due)  AS total_due
    FROM fee_payments
    GROUP BY student_id
),
student_complaints AS (
    SELECT student_id,
           COUNT(*) AS total_complaints
    FROM complaints
    GROUP BY student_id
)
SELECT s.roll_number, s.full_name, s.department,
       r.room_number, r.block_name,
       COALESCE(sf.total_paid, 0) AS fees_paid,
       COALESCE(sf.total_due,  0) AS fees_due,
       COALESCE(sc.total_complaints, 0) AS complaints
FROM students s
LEFT JOIN room_allotments ra ON s.student_id = ra.student_id AND ra.status = 'active'
LEFT JOIN rooms r            ON ra.room_id = r.room_id
LEFT JOIN student_fees sf    ON s.student_id = sf.student_id
LEFT JOIN student_complaints sc ON s.student_id = sc.student_id
ORDER BY s.roll_number;

-- Query 20: Hostel dashboard summary (window function)
SELECT
    (SELECT COUNT(*) FROM students WHERE status = 'active')        AS total_students,
    (SELECT COUNT(*) FROM rooms WHERE status = 'available')        AS available_rooms,
    (SELECT COUNT(*) FROM complaints WHERE status = 'open')        AS open_complaints,
    (SELECT COUNT(*) FROM fee_payments WHERE status = 'overdue')   AS overdue_payments,
    (SELECT COUNT(*) FROM gate_pass WHERE status = 'pending')      AS pending_gate_passes,
    (SELECT ROUND(SUM(current_occupancy)*100.0/SUM(capacity),1)
     FROM rooms)                                                    AS overall_occupancy_pct;