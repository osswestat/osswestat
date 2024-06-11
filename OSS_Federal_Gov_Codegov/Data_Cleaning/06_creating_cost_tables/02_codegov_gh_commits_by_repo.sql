-- We want all the commits, additions, deletions, sum and net by repo

CREATE VIEW codegov_gh_commits_by_repo AS (
SELECT slug, COUNT(*) AS commits, SUM(additions) AS additions, SUM(deletions) AS deletions,
					SUM(additions + deletions) AS sum_adds_dels, SUM(additions - deletions) AS net_adds_dels
FROM codegov_gh_data_commits
GROUP BY slug
);