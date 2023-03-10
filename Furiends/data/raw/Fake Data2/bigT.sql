SELECT u.User_id, log_count, com_count,avg_loading,sum_duration
FROM User_Table u
LEFT JOIN
(SELECT User_id, COUNT(*) AS log_count
FROM User_Table 
LEFT JOIN Log_Table 
ON log_user_id = User_id
GROUP BY User_id
ORDER BY User_id ASC) logc
ON u.User_id = logc.User_id
LEFT JOIN
(SELECT User_id, COUNT(*) AS com_count
FROM User_Table 
LEFT JOIN Community_Table 
ON comm_User_id = User_id
GROUP BY User_id) c
ON c.User_id = u.User_id
LEFT JOIN
(SELECT ROUND(AVG(VR_loading_time), 2) AS avg_loading, log_user_id
FROM Log_Table
LEFT JOIN Activity
ON log_id_act = Log_id
GROUP BY log_user_id) avgload
ON avgload.log_user_id = u.User_id
LEFT JOIN
(SELECT ROUND(SUM(duration_activity),2) AS sum_duration, log_user_id
FROM Log_Table
LEFT JOIN Activity
ON log_id_act = Log_id
GROUP BY log_user_id)sum_dur
ON sum_dur.log_user_id = u.User_id
