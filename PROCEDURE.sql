PROCEDURES
--showing individual student eligibility by given registration number
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

-- insert attendace details
DELIMITER //
DROP PROCEDURE IF EXISTS add_attendance_for_student;
CREATE PROCEDURE add_attendance_for_student(
    IN p_stid VARCHAR(50),
    IN p_course VARCHAR(50),
    IN p_start_date DATE,
    IN p_session_type VARCHAR(20),
    IN p_status VARCHAR(10)
)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE seq_base INT DEFAULT 0;
    SELECT COALESCE(MAX(CAST(SUBSTRING(Attendance_Id,4) AS UNSIGNED)), 0) INTO seq_base FROM attendance WHERE Attendance_Id LIKE 'ATT%';

    IF p_course IS NOT NULL AND p_course <> '' THEN
        WHILE i <= 15 DO
            SET seq_base = seq_base + 1;
            SET @att_id = CONCAT('ATT', LPAD(seq_base, 4, '0'));
            INSERT INTO attendance(
                Attendance_Id, ST_Id, Course_code, Session_Date, Week_Number, Session_Type, Status
            ) VALUES (
                @att_id, p_stid, p_course, DATE_ADD(p_start_date, INTERVAL (i-1) WEEK), i, p_session_type, p_status
            );
            SET i = i + 1;
        END WHILE;
    END IF;
END //
DELIMITER ;

--by givin registation number and course code show all attendance records if there both theory and practicle in subject by giving special arg can show seperatly
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

--by givin registation number and course code show all attendance records if there both theory and practicle in subject show combined 
DELIMITER //
 CREATE PROCEDURE attendance_by_stid_cid(IN st_id VARCHAR(20), IN c_id VARCHAR(20))
     BEGIN
     SELECT Session_Date,Week_Number,Session_Type,Status FROM attendance WHERE ST_Id = st_id AND
     Course_code = c_id;
     END //
DELIMITER ;

--attendance update proce-
 
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

--show attendance with eligibility by given course code 
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

--show attendance untill specific day by givin registation number and course code
DELIMITER //
 CREATE PROCEDURE attendance_by_stid_cid_date(IN st_id VARCHAR(20), IN c_id VARCHAR(20), IN until_date DATE)
     BEGIN
     SELECT Session_Date,Week_Number,Session_Type,Status FROM attendance WHERE ST_Id = st_id AND
     Course_code = c_id AND Session_Date <= until_date;
     END //
DELIMITER ;

--show attendance untill specific day by givin registation number , course code and session type
drop procedure if exists attendance_by_stid_cid_seperate_type_date;
DELIMITER //
CREATE PROCEDURE attendance_by_stid_cid_seperate_type_date(
      IN st_id VARCHAR(20),
      IN c_id VARCHAR(20),
      IN s_type VARCHAR(2),
      IN until_date DATE
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
        AND Session_Type = se_type
        AND Session_Date <= until_date;
     END //
DELIMITER ;
