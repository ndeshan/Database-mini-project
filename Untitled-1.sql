DROP PROCEDURE IF EXISTS attendance_by_stid;
DELIMITER //
CREATE PROCEDURE attendance_by_stid(IN p_stid VARCHAR(20))
BEGIN
  SELECT
    Course_code,
    Session_Type,
    SUM(CASE WHEN Status = 'Present' THEN 1 ELSE 0 END) AS Present,
    SUM(CASE WHEN Status = 'Absent'  THEN 1 ELSE 0 END) AS Absent,
    COUNT(*) AS Total
  FROM attendance
  WHERE ST_Id = p_stid
  GROUP BY Course_code, Session_Type;
END //
DELIMITER ;