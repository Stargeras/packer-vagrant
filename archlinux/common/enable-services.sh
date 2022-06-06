#!/bin/bash

enabledservices=$(echo ${ENABLEDSERVICES} | sed "s/__/ /g")

for service in ${enabledservices}; do
  systemctl enable ${service}
done