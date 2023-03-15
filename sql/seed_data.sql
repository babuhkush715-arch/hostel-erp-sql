-- Clear old data before inserting
DELETE FROM gate_pass;
DELETE FROM visitor_log;
DELETE FROM mess_menu;
DELETE FROM maintenance_requests;
DELETE FROM complaints;
DELETE FROM staff_attendance;
DELETE FROM fee_payments;
DELETE FROM fee_structure;
DELETE FROM room_allotments;
DELETE FROM rooms;
DELETE FROM staff;
DELETE FROM students;

-- AUTOINCREMENT counters reset karo
DELETE FROM sqlite_sequence;
-- =============================================
-- SEED DATA — Hostel ERP
-- =============================================

-- ---------------------------------------------
-- Staff (10 records)
-- ---------------------------------------------
INSERT INTO staff (employee_code, full_name, role, department, phone, email, shift, joining_date, salary, status) VALUES
('EMP001', 'Rajesh Kumar',    'warden',      'hostel', '9876543201', 'rajesh@hostel.in',   'general', '2020-01-15', 45000, 'active'),
('EMP002', 'Sunita Sharma',   'caretaker',   'hostel', '9876543202', 'sunita@hostel.in',   'morning', '2021-03-10', 25000, 'active'),
('EMP003', 'Ramesh Yadav',    'security',    'hostel', '9876543203', NULL,                 'night',   '2021-06-01', 20000, 'active'),
('EMP004', 'Priya Desai',     'caretaker',   'hostel', '9876543204', 'priya@hostel.in',    'evening', '2022-01-20', 25000, 'active'),
('EMP005', 'Mohan Lal',       'security',    'hostel', '9876543205', NULL,                 'morning', '2022-04-05', 20000, 'active'),
('EMP006', 'Anita Verma',     'mess_worker', 'hostel', '9876543206', NULL,                 'morning', '2021-08-15', 18000, 'active'),
('EMP007', 'Suresh Patel',    'electrician', 'hostel', '9876543207', NULL,                 'general', '2020-11-01', 22000, 'active'),
('EMP008', 'Kavita Singh',    'cleaner',     'hostel', '9876543208', NULL,                 'morning', '2023-02-10', 15000, 'active'),
('EMP009', 'Dinesh Mishra',   'plumber',     'hostel', '9876543209', NULL,                 'general', '2021-09-20', 22000, 'active'),
('EMP010', 'Meena Joshi',     'mess_worker', 'hostel', '9876543210', NULL,                 'evening', '2022-07-01', 18000, 'active');

-- ---------------------------------------------
-- Rooms (20 records)
-- ---------------------------------------------
INSERT INTO rooms (room_number, block_name, floor_number, room_type, capacity, current_occupancy, rent_per_month, status) VALUES
('A101', 'A Block', '1st', 'single', 1, 1, 5000, 'occupied'),
('A102', 'A Block', '1st', 'single', 1, 0, 5000, 'available'),
('A103', 'A Block', '1st', 'double', 2, 2, 3500, 'occupied'),
('A104', 'A Block', '1st', 'double', 2, 1, 3500, 'occupied'),
('A201', 'A Block', '2nd', 'single', 1, 1, 5000, 'occupied'),
('A202', 'A Block', '2nd', 'triple', 3, 3, 2500, 'occupied'),
('A203', 'A Block', '2nd', 'double', 2, 0, 3500, 'under_maintenance'),
('B101', 'B Block', '1st', 'single', 1, 1, 5000, 'occupied'),
('B102', 'B Block', '1st', 'double', 2, 2, 3500, 'occupied'),
('B103', 'B Block', '1st', 'triple', 3, 2, 2500, 'occupied'),
('B104', 'B Block', '1st', 'single', 1, 0, 5000, 'available'),
('B201', 'B Block', '2nd', 'double', 2, 2, 3500, 'occupied'),
('B202', 'B Block', '2nd', 'triple', 3, 3, 2500, 'occupied'),
('B203', 'B Block', '2nd', 'single', 1, 1, 5000, 'occupied'),
('C101', 'C Block', '1st', 'double', 2, 1, 3500, 'occupied'),
('C102', 'C Block', '1st', 'triple', 3, 0, 2500, 'available'),
('C103', 'C Block', '1st', 'single', 1, 1, 5000, 'occupied'),
('C201', 'C Block', '2nd', 'double', 2, 2, 3500, 'occupied'),
('C202', 'C Block', '2nd', 'triple', 3, 3, 2500, 'occupied'),
('C203', 'C Block', '2nd', 'single', 1, 0, 5000, 'available');

