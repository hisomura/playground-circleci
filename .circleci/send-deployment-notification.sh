#!/bin/bash

#######################################
# Send a notification to Commmune slack workspace.
# Globals:
#   SLACK_WEBHOOK_URL
# Arguments:
#   Text to send
# Returns:
#   0 if a message is sent, non-zero on error.
#######################################
function send_notification_to_slack() {
  echo "text: $1"
  ## https://swfz.hatenablog.com/entry/2019/07/07/035341
  curl -X POST "$SLACK_WEBHOOK_URL" \
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

### Main part
### Main part
if [ $CIRCLE_BRANCH == 'main' ]; then
  member_id=$(echo "$MEMBERS_MAP_JSON" | jq -r ."$CIRCLE_USERNAME")
  if [ "$member_id" != 'null' ]; then
    mention="<@${member_id}>"
  fi

  send_notification_to_slack "$mention develop環境にデプロイしました。 ビルド詳細: ${CIRCLE_BUILD_URL} プルリクエストURL: ${CIRCLE_PULL_REQUEST}"
fi
