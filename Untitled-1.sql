DROP PROCEDURE IF EXISTS attendance_by_stid_cid_seperate_type;
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