-- ---------------------------------------------
-- Students (30 records)
-- ---------------------------------------------
INSERT INTO students (roll_number, full_name, gender, department, year_of_study, phone, email, guardian_name, guardian_phone, admission_date, status) VALUES
('CS2021001', 'Amit Sharma',       'male',   'Computer Science',    '3rd', '9811001001', 'amit.sharma@student.in',    'Ramesh Sharma',   '9811002001', '2021-07-15', 'active'),
('CS2021002', 'Priya Singh',       'female', 'Computer Science',    '3rd', '9811001002', 'priya.singh@student.in',    'Suresh Singh',    '9811002002', '2021-07-15', 'active'),
('EC2021003', 'Rahul Verma',       'male',   'Electronics',         '3rd', '9811001003', 'rahul.verma@student.in',    'Mohan Verma',     '9811002003', '2021-07-20', 'active'),
('ME2022004', 'Sneha Patel',       'female', 'Mechanical',          '2nd', '9811001004', 'sneha.patel@student.in',    'Dinesh Patel',    '9811002004', '2022-07-18', 'active'),
('CE2022005', 'Vikram Yadav',      'male',   'Civil',               '2nd', '9811001005', 'vikram.yadav@student.in',   'Rajesh Yadav',    '9811002005', '2022-07-18', 'active'),
('CS2022006', 'Anjali Gupta',      'female', 'Computer Science',    '2nd', '9811001006', 'anjali.gupta@student.in',   'Anil Gupta',      '9811002006', '2022-07-20', 'active'),
('EC2022007', 'Rohit Kumar',       'male',   'Electronics',         '2nd', '9811001007', 'rohit.kumar@student.in',    'Vijay Kumar',     '9811002007', '2022-07-20', 'active'),
('CS2023008', 'Pooja Mishra',      'female', 'Computer Science',    '1st', '9811001008', 'pooja.mishra@student.in',   'Sanjay Mishra',   '9811002008', '2023-07-17', 'active'),
('ME2023009', 'Arjun Tiwari',      'male',   'Mechanical',          '1st', '9811001009', 'arjun.tiwari@student.in',   'Prakash Tiwari',  '9811002009', '2023-07-17', 'active'),
('CE2023010', 'Neha Joshi',        'female', 'Civil',               '1st', '9811001010', 'neha.joshi@student.in',     'Sunil Joshi',     '9811002010', '2023-07-19', 'active'),
('CS2020011', 'Deepak Chauhan',    'male',   'Computer Science',    '4th', '9811001011', 'deepak.chauhan@student.in', 'Hemant Chauhan',  '9811002011', '2020-07-15', 'active'),
('EC2020012', 'Ritu Agarwal',      'female', 'Electronics',         '4th', '9811001012', 'ritu.agarwal@student.in',   'Manoj Agarwal',   '9811002012', '2020-07-15', 'active'),
('ME2021013', 'Saurabh Dubey',     'male',   'Mechanical',          '3rd', '9811001013', 'saurabh.dubey@student.in',  'Ramesh Dubey',    '9811002013', '2021-07-22', 'active'),
('CE2021014', 'Kavya Nair',        'female', 'Civil',               '3rd', '9811001014', 'kavya.nair@student.in',     'Rajan Nair',      '9811002014', '2021-07-22', 'active'),
('CS2021015', 'Manish Pandey',     'male',   'Computer Science',    '3rd', '9811001015', 'manish.pandey@student.in',  'Rakesh Pandey',   '9811002015', '2021-07-25', 'active'),
('EC2023016', 'Divya Saxena',      'female', 'Electronics',         '1st', '9811001016', 'divya.saxena@student.in',   'Ashok Saxena',    '9811002016', '2023-07-21', 'active'),
('ME2022017', 'Nikhil Srivastava', 'male',   'Mechanical',          '2nd', '9811001017', 'nikhil.sri@student.in',     'Arun Srivastava', '9811002017', '2022-07-22', 'active'),
('CS2020018', 'Shruti Bhatt',      'female', 'Computer Science',    '4th', '9811001018', 'shruti.bhatt@student.in',   'Nilesh Bhatt',    '9811002018', '2020-07-18', 'active'),
('CE2022019', 'Yash Malhotra',     'male',   'Civil',               '2nd', '9811001019', 'yash.malhotra@student.in',  'Vikas Malhotra',  '9811002019', '2022-07-25', 'active'),
('EC2021020', 'Simran Kaur',       'female', 'Electronics',         '3rd', '9811001020', 'simran.kaur@student.in',    'Gurpreet Kaur',   '9811002020', '2021-07-28', 'active'),
('CS2023021', 'Harsh Vardhan',     'male',   'Computer Science',    '1st', '9811001021', 'harsh.v@student.in',        'Suresh Vardhan',  '9811002021', '2023-07-23', 'active'),
('ME2020022', 'Pallavi Reddy',     'female', 'Mechanical',          '4th', '9811001022', 'pallavi.reddy@student.in',  'Krishna Reddy',   '9811002022', '2020-07-20', 'active'),
('CE2023023', 'Kunal Mehta',       'male',   'Civil',               '1st', '9811001023', 'kunal.mehta@student.in',    'Sanjiv Mehta',    '9811002023', '2023-07-25', 'active'),
('CS2022024', 'Tanvi Kulkarni',    'female', 'Computer Science',    '2nd', '9811001024', 'tanvi.kulkarni@student.in', 'Pramod Kulkarni', '9811002024', '2022-07-28', 'active'),
('EC2020025', 'Akash Bansal',      'male',   'Electronics',         '4th', '9811001025', 'akash.bansal@student.in',   'Ramesh Bansal',   '9811002025', '2020-07-22', 'active'),
('ME2023026', 'Ishita Roy',        'female', 'Mechanical',          '1st', '9811001026', 'ishita.roy@student.in',     'Debashish Roy',   '9811002026', '2023-07-27', 'active'),
('CE2021027', 'Varun Thakur',      'male',   'Civil',               '3rd', '9811001027', 'varun.thakur@student.in',   'Ajay Thakur',     '9811002027', '2021-07-30', 'active'),
('CS2022028', 'Meghna Das',        'female', 'Computer Science',    '2nd', '9811001028', 'meghna.das@student.in',     'Tapan Das',       '9811002028', '2022-07-30', 'active'),
('EC2023029', 'Ritesh Jain',       'male',   'Electronics',         '1st', '9811001029', 'ritesh.jain@student.in',    'Mukesh Jain',     '9811002029', '2023-07-29', 'active'),
('ME2021030', 'Swati Pillai',      'female', 'Mechanical',          '3rd', '9811001030', 'swati.pillai@student.in',   'Ramesh Pillai',   '9811002030', '2021-08-01', 'active');

