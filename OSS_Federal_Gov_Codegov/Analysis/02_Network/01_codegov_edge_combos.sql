CREATE VIEW codegov_edge_combos AS
SELECT DISTINCT t1.slug, t1.login, t2.agency
FROM codegov_gh_commits_by_login t1
JOIN codegov_slugs t2 ON t1.slug = t2.slug;