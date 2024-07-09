#!/bin/bash

IFS="$FIELDSEPERATOR"
for service in ${ENABLEDSERVICES}; do
  systemctl enable ${service}
done
unset IFS