-- ---------------------------------------------
-- Room Allotments (28 records)
-- ---------------------------------------------
INSERT INTO room_allotments (student_id, room_id, allotment_date, vacating_date, status) VALUES
(1,  1,  '2021-07-15', NULL,         'active'),
(2,  3,  '2021-07-15', NULL,         'active'),
(3,  3,  '2021-07-20', NULL,         'active'),
(4,  4,  '2022-07-18', NULL,         'active'),
(5,  8,  '2022-07-18', NULL,         'active'),
(6,  9,  '2022-07-20', NULL,         'active'),
(7,  9,  '2022-07-20', NULL,         'active'),
(8,  10, '2023-07-17', NULL,         'active'),
(9,  10, '2023-07-17', NULL,         'active'),
(10, 15, '2023-07-19', NULL,         'active'),
(11, 5,  '2020-07-15', NULL,         'active'),
(12, 6,  '2020-07-15', NULL,         'active'),
(13, 6,  '2021-07-22', NULL,         'active'),
(14, 6,  '2021-07-22', NULL,         'active'),
(15, 13, '2021-07-25', NULL,         'active'),
(16, 16, '2023-07-21', NULL,         'active'),
(17, 12, '2022-07-22', NULL,         'active'),
(18, 18, '2020-07-18', NULL,         'active'),
(19, 12, '2022-07-25', NULL,         'active'),
(20, 20, '2021-07-28', NULL,         'active'),
(21, 19, '2023-07-23', NULL,         'active'),
(22, 22, '2020-07-20', NULL,         'active'),
(23, 14, '2023-07-25', NULL,         'active'),
(24, 11, '2022-07-28', NULL,         'active'),
(25, 13, '2020-07-22', NULL,         'active'),
(26, 17, '2023-07-27', NULL,         'active'),
(27, 21, '2021-07-30', NULL,         'active'),
(28, 18, '2022-07-30', NULL,         'active');

-- ---------------------------------------------
-- Fee Structure (12 records)
-- ---------------------------------------------
INSERT INTO fee_structure (fee_category, room_type, amount, academic_year, semester, description, effective_from, effective_to) VALUES
('hostel_rent',          'single', 5000, '2023-24', 'odd',    'Single room rent per month',         '2023-07-01', '2024-06-30'),
('hostel_rent',          'double', 3500, '2023-24', 'odd',    'Double room rent per month',         '2023-07-01', '2024-06-30'),
('hostel_rent',          'triple', 2500, '2023-24', 'odd',    'Triple room rent per month',         '2023-07-01', '2024-06-30'),
('mess_charges',         'all',    2500, '2023-24', 'odd',    'Monthly mess charges',               '2023-07-01', '2024-06-30'),
('security_deposit',     'single', 10000,'2023-24', 'annual', 'One time security deposit single',   '2023-07-01', '2024-06-30'),
('security_deposit',     'double', 7000, '2023-24', 'annual', 'One time security deposit double',   '2023-07-01', '2024-06-30'),
('security_deposit',     'triple', 5000, '2023-24', 'annual', 'One time security deposit triple',   '2023-07-01', '2024-06-30'),
('maintenance_charges',  'all',    500,  '2023-24', 'odd',    'Monthly maintenance charges',        '2023-07-01', '2024-06-30'),
('electricity_charges',  'single', 800,  '2023-24', 'odd',    'Monthly electricity single room',    '2023-07-01', '2024-06-30'),
('electricity_charges',  'double', 600,  '2023-24', 'odd',    'Monthly electricity double room',    '2023-07-01', '2024-06-30'),
('electricity_charges',  'triple', 400,  '2023-24', 'odd',    'Monthly electricity triple room',    '2023-07-01', '2024-06-30'),
('mess_charges',         'all',    2500, '2023-24', 'even',   'Monthly mess charges even semester', '2024-01-01', '2024-06-30');

