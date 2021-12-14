#!/bin/bash

#######################################
# Send a notification to Commmune slack workspace.
# Arguments:
#   Text to send
# Returns:
#   0 if thing goes well, non-zero on error.
#######################################
function send_notification_to_slack() {
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
member_id=$(echo $MEMBERS_MAP_JSON | jq -r ."$CIRCLE_USERNAME")
echo $member_id

mention=''
if [ $member_id ]; then
  mention="<@${member_id}>"
fi
send_notification_to_slack "$mention test"
