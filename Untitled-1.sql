DROP PROCEDURE IF EXISTS attendance_by_stid;
DELIMITER //
CREATE PROCEDURE attendance_by_stid(IN p_stid VARCHAR(20))
BEGIN
  SELECT
    a.Course_code,
    a.Session_Type,
    SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) AS Present,
    SUM(CASE WHEN a.Status = 'Absent'  THEN 1 ELSE 0 END) AS Absent,
    COUNT(*) AS Total,
  MAX(s.Percentage) AS Percentage,
  MAX(s.Eligibility) AS Eligibility
  FROM attendance AS a
  JOIN attendance_percentage_by_hours AS s ON a.ST_Id = s.ST_Id
    AND a.Course_code = s.Course_code
  WHERE a.ST_Id = p_stid
  GROUP BY a.Course_code, a.Session_Type;
END //
DELIMITER ;