-- ---------------------------------------------
-- Fee Payments (50 records)
-- ---------------------------------------------
INSERT INTO fee_payments (student_id, fee_id, amount_paid, amount_due, payment_date, due_date, payment_mode, transaction_ref, status) VALUES
(1,  1, 5000, 0,    '2023-07-20', '2023-07-31', 'upi',   'UPI001', 'paid'),
(1,  4, 2500, 0,    '2023-07-20', '2023-07-31', 'upi',   'UPI002', 'paid'),
(2,  2, 3500, 0,    '2023-07-21', '2023-07-31', 'neft',  'NEFT001','paid'),
(2,  4, 2500, 0,    '2023-07-21', '2023-07-31', 'neft',  'NEFT002','paid'),
(3,  2, 3500, 0,    '2023-07-22', '2023-07-31', 'cash',  NULL,     'paid'),
(3,  4, 2000, 500,  '2023-07-22', '2023-07-31', 'cash',  NULL,     'partial'),
(4,  2, 3500, 0,    '2023-08-01', '2023-07-31', 'upi',   'UPI003', 'paid'),
(4,  4, 2500, 0,    '2023-08-01', '2023-07-31', 'upi',   'UPI004', 'paid'),
(5,  1, 5000, 0,    '2023-07-25', '2023-07-31', 'cheque','CHQ001', 'paid'),
(5,  4, 2500, 0,    '2023-07-25', '2023-07-31', 'cheque','CHQ002', 'paid'),
(6,  2, 3500, 0,    '2023-07-23', '2023-07-31', 'upi',   'UPI005', 'paid'),
(6,  4, 1500, 1000, '2023-07-23', '2023-07-31', 'upi',   'UPI006', 'partial'),
(7,  2, 3500, 0,    '2023-07-24', '2023-07-31', 'neft',  'NEFT003','paid'),
(7,  4, 2500, 0,    '2023-07-24', '2023-07-31', 'neft',  'NEFT004','paid'),
(8,  2, 3500, 0,    '2023-07-20', '2023-07-31', 'upi',   'UPI007', 'paid'),
(8,  4, 2500, 0,    '2023-07-20', '2023-07-31', 'upi',   'UPI008', 'paid'),
(9,  3, 2500, 0,    '2023-07-21', '2023-07-31', 'cash',  NULL,     'paid'),
(9,  4, 2500, 0,    '2023-07-21', '2023-07-31', 'cash',  NULL,     'paid'),
(10, 2, 3500, 0,    '2023-07-22', '2023-07-31', 'upi',   'UPI009', 'paid'),
(10, 4, 0,    2500, '2023-07-22', '2023-07-31', 'upi',   NULL,     'pending'),
(11, 1, 5000, 0,    '2023-07-18', '2023-07-31', 'neft',  'NEFT005','paid'),
(11, 4, 2500, 0,    '2023-07-18', '2023-07-31', 'neft',  'NEFT006','paid'),
(12, 3, 2500, 0,    '2023-07-19', '2023-07-31', 'upi',   'UPI010', 'paid'),
(12, 4, 2500, 0,    '2023-07-19', '2023-07-31', 'upi',   'UPI011', 'paid'),
(13, 3, 2500, 0,    '2023-07-20', '2023-07-31', 'cash',  NULL,     'paid'),
(13, 4, 2000, 500,  '2023-07-20', '2023-07-31', 'cash',  NULL,     'partial'),
(14, 2, 3500, 0,    '2023-07-21', '2023-07-31', 'upi',   'UPI012', 'paid'),
(14, 4, 2500, 0,    '2023-07-21', '2023-07-31', 'upi',   'UPI013', 'paid'),
(15, 3, 2500, 0,    '2023-07-22', '2023-07-31', 'cheque','CHQ003', 'paid'),
(15, 4, 2500, 0,    '2023-07-22', '2023-07-31', 'cheque','CHQ004', 'paid'),
(16, 2, 0,    3500, '2023-07-25', '2023-07-31', 'upi',   NULL,     'pending'),
(16, 4, 0,    2500, '2023-07-25', '2023-07-31', 'upi',   NULL,     'pending'),
(17, 2, 3500, 0,    '2023-07-23', '2023-07-31', 'neft',  'NEFT007','paid'),
(17, 4, 2500, 0,    '2023-07-23', '2023-07-31', 'neft',  'NEFT008','paid'),
(18, 1, 5000, 0,    '2023-07-20', '2023-07-31', 'upi',   'UPI014', 'paid'),
(18, 4, 2500, 0,    '2023-07-20', '2023-07-31', 'upi',   'UPI015', 'paid'),
(19, 2, 3500, 0,    '2023-08-05', '2023-07-31', 'cash',  NULL,     'paid'),
(19, 4, 1000, 1500, '2023-08-05', '2023-07-31', 'cash',  NULL,     'partial'),
(20, 1, 5000, 0,    '2023-07-24', '2023-07-31', 'upi',   'UPI016', 'paid'),
(20, 4, 2500, 0,    '2023-07-24', '2023-07-31', 'upi',   'UPI017', 'paid'),
(21, 3, 0,    2500, '2023-07-26', '2023-07-31', 'upi',   NULL,     'overdue'),
(21, 4, 0,    2500, '2023-07-26', '2023-07-31', 'upi',   NULL,     'overdue'),
(22, 1, 5000, 0,    '2023-07-19', '2023-07-31', 'neft',  'NEFT009','paid'),
(22, 4, 2500, 0,    '2023-07-19', '2023-07-31', 'neft',  'NEFT010','paid'),
(23, 3, 2500, 0,    '2023-07-21', '2023-07-31', 'upi',   'UPI018', 'paid'),
(23, 4, 2500, 0,    '2023-07-21', '2023-07-31', 'upi',   'UPI019', 'paid'),
(24, 2, 3500, 0,    '2023-07-22', '2023-07-31', 'cash',  NULL,     'paid'),
(24, 4, 2500, 0,    '2023-07-22', '2023-07-31', 'cash',  NULL,     'paid'),
(25, 3, 2500, 0,    '2023-07-20', '2023-07-31', 'upi',   'UPI020', 'paid'),
(25, 4, 2500, 0,    '2023-07-20', '2023-07-31', 'upi',   'UPI021', 'paid');

