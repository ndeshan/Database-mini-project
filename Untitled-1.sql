DROP PROCEDURE IF EXISTS attendance_by_stid; 
DELIMITER //

CREATE PROCEDURE attendance_by_stid(IN id VARCHAR(20))
BEGIN
SELECT Course_code, Session_Type,(SELECT COUNT(Status) FROM attendance WHERE Status = "Present" AND ST_Id = id) AS Present,(SELECT COUNT(Status) FROM attendance WHERE Status = "Absent" AND ST_Id = id) AS Absent FROM attendance WHERE ST_Id = id GROUP BY Course_code,Session_Type;
END //
DELIMITER ;