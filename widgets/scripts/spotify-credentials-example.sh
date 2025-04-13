
CLIENT_ID=""
CLIENT_SECRET=""
REDIRECT_URI=""
SCOPES=""

open "https://accounts.spotify.com/authorize?client_id=${CLIENT_ID}&response_type=code&redirect_uri=${REDIRECT_URI}&scope=$(echo $SCOPES | sed 's/ /%20/g')"

CODE="Get from the redirect url"

curl -s -X POST -u "${CLIENT_ID}:${CLIENT_SECRET}" \
  -d grant_type=authorization_code \
  -d code="${CODE}" \
  -d redirect_uri="${REDIRECT_URI}" \
  https://accounts.spotify.com/api/token


REFRESH_TOKEN="Get from curl response"