-- ---------------------------------------------
-- Staff Attendance (60 records)
-- ---------------------------------------------
INSERT INTO staff_attendance (staff_id, attendance_date, check_in_time, check_out_time, attendance_status) VALUES
(1, '2024-01-01', '09:00', '17:00', 'present'),
(1, '2024-01-02', '09:05', '17:00', 'present'),
(1, '2024-01-03', NULL,    NULL,    'absent'),
(1, '2024-01-04', '09:00', '17:00', 'present'),
(1, '2024-01-05', '09:00', '13:00', 'half_day'),
(2, '2024-01-01', '07:00', '15:00', 'present'),
(2, '2024-01-02', '07:00', '15:00', 'present'),
(2, '2024-01-03', '07:00', '15:00', 'present'),
(2, '2024-01-04', NULL,    NULL,    'absent'),
(2, '2024-01-05', '07:00', '15:00', 'present'),
(3, '2024-01-01', '22:00', '06:00', 'present'),
(3, '2024-01-02', '22:00', '06:00', 'present'),
(3, '2024-01-03', '22:00', '06:00', 'present'),
(3, '2024-01-04', '22:00', '06:00', 'present'),
(3, '2024-01-05', NULL,    NULL,    'on_leave'),
(4, '2024-01-01', '15:00', '23:00', 'present'),
(4, '2024-01-02', '15:00', '23:00', 'present'),
(4, '2024-01-03', NULL,    NULL,    'absent'),
(4, '2024-01-04', '15:00', '23:00', 'present'),
(4, '2024-01-05', '15:00', '23:00', 'present'),
(5, '2024-01-01', '07:00', '15:00', 'present'),
(5, '2024-01-02', NULL,    NULL,    'absent'),
(5, '2024-01-03', '07:00', '15:00', 'present'),
(5, '2024-01-04', '07:00', '15:00', 'present'),
(5, '2024-01-05', '07:00', '15:00', 'present'),
(6, '2024-01-01', '07:00', '15:00', 'present'),
(6, '2024-01-02', '07:00', '15:00', 'present'),
(6, '2024-01-03', '07:00', '15:00', 'present'),
(6, '2024-01-04', '07:00', '15:00', 'present'),
(6, '2024-01-05', NULL,    NULL,    'holiday'),
(7, '2024-01-01', '09:00', '17:00', 'present'),
(7, '2024-01-02', '09:00', '17:00', 'present'),
(7, '2024-01-03', '09:00', '17:00', 'present'),
(7, '2024-01-04', NULL,    NULL,    'on_leave'),
(7, '2024-01-05', '09:00', '17:00', 'present'),
(8, '2024-01-01', '07:00', '15:00', 'present'),
(8, '2024-01-02', '07:00', '15:00', 'present'),
(8, '2024-01-03', NULL,    NULL,    'absent'),
(8, '2024-01-04', '07:00', '15:00', 'present'),
(8, '2024-01-05', '07:00', '15:00', 'present'),
(9, '2024-01-01', '09:00', '17:00', 'present'),
(9, '2024-01-02', NULL,    NULL,    'absent'),
(9, '2024-01-03', '09:00', '17:00', 'present'),
(9, '2024-01-04', '09:00', '17:00', 'present'),
(9, '2024-01-05', '09:00', '13:00', 'half_day'),
(10,'2024-01-01', '15:00', '23:00', 'present'),
(10,'2024-01-02', '15:00', '23:00', 'present'),
(10,'2024-01-03', '15:00', '23:00', 'present'),
(10,'2024-01-04', NULL,    NULL,    'absent'),
(10,'2024-01-05', '15:00', '23:00', 'present'),
(1, '2024-01-08', '09:00', '17:00', 'present'),
(2, '2024-01-08', '07:00', '15:00', 'present'),
(3, '2024-01-08', '22:00', '06:00', 'present'),
(4, '2024-01-08', '15:00', '23:00', 'present'),
(5, '2024-01-08', '07:00', '15:00', 'present'),
(6, '2024-01-08', '07:00', '15:00', 'present'),
(7, '2024-01-08', '09:00', '17:00', 'present'),
(8, '2024-01-08', '07:00', '15:00', 'present'),
(9, '2024-01-08', '09:00', '17:00', 'present'),
(10,'2024-01-08', '15:00', '23:00', 'present');

