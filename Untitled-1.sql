DELIMITER //
CREATE PROCEDURE attendance_summary_by_course_id(IN c_id VARCHAR(15))
BEGIN
    SELECT
        a.ST_Id,
        a.Course_code,
        COUNT(*) as Total_Sessions,
        SUM(CASE WHEN Status = 'Present' THEN 1 ELSE 0 END) as Present,
        SUM(CASE WHEN Status = 'Absent' THEN 1 ELSE 0 END) as Absent,
        ROUND((SUM(CASE WHEN Status IN ('Present') THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as Percentage,
        CASE
            WHEN ROUND((SUM(CASE WHEN Status IN ('Present') THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) >= 80
            THEN 'Eligible'
            ELSE 'Not Eligible'
        END as Eligibility
    FROM attendance a
    WHERE a.Course_code = c_id
    GROUP BY a.ST_Id, a.Course_code;
END //
DELIMITER ;