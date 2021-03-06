SELECT
  '{{ task.day }}' AS day,
  RANK() OVER (PARTITION BY day ORDER BY cnt DESC) AS rank,
  github_id,
  cnt
FROM (
  SELECT
    actor.login AS github_id,
    COUNT(*) AS cnt
  FROM
    githubarchive:day.events_{{ task.day.strftime("%Y%m%d") }}
  GROUP BY
    github_id
  ORDER BY
    cnt DESC
  LIMIT
    10
)
