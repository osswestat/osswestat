CREATE TABLE codegov_gh_agency_count AS
SELECT agency, COUNT(DISTINCT slug) AS projects
FROM codegov_slugs
GROUP BY agency;