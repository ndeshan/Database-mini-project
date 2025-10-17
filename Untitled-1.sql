 DELIMITER //
 DROP PROCEDURE IF EXISTS update_attendance//


CREATE PROCEDURE update_attendance(
  IN ST_Id_in VARCHAR(20),
  IN Course_code_in VARCHAR(15),
  IN Week_Number_in INT,
  IN session_type VARCHAR(10),
  IN in_status VARCHAR(10)
 )
     BEGIN
  DECLARE new_status VARCHAR(10);
  DECLARE s_type VARCHAR(10);

  IF session_type IN ('t','T','Theory','theory') THEN
  SET s_type = 'Theory';
  ELSEIF session_type IN ('p','P','practical','Practical') THEN
  SET s_type = 'Practical';
  ELSE
  SELECT "invalid session type entry use ('t','T','Theory','theory') or ('p','P','practical','Practical')." AS message;
  END IF;




  IF in_status IN ('p','P','Present') THEN
          SET new_status = 'Present';
  ELSEIF in_status IN ('a','A','Absent') THEN
          SET new_status = 'Absent';
  ELSE


          SELECT 'Invalid status value. Use p/a/m or Present/Absent/Medical.' AS message;

  END IF;


  UPDATE attendance
  SET Status = new_status
  WHERE ST_Id = ST_Id_in
          AND Course_code = Course_code_in
          AND Week_Number = Week_Number_in
          AND Session_Type = s_type;




  SELECT * FROM attendance WHERE ST_Id = ST_Id_in AND Course_code = Course_code_in
          AND Week_Number = Week_Number_in;
 END //


DELIMITER ;