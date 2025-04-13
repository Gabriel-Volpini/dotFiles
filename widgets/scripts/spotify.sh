#!/bin/bash

# Verifica se o jq está instalado
if ! command -v jq &> /dev/null; then
  echo "❌ 'jq' not found. Run: brew install jq"
  exit 1
fi

#
# spotify-now.sh  – devolve JSON com a faixa atual do Spotify
#

source "$(dirname "$0")/spotify-credentials.sh"

TOKEN_FILE="/tmp/spotify_token"
API="https://api.spotify.com/v1/me/player/currently-playing"


 get_token () {
  # Se existe token e tem menos de 55 min, usa-o
  if [[ -f "$TOKEN_FILE" ]] && [[ $(find "$TOKEN_FILE" -mmin -55) ]]; then
    cat "$TOKEN_FILE"
  else
   curl -s -X POST -u "${CLIENT_ID}:${CLIENT_SECRET}" \
      -d grant_type=refresh_token \
      -d refresh_token="${REFRESH_TOKEN}" \
      https://accounts.spotify.com/api/token | jq -r '.access_token' | tee "$TOKEN_FILE"
  fi
 }

ACCESS_TOKEN=$(get_token)

# Pega faixa atual
curl -s -H "Authorization: Bearer ${ACCESS_TOKEN}" "$API" | jq -c '
  if . == null or .item == null then
    { playing:false }
  else
    {
      playing:true,
      is_playing:.is_playing,
      progress_ms:.progress_ms,
      duration_ms:.item.duration_ms,
      track:.item.name,
      artist:(.item.artists|map(.name)|join(", ")),
      album:.item.album.name,
      image:(.item.album.images[1].url)
    }
  end
'
