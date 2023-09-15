#!/bin/bash
COUNT=$(makoctl list | yq -r '.data[] | length')

if [[ $COUNT > 0 ]]; then
  echo " "
  echo "$COUNT notifications"
else
  echo " "
  echo "No notifications"
fi
