DELIMITER //
DROP PROCEDURE IF EXISTS update_attendance//
CREATE PROCEDURE update_attendance(
    IN in_ST_Id VARCHAR(50),
    IN in_Course_code VARCHAR(50),
    IN in_Week_Number INT,
    IN in_session_type VARCHAR(20), 
    IN in_status_flag VARCHAR(5)   
)
BEGIN

    DECLARE s_type VARCHAR(20);
    DECLARE new_status VARCHAR(20);
   


    
    IF in_session_type IN ('t','theory','T','Theory') THEN
        SET s_type = 'Theory';
    ELSEIF in_session_type IN ('p','practical','P','Practical') THEN
        SET s_type = 'Practical';
    ELSE
        SELECT "invalid please enter ('t','theory','T','Theory') or ('p','practical','P','Practical')" AS message;
    END IF;


    
    IF in_status_flag IN ('p','present','P','Present') THEN
        SET new_status = 'Present';
    ELSEIF in_status_flag IN ('a','absent','A','Absent') THEN
        SET new_status = 'Absent';
    ELSE
        SELECT "invalid please enter ('p','present','P','Present') or ('a','absent','A','Absent')" AS message;
    END IF;


    UPDATE attendance
    SET Status = new_status
    WHERE ST_Id = in_ST_Id
      AND Course_code = in_Course_code
      AND Week_Number = in_Week_Number
      AND Session_Type = s_type;


    
    SELECT * FROM attendance
    WHERE ST_Id = in_ST_Id
      AND Course_code = in_Course_code
      AND Week_Number = in_Week_Number
      AND Session_Type = s_type;
END//
DELIMITER ;


