PRAGMA foreign_keys=ON;
CREATE TABLE IF NOT EXISTS students (
    student_id      INTEGER  PRIMARY KEY AUTOINCREMENT,
    roll_number     TEXT     NOT NULL UNIQUE,
    full_name       TEXT     NOT NULL,
    gender          TEXT     NOT NULL CHECK (gender IN ('male', 'female', 'other')),
    department      TEXT     NOT NULL,
    year_of_study   TEXT     NOT NULL CHECK (year_of_study IN ('1st', '2nd', '3rd', '4th', '5th')),
    phone           TEXT     NOT NULL UNIQUE,
    email           TEXT     NOT NULL UNIQUE,
    guardian_name   TEXT     NOT NULL,
    guardian_phone  TEXT     NOT NULL,
    admission_date  DATE     NOT NULL DEFAULT (DATE('now')),
    status          TEXT     NOT NULL DEFAULT 'active'
                             CHECK (status IN ('active', 'inactive', 'graduated', 'expelled'))
);

CREATE INDEX IF NOT EXISTS idx_students_roll ON students (roll_number);
CREATE INDEX IF NOT EXISTS idx_students_dept ON students (department);
CREATE INDEX IF NOT EXISTS idx_students_status ON students(status);

CREATE TABLE IF NOT EXISTS rooms (
    room_id           INTEGER  PRIMARY KEY AUTOINCREMENT,
    room_number       TEXT     NOT NULL UNIQUE,
    block_name        TEXT     NOT NULL,
    floor_number      TEXT     NOT NULL,
    room_type         TEXT     NOT NULL CHECK (room_type IN ('single', 'double', 'triple')),
    capacity          INTEGER  NOT NULL CHECK (capacity > 0),
    current_occupancy INTEGER  NOT NULL DEFAULT 0 CHECK (current_occupancy >= 0),
    rent_per_month    REAL     NOT NULL CHECK (rent_per_month >= 0),
    status            TEXT     NOT NULL DEFAULT 'available'
                               CHECK (status IN ('available', 'occupied', 'under_maintenance','reserved')),
    CONSTRAINT chk_occupancy CHECK (current_occupancy <= capacity)
);

CREATE INDEX IF NOT EXISTS idx_rooms_block   ON rooms (block_name);
CREATE INDEX IF NOT EXISTS idx_rooms_type    ON rooms (room_type);
CREATE INDEX IF NOT EXISTS idx_rooms_status  ON rooms (status);

