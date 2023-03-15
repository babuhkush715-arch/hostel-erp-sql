# =============================================
# Hostel ERP — Data Analysis & Visualization
# =============================================

import sqlite3
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import os

# --- Setup ---
sns.set_theme(style="whitegrid")
#DB_PATH = os.path.join(os.path.dirname(__file__), '..', 'data', 'hostel_erp.db')
#DB_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'data', 'hostel_erp.db')
DB_PATH = r"C:\Users\HP\Documents\Python_program\hostel-erp-sql\data\hostel_erp.db"
print("DB PATH:", DB_PATH)
print("File exists:", os.path.exists(DB_PATH))

#conn = sqlite3.connect(DB_PATH)
#conn = sqlite3.connect(DB_PATH, isolation_level=None)
#conn.execute("PRAGMA journal_mode=WAL")
conn = sqlite3.connect(DB_PATH)
conn.execute("PRAGMA query_only = ON")
test = pd.read_sql_query("SELECT COUNT(*) as cnt FROM staff_attendance", conn)
print("Staff attendance count:", test['cnt'][0])
#conn = sqlite3.connect(DB_PATH)
os.makedirs('analysis/charts', exist_ok=True)

# -----------------------------------------------
# Chart 1: Department-wise Student Count
# -----------------------------------------------
df1 = pd.read_sql_query("""
    SELECT department,
           SUM(CASE WHEN gender='male'   THEN 1 ELSE 0 END) AS Male,
           SUM(CASE WHEN gender='female' THEN 1 ELSE 0 END) AS Female
    FROM students WHERE status='active'
    GROUP BY department ORDER BY department
""", conn)

df1.set_index('department')[['Male','Female']].plot(
    kind='bar', figsize=(8,5), color=['steelblue','salmon'], edgecolor='white')
plt.title('Department-wise Student Count by Gender')
plt.xlabel('Department')
plt.ylabel('Number of Students')
plt.xticks(rotation=30, ha='right')
plt.tight_layout()
plt.savefig('analysis/charts/01_dept_student_count.png', dpi=150)
plt.close()
print("Chart 1 saved")

# -----------------------------------------------
# Chart 2: Block-wise Room Occupancy %
# -----------------------------------------------
df2 = pd.read_sql_query("""
    SELECT block_name,
           ROUND(SUM(current_occupancy)*100.0/SUM(capacity),1) AS occupancy_pct
    FROM rooms GROUP BY block_name
""", conn)

colors = ['#2ecc71','#3498db','#e74c3c']
plt.figure(figsize=(6,5))
bars = plt.bar(df2['block_name'], df2['occupancy_pct'], color=colors, edgecolor='white')
for bar, val in zip(bars, df2['occupancy_pct']):
    plt.text(bar.get_x()+bar.get_width()/2, bar.get_height()+1,
             f'{val}%', ha='center', fontsize=11, fontweight='bold')
plt.title('Block-wise Room Occupancy (%)')
plt.xlabel('Block')
plt.ylabel('Occupancy %')
plt.ylim(0, 100)
plt.tight_layout()
plt.savefig('analysis/charts/02_block_occupancy.png', dpi=150)
plt.close()
print("Chart 2 saved")

# -----------------------------------------------
# Chart 3: Fee Payment Status Pie Chart
# -----------------------------------------------
df3 = pd.read_sql_query("""
    SELECT status, COUNT(*) AS count
    FROM fee_payments GROUP BY status
""", conn)

colors_pie = ['#2ecc71','#f39c12','#e74c3c','#3498db','#9b59b6']
plt.figure(figsize=(6,6))
plt.pie(df3['count'], labels=df3['status'], autopct='%1.1f%%',
        colors=colors_pie, startangle=140, wedgeprops={'edgecolor':'white'})
plt.title('Fee Payment Status Distribution')
plt.tight_layout()
plt.savefig('analysis/charts/03_fee_payment_status.png', dpi=150)
plt.close()
print("Chart 3 saved")

