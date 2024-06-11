-- second, we want all the commits, additions, deletions, sum and net by year (2019)
-- this is not by login/year - just by year

CREATE VIEW codegov_gh_commits_by_year AS (
SELECT slug, EXTRACT(YEAR FROM author_date) AS year, COUNT(*) AS commits, SUM(additions) AS additions, SUM(deletions) AS deletions,
					SUM(additions + deletions) AS sum_adds_dels, SUM(additions - deletions) AS net_adds_dels
FROM codegov_gh_data_commits
GROUP BY slug, year);