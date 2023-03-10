SELECT fre.log_user_id, fre.act_category,fre.freq_act_id, dur.dur_sum
FROM Frequency fre
LEFT JOIN (
 SELECT log_user_id, act_category, ROUND( SUM(duration_activity),2)AS dur_sum
 FROM Log_Table
 INNER JOIN Activity
 ON log_id_act = Log_id
 GROUP BY log_user_id, act_category
)dur
ON dur.log_user_id = fre.log_user_id 
WHERE fre.act_category = dur.act_category;