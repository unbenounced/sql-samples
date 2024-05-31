/*
Capital One's marketing team is working on a project to analyze customer feedback from their feedback surveys.


The team sorted the words from the feedback into three different categories;


•	short_comments
•	mid_length_comments
•	long_comments


The team wants to find comments that are not short and that come from social media. The output should include 'feedback_id,' 'feedback_text,' 'source_channel,' and a calculated category.
*/

--eric 
SELECT DISTINCT *
  FROM customer_feedback
 WHERE comment_category != 'short_comments'
   AND source_channel = 'social_media';

   --strata
   WITH filtered_comments AS (
    SELECT DISTINCT ON (feedback_id) feedback_id, feedback_text, source_channel, comment_category
    FROM customer_feedback
    WHERE comment_category != 'short_comments'
    AND source_channel = 'social_media'
    ORDER BY feedback_id, feedback_text, source_channel, comment_category
)
SELECT feedback_id, feedback_text, source_channel, comment_category
FROM filtered_comments
ORDER BY feedback_id;