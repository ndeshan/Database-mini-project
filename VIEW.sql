VIEW
 CREATE VIEW attendance_percentage_by_hours AS
     SELECT
       agg.ST_Id,
       agg.Course_code,
       agg.total_sessions AS Total_Sessions,
       agg.present_count AS Present,
       agg.absent_count  AS Absent,
       
       CASE WHEN agg.total_sessions = 0 THEN 0
            ELSE ROUND(100.0 * (agg.present_count / agg.total_sessions), 2)
       END AS Percentage,
       CASE WHEN agg.total_sessions = 0 THEN 'Not Applicable'
            WHEN ROUND(100.0 * (agg.present_count / agg.total_sessions), 2) >= 80 THEN 'Eligible'
            ELSE 'Not Eligible' END AS Eligibility
     FROM (
       SELECT
         ST_Id,
         Course_code,
         COUNT(*) AS total_sessions,
         SUM(Status = 'Present') AS present_count,
         SUM(Status = 'Absent')  AS absent_count
       FROM attendance
       GROUP BY ST_Id, Course_code
     ) AS agg;
