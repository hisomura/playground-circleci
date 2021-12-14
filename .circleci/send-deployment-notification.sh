#!/bin/bash

#######################################
# Send a notification to Commmune slack workspace.
# Arguments:
#   Text to send
# Returns:
#   0 if thing goes well, non-zero on error.
#######################################
function send_notification_to_slack() {
  echo $SLACK_WEBHOOK_URL
  echo $1
  ## https://swfz.hatenablog.com/entry/2019/07/07/035341
  curl -X POST ${SLACK_WEBHOOK_URL} \
    -H "Content-Type: application/json" \
    -d @- <<EOS
{
  "text": "$1",
  "icon_emoji": ":circle_ci_success:",
  "username": "CircleCI"
}
EOS
  return $?
}

declare -A MEMBERS_MAP=(
  ["hisomura"]="U01MG8FKHFE"
)

### Main part
if [ $CIRCLE_BRANCH == 'develop' ]; then
  mention_str=''
  if [ ${MEMBERS_MAP[$CIRCLE_USERNAME]} ]; then
    mention_str="<@${MEMBERS_MAP[$CIRCLE_USERNAME]}>"
  fi
  send_notification_to_slack "$mention_str test"
fi
