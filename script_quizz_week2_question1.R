library(httr)
library(httpuv)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
  key = "dd231f6d6535b1f4953a",
  secret = "1d83d8a2172ef724178225c0a73761d55232d1ef")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp, cache = FALSE)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
repo_list <- content(req)

answer1 <- c() 
for (i in 1:length(repo_list)) {
  repo <- repo_list[[i]]
  if (repo$name == "datasharing") {
    answer1 = repo
    break
  }
}

answer1
