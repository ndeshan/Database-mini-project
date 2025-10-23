DELIMITER //
 CREATE PROCEDURE attendance_by_stid_cid_date(IN st_id VARCHAR(20), IN c_id VARCHAR(20), IN until_date DATE)
     BEGIN
     SELECT Session_Date,Week_Number,Session_Type,Status FROM attendance WHERE ST_Id = st_id AND
     Course_code = c_id AND Session_Date <= until_date;
     END //
DELIMITER ;