# -----------------------------------------------
# Chart 4: Complaint Type Distribution
# -----------------------------------------------
df4 = pd.read_sql_query("""
    SELECT complaint_type, COUNT(*) AS count
    FROM complaints GROUP BY complaint_type
    ORDER BY count DESC
""", conn)

plt.figure(figsize=(8,5))
sns.barplot(data=df4, x='complaint_type', y='count', palette='coolwarm')
plt.title('Complaints by Type')
plt.xlabel('Complaint Type')
plt.ylabel('Count')
plt.xticks(rotation=30, ha='right')
plt.tight_layout()
plt.savefig('analysis/charts/04_complaint_types.png', dpi=150)
plt.close()
print("Chart 4 saved")

# -----------------------------------------------
# Chart 5: Staff Attendance Summary Bar Chart
# -----------------------------------------------
conn5 = sqlite3.connect(DB_PATH, isolation_level=None)
conn5.execute("PRAGMA journal_mode=WAL")
df5 = pd.read_sql_query("""
    SELECT s.full_name,
           CAST(SUM(CASE WHEN sa.attendance_status='present'  THEN 1 ELSE 0 END) AS INTEGER) AS Present,
           CAST(SUM(CASE WHEN sa.attendance_status='absent'   THEN 1 ELSE 0 END) AS INTEGER) AS Absent,
           CAST(SUM(CASE WHEN sa.attendance_status='half_day' THEN 1 ELSE 0 END) AS INTEGER) AS Half_Day
    FROM staff s
    LEFT JOIN staff_attendance sa ON s.staff_id = sa.staff_id
    GROUP BY s.staff_id, s.full_name
    ORDER BY Present DESC
""", conn5)
conn5.close()
print("df5 shape:", df5.shape)
print(df5.head())

df5[['Present','Absent','Half_Day']] = df5[['Present','Absent','Half_Day']].astype(int)

fig, ax = plt.subplots(figsize=(10,5))
x = range(len(df5))
width = 0.25
ax.bar([i-width for i in x], df5['Present'],  width, label='Present',  color='#2ecc71', edgecolor='white')
ax.bar([i        for i in x], df5['Absent'],   width, label='Absent',   color='#e74c3c', edgecolor='white')
ax.bar([i+width  for i in x], df5['Half_Day'], width, label='Half Day', color='#f39c12', edgecolor='white')
ax.set_xticks(list(x))
ax.set_xticklabels(df5['full_name'], rotation=35, ha='right')
ax.set_title('Staff Attendance Summary')
ax.set_ylabel('Days')
ax.legend()
plt.tight_layout()
plt.savefig('analysis/charts/05_staff_attendance_heatmap.png', dpi=150)
plt.close()
print("Chart 5 saved")
print(df5)
print(df5.dtypes)

# -----------------------------------------------
# Chart 6: Maintenance Cost — Estimated vs Actual
# -----------------------------------------------
df6 = pd.read_sql_query("""
    SELECT request_type,
           SUM(estimated_cost) AS Estimated,
           SUM(actual_cost)    AS Actual
    FROM maintenance_requests
    WHERE status='completed'
    GROUP BY request_type
""", conn)

x = range(len(df6))
width = 0.35
fig, ax = plt.subplots(figsize=(8,5))
ax.bar([i-width/2 for i in x], df6['Estimated'], width,
       label='Estimated', color='steelblue', edgecolor='white')
ax.bar([i+width/2 for i in x], df6['Actual'], width,
       label='Actual', color='salmon', edgecolor='white')
ax.set_xticks(list(x))
ax.set_xticklabels(df6['request_type'], rotation=20, ha='right')
ax.set_title('Maintenance Cost: Estimated vs Actual')
ax.set_ylabel('Cost (₹)')
ax.legend()
plt.tight_layout()
plt.savefig('analysis/charts/06_maintenance_cost.png', dpi=150)
plt.close()
print("Chart 6 saved")

conn.close()
print("\nAll 6 charts saved in analysis/charts/")