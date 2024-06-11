CREATE TABLE cran_users AS 
	SELECT DISTINCT author_user_login, author_name, author_email, author_user_location, author_user_company, author_user_pronouns, author_user_bio, author_user_website, author_user_twitter
    FROM cran.cran_gh_data_commits;