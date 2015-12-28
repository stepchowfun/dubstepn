#!/bin/bash

export APP_DESCRIPTION="Computer science, software engineering, math, and music."
export APP_TITLE="Stephan Boyer"
export APP_LANGUAGE="en"
export APP_AUTHOR="Stephan Boyer"
export APP_EMAIL="stephan@stephanboyer.com"
export APP_PROTOCOL="http://"
export APP_HOST="localhost"
export APP_DISQUS_SHORTNAME="stephanboyer"
export APP_GOOGLE_ANALYTICS_TRACKING_ID="UA-12345678-1"
export APP_PASSWORD_HASH="5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8"
export APP_SECRET="ownffuctewfinugxewfxklagdsngfjkfgawfdsgfilkaulbcnfskfdk"

# run the command
CMD="$1"
shift 1
"$CMD" "$@"
