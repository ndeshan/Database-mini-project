VIEW 1 සමරියක් විදියට subjet ඔක්කොගෙම පැය ගානෙන් 
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

view 2 සමරියක් විදියට subjet ඔක්කොගෙම දිනවලින් 

CREATE VIEW attendance_summary AS
     SELECT
         a.ST_Id,
         a.Course_code,
         COUNT(*) as Total_Sessions,
         SUM(CASE WHEN Status = 'Present' THEN 1 ELSE 0 END) as Present,
         SUM(CASE WHEN Status = 'Absent' THEN 1 ELSE 0 END) as Absent,
         SUM(CASE WHEN Status = 'Medical' THEN 1 ELSE 0 END) as Medical,
         ROUND((SUM(CASE WHEN Status IN ('Present','Medical') THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as Percentage,
         CASE
             WHEN ROUND((SUM(CASE WHEN Status IN ('Present','Medical') THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) >= 80
             THEN 'Eligible'
             ELSE 'Not Eligible'
         END as Eligibility
     FROM attendance a
     GROUP BY a.ST_Id, a.Course_code;
