-- second, we want all the commits, additions, deletions, sum and net by login within repo for each year

CREATE VIEW cran_gh_commits_by_login AS (
SELECT slug, author_user_login AS login, EXTRACT(YEAR FROM author_date) AS year, COUNT(*) AS commits, SUM(additions) AS additions, SUM(deletions) AS deletions,
					SUM(additions + deletions) AS sum_adds_dels, SUM(additions - deletions) AS net_adds_dels
FROM cran_gh_data_commits
GROUP BY slug, login, year );