CREATE TABLE IF NOT EXISTS room_allotments (
    allotment_id    INTEGER  PRIMARY KEY AUTOINCREMENT,
    student_id      INTEGER  NOT NULL,
    room_id         INTEGER  NOT NULL,
    allotment_date  DATE     NOT NULL DEFAULT (DATE('now')),
    vacating_date   DATE     DEFAULT NULL,
    status          TEXT     NOT NULL DEFAULT 'active'
                             CHECK (status IN ('active', 'vacated', 'transferred')),
    remarks         TEXT     DEFAULT NULL,
    FOREIGN KEY (student_id) REFERENCES students (student_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (room_id)    REFERENCES rooms (room_id)       ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_allotments_student ON room_allotments (student_id);
CREATE INDEX IF NOT EXISTS idx_allotments_room    ON room_allotments (room_id);
CREATE INDEX IF NOT EXISTS idx_allotments_status  ON room_allotments (status);

CREATE TABLE IF NOT EXISTS fee_structure (
    fee_id          INTEGER  PRIMARY KEY AUTOINCREMENT,
    fee_category    TEXT     NOT NULL
                             CHECK (fee_category IN (
                                 'hostel_rent', 'mess_charges', 'security_deposit',
                                 'maintenance_charges', 'electricity_charges', 'other')),
    room_type       TEXT     NOT NULL CHECK (room_type IN ('single', 'double', 'triple', 'all')),
    amount          REAL     NOT NULL CHECK (amount >= 0),
    academic_year   TEXT     NOT NULL,
    semester        TEXT     NOT NULL CHECK (semester IN ('odd', 'even', 'annual')),
    description     TEXT     DEFAULT NULL,
    effective_from  DATE     NOT NULL,
    effective_to    DATE     NOT NULL,
    CONSTRAINT chk_fee_dates CHECK (effective_to > effective_from)
);

CREATE INDEX IF NOT EXISTS idx_fee_category  ON fee_structure (fee_category);
CREATE INDEX IF NOT EXISTS idx_fee_room_type ON fee_structure (room_type);
CREATE INDEX IF NOT EXISTS idx_fee_year      ON fee_structure (academic_year);

CREATE TABLE IF NOT EXISTS fee_payments (
    payment_id      INTEGER  PRIMARY KEY AUTOINCREMENT,
    student_id      INTEGER  NOT NULL,
    fee_id          INTEGER  NOT NULL,
    amount_paid     REAL     NOT NULL CHECK (amount_paid >= 0),
    amount_due      REAL     NOT NULL DEFAULT 0 CHECK (amount_due >= 0),
    payment_date    DATE     NOT NULL DEFAULT (DATE('now')),
    due_date        DATE     NOT NULL,
    payment_mode    TEXT     NOT NULL
                             CHECK (payment_mode IN ('cash', 'upi', 'neft', 'cheque', 'dd')),
    transaction_ref TEXT     DEFAULT NULL,
    status          TEXT     NOT NULL DEFAULT 'pending'
                             CHECK (status IN ('paid', 'partial', 'pending', 'overdue', 'waived')),
    remarks         TEXT     DEFAULT NULL,
    FOREIGN KEY (student_id) REFERENCES students (student_id)     ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (fee_id)     REFERENCES fee_structure (fee_id)    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_payments_student ON fee_payments (student_id);
CREATE INDEX IF NOT EXISTS idx_payments_status  ON fee_payments (status);
CREATE INDEX IF NOT EXISTS idx_payments_date    ON fee_payments (payment_date);
CREATE INDEX IF NOT EXISTS idx_payments_due     ON fee_payments (due_date);

CREATE TABLE IF NOT EXISTS staff (
    staff_id        INTEGER  PRIMARY KEY AUTOINCREMENT,
    employee_code   TEXT     NOT NULL UNIQUE,
    full_name       TEXT     NOT NULL,
    role            TEXT     NOT NULL
                             CHECK (role IN (
                                 'warden', 'caretaker', 'security',
                                 'mess_worker', 'cleaner', 'electrician', 'plumber')),
    department      TEXT     NOT NULL DEFAULT 'hostel',
    phone           TEXT     NOT NULL UNIQUE,
    email           TEXT     UNIQUE DEFAULT NULL,
    shift           TEXT     NOT NULL CHECK (shift IN ('morning', 'evening', 'night', 'general')),
    joining_date    DATE     NOT NULL DEFAULT (DATE('now')),
    salary          REAL     NOT NULL CHECK (salary > 0),
    status          TEXT     NOT NULL DEFAULT 'active'
                             CHECK (status IN ('active', 'inactive', 'on_leave', 'terminated'))
);

CREATE INDEX IF NOT EXISTS idx_staff_role   ON staff (role);
CREATE INDEX IF NOT EXISTS idx_staff_shift  ON staff (shift);
CREATE INDEX IF NOT EXISTS idx_staff_status ON staff (status);

CREATE TABLE IF NOT EXISTS staff_attendance (
    attendance_id       INTEGER  PRIMARY KEY AUTOINCREMENT,
    staff_id            INTEGER  NOT NULL,
    attendance_date     DATE     NOT NULL,
    check_in_time       TIME     DEFAULT NULL,
    check_out_time      TIME     DEFAULT NULL,
    attendance_status   TEXT     NOT NULL
                                 CHECK (attendance_status IN (
                                     'present', 'absent', 'half_day',
                                     'on_leave', 'holiday')),
    remarks             TEXT     DEFAULT NULL,
    FOREIGN KEY (staff_id) REFERENCES staff (staff_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT uq_staff_date UNIQUE (staff_id, attendance_date)
);

CREATE INDEX IF NOT EXISTS idx_attendance_staff  ON staff_attendance (staff_id);
CREATE INDEX IF NOT EXISTS idx_attendance_date   ON staff_attendance (attendance_date);
CREATE INDEX IF NOT EXISTS idx_attendance_status ON staff_attendance (attendance_status);

CREATE TABLE IF NOT EXISTS complaints (
    complaint_id        INTEGER  PRIMARY KEY AUTOINCREMENT,
    student_id          INTEGER  NOT NULL,
    room_id             INTEGER  NOT NULL,
    complaint_type      TEXT     NOT NULL
                                 CHECK (complaint_type IN (
                                     'noise', 'theft', 'harassment',
                                     'cleanliness', 'food', 'electrical',
                                     'plumbing', 'other')),
    description         TEXT     NOT NULL,
    priority            TEXT     NOT NULL DEFAULT 'medium'
                                 CHECK (priority IN ('low', 'medium', 'high', 'urgent')),
    status              TEXT     NOT NULL DEFAULT 'open'
                                 CHECK (status IN ('open', 'in_progress', 'resolved', 'closed', 'rejected')),
    assigned_to         INTEGER  DEFAULT NULL,
    raised_on           DATE     NOT NULL DEFAULT (DATE('now')),
    resolved_on         DATE     DEFAULT NULL,
    resolution_remarks  TEXT     DEFAULT NULL,
    FOREIGN KEY (student_id)  REFERENCES students (student_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (room_id)     REFERENCES rooms (room_id)       ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (assigned_to) REFERENCES staff (staff_id)      ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_complaints_student  ON complaints (student_id);
CREATE INDEX IF NOT EXISTS idx_complaints_status   ON complaints (status);
CREATE INDEX IF NOT EXISTS idx_complaints_priority ON complaints (priority);
CREATE INDEX IF NOT EXISTS idx_complaints_assigned ON complaints (assigned_to);

CREATE TABLE IF NOT EXISTS maintenance_requests (
    request_id      INTEGER  PRIMARY KEY AUTOINCREMENT,
    room_id         INTEGER  NOT NULL,
    raised_by       INTEGER  NOT NULL,
    request_type    TEXT     NOT NULL
                             CHECK (request_type IN (
                                 'electrical', 'plumbing', 'furniture',
                                 'civil', 'pest_control', 'painting', 'other')),
    description     TEXT     NOT NULL,
    priority        TEXT     NOT NULL DEFAULT 'medium'
                             CHECK (priority IN ('low', 'medium', 'high', 'urgent')),
    status          TEXT     NOT NULL DEFAULT 'pending'
                             CHECK (status IN ('pending', 'approved', 'in_progress', 'completed', 'cancelled')),
    assigned_to     INTEGER  DEFAULT NULL,
    estimated_cost  REAL     DEFAULT 0 CHECK (estimated_cost >= 0),
    actual_cost     REAL     DEFAULT 0 CHECK (actual_cost >= 0),
    requested_on    DATE     NOT NULL DEFAULT (DATE('now')),
    completed_on    DATE     DEFAULT NULL,
    remarks         TEXT     DEFAULT NULL,
    FOREIGN KEY (room_id)     REFERENCES rooms (room_id)  ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (raised_by)   REFERENCES staff (staff_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (assigned_to) REFERENCES staff (staff_id) ON DELETE SET NULL  ON UPDATE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_maintenance_room     ON maintenance_requests (room_id);
CREATE INDEX IF NOT EXISTS idx_maintenance_status   ON maintenance_requests (status);
CREATE INDEX IF NOT EXISTS idx_maintenance_type     ON maintenance_requests (request_type);
CREATE INDEX IF NOT EXISTS idx_maintenance_assigned ON maintenance_requests (assigned_to);

CREATE TABLE IF NOT EXISTS mess_menu (
    menu_id         INTEGER  PRIMARY KEY AUTOINCREMENT,
    day_of_week     TEXT     NOT NULL
                             CHECK (day_of_week IN (
                                 'monday', 'tuesday', 'wednesday', 'thursday',
                                 'friday', 'saturday', 'sunday')),
    meal_type       TEXT     NOT NULL
                             CHECK (meal_type IN ('breakfast', 'lunch', 'snacks', 'dinner')),
    items           TEXT     NOT NULL,
    academic_year   TEXT     NOT NULL,
    semester        TEXT     NOT NULL CHECK (semester IN ('odd', 'even')),
    effective_from  DATE     NOT NULL,
    effective_to    DATE     NOT NULL,
    created_by      INTEGER  DEFAULT NULL,
    FOREIGN KEY (created_by) REFERENCES staff (staff_id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT uq_menu_slot  UNIQUE (day_of_week, meal_type, academic_year, semester),
    CONSTRAINT chk_menu_dates CHECK (effective_to > effective_from)
);

CREATE INDEX IF NOT EXISTS idx_menu_day  ON mess_menu (day_of_week);
CREATE INDEX IF NOT EXISTS idx_menu_meal ON mess_menu (meal_type);
CREATE INDEX IF NOT EXISTS idx_menu_year ON mess_menu (academic_year);

CREATE TABLE IF NOT EXISTS visitor_log (
    visitor_id          INTEGER  PRIMARY KEY AUTOINCREMENT,
    student_id          INTEGER  NOT NULL,
    visitor_name        TEXT     NOT NULL,
    visitor_relation    TEXT     NOT NULL
                                 CHECK (visitor_relation IN (
                                     'parent', 'sibling', 'guardian',
                                     'friend', 'relative', 'other')),
    visitor_phone       TEXT     NOT NULL,
    num_visitors        INTEGER  NOT NULL DEFAULT 1 CHECK (num_visitors > 0),
    check_in_time       DATETIME NOT NULL DEFAULT (DATETIME('now')),
    check_out_time      DATETIME DEFAULT NULL,
    purpose             TEXT     DEFAULT NULL,
    verified_by         INTEGER  DEFAULT NULL,
    status              TEXT     NOT NULL DEFAULT 'checked_in'
                                 CHECK (status IN ('checked_in', 'checked_out', 'overstay')),
    FOREIGN KEY (student_id)  REFERENCES students (student_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (verified_by) REFERENCES staff (staff_id)      ON DELETE SET NULL  ON UPDATE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_visitor_student ON visitor_log (student_id);
CREATE INDEX IF NOT EXISTS idx_visitor_status  ON visitor_log (status);
CREATE INDEX IF NOT EXISTS idx_visitor_checkin ON visitor_log (check_in_time);

CREATE TABLE IF NOT EXISTS gate_pass (
    pass_id             INTEGER  PRIMARY KEY AUTOINCREMENT,
    student_id          INTEGER  NOT NULL,
    pass_type           TEXT     NOT NULL
                                 CHECK (pass_type IN (
                                     'day_out', 'night_out', 'weekend', 'emergency', 'vacation')),
    out_time            DATETIME NOT NULL,
    expected_return     DATETIME NOT NULL,
    actual_return       DATETIME DEFAULT NULL,
    destination         TEXT     NOT NULL,
    reason              TEXT     NOT NULL,
    approved_by         INTEGER  DEFAULT NULL,
    status              TEXT     NOT NULL DEFAULT 'pending'
                                 CHECK (status IN ('pending', 'approved', 'rejected', 'completed', 'cancelled')),
    FOREIGN KEY (student_id)  REFERENCES students (student_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (approved_by) REFERENCES staff (staff_id)      ON DELETE SET NULL  ON UPDATE CASCADE,
    CONSTRAINT chk_pass_times CHECK (expected_return > out_time)
);

CREATE INDEX IF NOT EXISTS idx_gatepass_student  ON gate_pass (student_id);
CREATE INDEX IF NOT EXISTS idx_gatepass_status   ON gate_pass (status);
CREATE INDEX IF NOT EXISTS idx_gatepass_type     ON gate_pass (pass_type);
CREATE INDEX IF NOT EXISTS idx_gatepass_out_time ON gate_pass (out_time);