DROP PROCEDURE IF EXISTS attendance_by_stid_cid;
DELIMITER //
CREATE PROCEDURE attendance_by_stid_cid(IN st_id VARCHAR(20), IN c_id VARCHAR(20))
BEGIN
SELECT Session_Date,Week_Number,Session_Type,Status FROM attendance WHERE ST_Id = st_id AND 
Course_code = c_id;   
END //
DELIMITER ;