-- third, we want all the commits, additions, deletions, sum and net by sector

CREATE VIEW cran_gh_commits_by_sector AS (
WITH sector_join AS (
SELECT slug, A.author_user_login, COALESCE(B.sector, 'null/missing') AS sector, A.additions, A.deletions,
                      EXTRACT(YEAR FROM author_date) AS year
FROM cran_gh_data_commits A
LEFT JOIN cran_users_sectors AS B
ON A.author_user_login = B.login
)

SELECT slug, sector, COUNT(*) AS commits, SUM(additions) AS additions, SUM(deletions) AS deletions,
					SUM(additions + deletions) AS sum_adds_dels, SUM(additions - deletions) AS net_adds_dels
FROM sector_join
GROUP BY slug, sector
ORDER BY slug DESC
);