-- ---------------------------------------------
-- Complaints (20 records)
-- ---------------------------------------------
INSERT INTO complaints (student_id, room_id, complaint_type, description, priority, status, assigned_to, raised_on, resolved_on) VALUES
(1,  1,  'electrical',  'Fan not working in room',              'high',   'resolved',    7, '2023-08-01', '2023-08-03'),
(2,  3,  'cleanliness', 'Bathroom not cleaned regularly',       'medium', 'resolved',    8, '2023-08-02', '2023-08-04'),
(3,  3,  'noise',       'Loud noise from adjacent room',        'low',    'closed',      1, '2023-08-05', '2023-08-06'),
(4,  4,  'plumbing',    'Tap leaking in washroom',              'high',   'resolved',    9, '2023-08-07', '2023-08-09'),
(5,  8,  'electrical',  'Light bulb fused',                     'low',    'resolved',    7, '2023-08-10', '2023-08-11'),
(6,  9,  'food',        'Food quality poor in mess',            'medium', 'in_progress', 1, '2023-08-12', NULL),
(7,  9,  'cleanliness', 'Room not swept for 3 days',            'medium', 'resolved',    8, '2023-08-14', '2023-08-15'),
(8,  10, 'noise',       'Construction noise disturbing study',  'high',   'closed',      1, '2023-08-15', '2023-08-16'),
(9,  10, 'plumbing',    'Drain choked in bathroom',             'high',   'resolved',    9, '2023-08-18', '2023-08-20'),
(10, 15, 'electrical',  'Power socket not working',             'medium', 'open',        7, '2023-09-01', NULL),
(11, 5,  'theft',       'Mobile charger stolen from room',      'urgent', 'in_progress', 1, '2023-09-03', NULL),
(12, 6,  'cleanliness', 'Dustbin not emptied for 2 days',       'low',    'resolved',    8, '2023-09-05', '2023-09-06'),
(13, 6,  'food',        'Mess menu not followed on Sunday',     'medium', 'closed',      1, '2023-09-07', '2023-09-08'),
(14, 15, 'plumbing',    'Water pressure very low',              'medium', 'resolved',    9, '2023-09-10', '2023-09-12'),
(15, 13, 'electrical',  'Inverter not working during load shed', 'high',  'resolved',    7, '2023-09-15', '2023-09-17'),
(16, 16, 'noise',       'Roommates playing music late night',   'medium', 'open',        1, '2023-09-18', NULL),
(17, 12, 'cleanliness', 'Common area not mopped',               'low',    'resolved',    8, '2023-09-20', '2023-09-21'),
(18, 18, 'electrical',  'Room heater not working',              'high',   'in_progress', 7, '2023-10-01', NULL),
(19, 12, 'plumbing',    'Hot water not available in morning',   'medium', 'open',        9, '2023-10-05', NULL),
(20, 20, 'food',        'Dinner served cold regularly',         'medium', 'open',        1, '2023-10-08', NULL);

-- ---------------------------------------------
-- Maintenance Requests (15 records)
-- ---------------------------------------------
INSERT INTO maintenance_requests (room_id, raised_by, request_type, description, priority, status, assigned_to, estimated_cost, actual_cost, requested_on, completed_on) VALUES
(1,  1, 'electrical', 'Replace ceiling fan',           'high',   'completed', 7, 1500, 1400, '2023-08-01', '2023-08-03'),
(3,  2, 'plumbing',   'Fix leaking tap',               'medium', 'completed', 9, 500,  450,  '2023-08-07', '2023-08-09'),
(5,  1, 'furniture',  'Repair broken study table',     'low',    'completed', 1, 800,  750,  '2023-08-10', '2023-08-13'),
(7,  2, 'civil',      'Crack in wall near window',     'medium', 'in_progress',1, 2000, 0,   '2023-08-15', NULL),
(9,  1, 'electrical', 'Fix room wiring short circuit', 'urgent', 'completed', 7, 3000, 3200, '2023-08-18', '2023-08-19'),
(10, 2, 'plumbing',   'Replace shower head',           'low',    'completed', 9, 600,  550,  '2023-08-20', '2023-08-22'),
(12, 1, 'pest_control','Cockroach infestation',        'high',   'completed', 1, 1000, 1000, '2023-09-01', '2023-09-02'),
(13, 2, 'painting',   'Wall paint peeling off',        'low',    'pending',   NULL, 2500,0,  '2023-09-05', NULL),
(15, 1, 'electrical', 'Install new power socket',      'medium', 'completed', 7, 700,  680,  '2023-09-10', '2023-09-12'),
(16, 2, 'furniture',  'Replace broken almirah door',   'medium', 'approved',  1, 1200, 0,    '2023-09-15', NULL),
(18, 1, 'plumbing',   'Fix water heater',              'high',   'in_progress',9, 2000,0,    '2023-10-01', NULL),
(20, 2, 'civil',      'Window glass cracked',          'medium', 'pending',   NULL,1500,0,   '2023-10-05', NULL),
(6,  1, 'electrical', 'Replace tube light',            'low',    'completed', 7, 400,  380,  '2023-09-20', '2023-09-21'),
(8,  2, 'plumbing',   'Drain pipe blocked',            'high',   'completed', 9, 800,  850,  '2023-09-22', '2023-09-24'),
(11, 1, 'furniture',  'Repair bed frame',              'medium', 'completed', 1, 600,  580,  '2023-09-25', '2023-09-27');

