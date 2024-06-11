CREATE TABLE cran_users_sectors AS (
SELECT login, name, email, location, company, pronouns, bio, website, twitter, organization,
  CASE 
    WHEN academic = 1 THEN 'Academic'
    WHEN business = 1 THEN 'Business'
    WHEN government = 1 THEN 'Government'
    WHEN nonprofit = 1 THEN 'Nonprofit'
    ELSE 'Unknown'
  END AS sector
FROM cran_users_sectored);