1. Employee Productivity Analysis**
SELECT employeeid, employeename, 
       SUM(total_hours) AS total_hours_worked, 
       SUM(days_present) AS total_days_present, 
       SUM(days_absent) AS total_days_absent
FROM attendance_Record
GROUP BY employeeid, employeename
ORDER BY total_hours_worked DESC, total_days_absent ASC;

2. Departmental Training Impact
SELECT e.department_id, t.program_name, 
       AVG(t.feedback_score) AS avg_feedback_score, 
       COUNT(t.employeeid) AS num_employees_trained
FROM training_programs t
JOIN Employee_Details e ON t.employeeid = e.employeeid
GROUP BY e.department_id, t.program_name
ORDER BY e.department_id, avg_feedback_score DESC;

3. Project Budget Efficiency
SELECT p.project_id, p.project_name, p.budget, 
       SUM(p.hours_worked) AS total_hours_worked, 
       (p.budget / SUM(p.hours_worked)) AS cost_per_hour
FROM project_assignments p
GROUP BY p.project_id, p.project_name, p.budget
ORDER BY cost_per_hour ASC;

4. Attendance Consistency
SELECT e.department_id, 
       AVG(a.total_hours) AS avg_hours_worked, 
       AVG(a.days_present) AS avg_days_present, 
       AVG(a.days_absent) AS avg_days_absent
FROM attendance_record a
JOIN Employee_Details e ON a.employeeid = e.employeeid
GROUP BY e.department_id
ORDER BY avg_hours_worked DESC

5. Training and Project Success Correlation
SELECT e.department_id, t.program_name, 
       AVG(t.feedback_score) AS avg_feedback_score, 
       COUNT(t.employeeid) AS num_employees_trained
FROM Training_Programs t
JOIN Employee_Details e ON t.employeeid = e.employeeid
GROUP BY e.department_id, t.program_name
ORDER BY e.department_id, avg_feedback_score DESC;

6. High-Impact Employees
SELECT e.employeeid, e.employeename, e.performance_score, 
       p.project_name, p.budget
FROM Employee_Details e
JOIN project_assignments p ON e.employeeid = p.employeeid
WHERE e.performance_score = 'Excellent' 
  AND p.budget > (SELECT AVG(budget) FROM project_assignments)
  ORDER BY p.budget DESC, e.performance_score DESC;
  
  Cross Analysis 
 Select tp.employeeid,
    tp.employeename,
    tp.technologies_covered,
    pa.project_name,
    pa.technologies_used,
    pa.milestones_achieved
FROM Training_Programs tp
JOIN Project_Assignments pa 
    ON tp.employeeid = pa.employeeid
WHERE LOWER(pa.technologies_used) LIKE CONCAT('%', LOWER(tp.technologies_covered), '%')
ORDER BY pa.milestones_achieved DESC;