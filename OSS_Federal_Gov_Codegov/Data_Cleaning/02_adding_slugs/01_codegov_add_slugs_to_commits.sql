-- Step 1: Add the new field to the existing table
ALTER TABLE codegov.codegov_gh_data_commits
ADD slug VARCHAR(255);

-- Step 2: Update the values of the new field by concatenating the existing fields
UPDATE codegov.codegov_gh_data_commits
SET slug = CONCAT(repo_owner, '/', repo_name);