-- ---------------------------------------------
-- Mess Menu (28 records - 7 days x 4 meals)
-- ---------------------------------------------
INSERT INTO mess_menu (day_of_week, meal_type, items, academic_year, semester, effective_from, effective_to, created_by) VALUES
('monday',    'breakfast', 'Poha, Chai, Bread Butter',              '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('monday',    'lunch',     'Dal Tadka, Rice, Roti, Aloo Sabzi',     '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('monday',    'snacks',    'Samosa, Chai',                          '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('monday',    'dinner',    'Rajma, Rice, Roti, Salad',              '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('tuesday',   'breakfast', 'Idli Sambar, Chai',                     '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('tuesday',   'lunch',     'Chhole, Rice, Roti, Raita',             '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('tuesday',   'snacks',    'Bread Pakoda, Chai',                    '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('tuesday',   'dinner',    'Dal Makhani, Rice, Roti, Papad',        '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('wednesday', 'breakfast', 'Upma, Chai, Banana',                    '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('wednesday', 'lunch',     'Kadhi Pakoda, Rice, Roti, Sabzi',       '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('wednesday', 'snacks',    'Vada Pav, Chai',                        '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('wednesday', 'dinner',    'Mix Veg, Rice, Roti, Salad',            '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('thursday',  'breakfast', 'Paratha, Curd, Chai',                   '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('thursday',  'lunch',     'Moong Dal, Rice, Roti, Bhindi Sabzi',   '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('thursday',  'snacks',    'Popcorn, Cold Drink',                   '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('thursday',  'dinner',    'Paneer Butter Masala, Rice, Roti',      '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('friday',    'breakfast', 'Puri Bhaji, Chai',                      '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('friday',    'lunch',     'Arhar Dal, Rice, Roti, Jeera Aloo',     '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('friday',    'snacks',    'Maggi, Chai',                           '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('friday',    'dinner',    'Shahi Paneer, Rice, Roti, Salad',       '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('saturday',  'breakfast', 'Dosa Sambar, Chai',                     '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('saturday',  'lunch',     'Dal Fry, Rice, Roti, Aloo Gobi',        '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('saturday',  'snacks',    'Kachori, Chai',                         '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('saturday',  'dinner',    'Matar Paneer, Rice, Roti, Papad',       '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('sunday',    'breakfast', 'Chole Bhature, Chai',                   '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('sunday',    'lunch',     'Special Pulao, Raita, Papad, Salad',    '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('sunday',    'snacks',    'Jalebi, Chai',                          '2023-24', 'odd', '2023-07-01', '2023-12-31', 1),
('sunday',    'dinner',    'Dal Makhani, Jeera Rice, Roti, Kheer',  '2023-24', 'odd', '2023-07-01', '2023-12-31', 1);

-- ---------------------------------------------
-- Visitor Log (20 records)
-- ---------------------------------------------
INSERT INTO visitor_log (student_id, visitor_name, visitor_relation, visitor_phone, num_visitors, check_in_time, check_out_time, purpose, verified_by, status) VALUES
(1,  'Ramesh Sharma',   'parent',   '9811002001', 2, '2023-08-05 10:00', '2023-08-05 13:00', 'Monthly visit',      3, 'checked_out'),
(2,  'Suresh Singh',    'parent',   '9811002002', 1, '2023-08-06 11:00', '2023-08-06 14:00', 'Fee deposit',        5, 'checked_out'),
(3,  'Ravi Verma',      'sibling',  '9811002003', 1, '2023-08-10 14:00', '2023-08-10 16:00', 'Personal visit',     3, 'checked_out'),
(4,  'Dinesh Patel',    'parent',   '9811002004', 3, '2023-08-12 10:00', '2023-08-12 15:00', 'Admission formality',5, 'checked_out'),
(5,  'Anil Sharma',     'friend',   '9811001011', 1, '2023-08-15 16:00', '2023-08-15 18:00', 'Casual visit',       3, 'checked_out'),
(6,  'Priya Gupta',     'sibling',  '9811002006', 1, '2023-08-18 12:00', '2023-08-18 14:00', 'Birthday visit',     5, 'checked_out'),
(7,  'Vijay Kumar',     'parent',   '9811002007', 2, '2023-09-01 10:00', '2023-09-01 13:00', 'Monthly visit',      3, 'checked_out'),
(8,  'Sanjay Mishra',   'parent',   '9811002008', 2, '2023-09-03 11:00', '2023-09-03 15:00', 'Fee deposit',        5, 'checked_out'),
(9,  'Raju Tiwari',     'relative', '9811002009', 1, '2023-09-05 14:00', '2023-09-05 17:00', 'Personal visit',     3, 'checked_out'),
(10, 'Sunil Joshi',     'parent',   '9811002010', 2, '2023-09-08 10:00', '2023-09-08 13:00', 'Monthly visit',      5, 'checked_out'),
(11, 'Hemant Chauhan',  'parent',   '9811002011', 2, '2023-09-10 10:00', '2023-09-10 14:00', 'Monthly visit',      3, 'checked_out'),
(12, 'Manoj Agarwal',   'parent',   '9811002012', 1, '2023-09-12 11:00', '2023-09-12 13:00', 'Document collection',5, 'checked_out'),
(13, 'Rohit Dubey',     'sibling',  '9811002013', 1, '2023-09-15 15:00', '2023-09-15 17:00', 'Casual visit',       3, 'checked_out'),
(14, 'Rajan Nair',      'parent',   '9811002014', 3, '2023-09-18 10:00', '2023-09-18 15:00', 'Monthly visit',      5, 'checked_out'),
(15, 'Rakesh Pandey',   'parent',   '9811002015', 2, '2023-09-20 10:00', '2023-09-20 13:00', 'Fee deposit',        3, 'checked_out'),
(16, 'Ashok Saxena',    'parent',   '9811002016', 2, '2023-09-22 11:00', '2023-09-22 14:00', 'Monthly visit',      5, 'checked_out'),
(17, 'Arun Srivastava', 'parent',   '9811002017', 1, '2023-10-01 10:00', '2023-10-01 13:00', 'Monthly visit',      3, 'checked_out'),
(18, 'Nilesh Bhatt',    'parent',   '9811002018', 2, '2023-10-03 11:00', '2023-10-03 14:00', 'Monthly visit',      5, 'checked_out'),
(19, 'Vikas Malhotra',  'parent',   '9811002019', 1, '2023-10-05 10:00', '2023-10-05 12:00', 'Document collection',3, 'checked_out'),
(20, 'Gurpreet Kaur',   'parent',   '9811002020', 2, '2023-10-08 10:00', NULL,               'Monthly visit',      5, 'checked_in');

-- ---------------------------------------------
-- Gate Pass (25 records)
-- ---------------------------------------------
INSERT INTO gate_pass (student_id, pass_type, out_time, expected_return, actual_return, destination, reason, approved_by, status) VALUES
(1,  'day_out',  '2023-08-05 09:00', '2023-08-05 20:00', '2023-08-05 19:30', 'Nagpur City',    'Shopping',              1, 'completed'),
(2,  'weekend',  '2023-08-11 10:00', '2023-08-13 18:00', '2023-08-13 17:00', 'Home',           'Weekend visit',         1, 'completed'),
(3,  'day_out',  '2023-08-12 08:00', '2023-08-12 20:00', '2023-08-12 21:30', 'Nagpur City',    'Medical appointment',   1, 'completed'),
(4,  'night_out','2023-08-15 18:00', '2023-08-16 08:00', '2023-08-16 07:45', 'Relative Home',  'Family function',       1, 'completed'),
(5,  'day_out',  '2023-08-18 09:00', '2023-08-18 20:00', '2023-08-18 20:00', 'Nagpur City',    'Bank work',             1, 'completed'),
(6,  'weekend',  '2023-08-25 10:00', '2023-08-27 18:00', '2023-08-27 19:30', 'Home',           'Weekend visit',         1, 'completed'),
(7,  'day_out',  '2023-09-02 09:00', '2023-09-02 20:00', '2023-09-02 18:00', 'Nagpur City',    'Shopping',              1, 'completed'),
(8,  'emergency','2023-09-05 06:00', '2023-09-06 20:00', '2023-09-06 18:00', 'Home',           'Family emergency',      1, 'completed'),
(9,  'day_out',  '2023-09-08 10:00', '2023-09-08 20:00', '2023-09-08 20:30', 'Nagpur City',    'Medical checkup',       1, 'completed'),
(10, 'weekend',  '2023-09-15 10:00', '2023-09-17 18:00', '2023-09-17 18:00', 'Home',           'Weekend visit',         1, 'completed'),
(11, 'day_out',  '2023-09-20 09:00', '2023-09-20 20:00', '2023-09-20 19:00', 'Nagpur City',    'Shopping',              1, 'completed'),
(12, 'night_out','2023-09-22 18:00', '2023-09-23 08:00', '2023-09-23 09:30', 'Friend Home',    'Birthday party',        1, 'completed'),
(13, 'day_out',  '2023-09-25 08:00', '2023-09-25 20:00', '2023-09-25 20:00', 'Nagpur City',    'Exam center visit',     1, 'completed'),
(14, 'weekend',  '2023-09-29 10:00', '2023-10-01 18:00', '2023-10-01 17:30', 'Home',           'Weekend visit',         1, 'completed'),
(15, 'day_out',  '2023-10-02 09:00', '2023-10-02 20:00', '2023-10-02 20:00', 'Nagpur City',    'Bank work',             1, 'completed'),
(16, 'day_out',  '2023-10-05 09:00', '2023-10-05 20:00', NULL,               'Nagpur City',    'Shopping',              1, 'approved'),
(17, 'weekend',  '2023-10-06 10:00', '2023-10-08 18:00', NULL,               'Home',           'Weekend visit',         1, 'approved'),
(18, 'day_out',  '2023-10-07 09:00', '2023-10-07 20:00', NULL,               'Nagpur City',    'Medical appointment',   1, 'approved'),
(19, 'night_out','2023-10-08 18:00', '2023-10-09 08:00', NULL,               'Relative Home',  'Family function',       1, 'pending'),
(20, 'day_out',  '2023-10-09 09:00', '2023-10-09 20:00', NULL,               'Nagpur City',    'Shopping',              1, 'pending'),
(3,  'day_out',  '2023-10-10 08:00', '2023-10-10 20:00', NULL,               'Nagpur City',    'Library visit',         1, 'pending'),
(5,  'weekend',  '2023-10-13 10:00', '2023-10-15 18:00', NULL,               'Home',           'Weekend visit',         1, 'pending'),
(7,  'day_out',  '2023-10-14 09:00', '2023-10-14 20:00', NULL,               'Nagpur City',    'Shopping',              1, 'rejected'),
(9,  'night_out','2023-10-15 18:00', '2023-10-16 08:00', NULL,               'Friend Home',    'Birthday party',        1, 'rejected'),
(11, 'vacation', '2023-10-20 08:00', '2023-10-25 20:00', NULL,               'Home',           'Diwali vacation',       1, 'approved');