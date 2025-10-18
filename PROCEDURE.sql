PROCEDURES
1.
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

2.
DELIMITER //
CREATE PROCEDURE attendance_by_stid_cid_seperate_type(
      IN st_id VARCHAR(20),
      IN c_id VARCHAR(20),
      IN s_type VARCHAR(2)
     )
     BEGIN
    
      DECLARE se_type VARCHAR(20);
    
      IF s_type IN ('t','T') THEN
              SET se_type = 'Theory';
      ELSEIF s_type IN ('p','P') THEN
              SET se_type = 'Practical';
      ELSE
              SELECT 'Invalid input please enter (\'t\',\'T\') or (\'p\',\'P\')' AS MESSAGE;
    
      END IF;
    
      SELECT Session_Date, Week_Number, Session_Type, Status
      FROM attendance
      WHERE ST_Id = st_id
        AND Course_code = c_id
        AND Session_Type = se_type;
     END //
DELIMITER ;

3.
DELIMITER //
 CREATE PROCEDURE attendance_by_stid_cid(IN st_id VARCHAR(20), IN c_id VARCHAR(20))
     BEGIN
     SELECT Session_Date,Week_Number,Session_Type,Status FROM attendance WHERE ST_Id = st_id AND
     Course_code = c_id;
     END //
DELIMITER ;

4.
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
