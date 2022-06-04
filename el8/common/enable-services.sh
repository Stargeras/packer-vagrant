#!/bin/bash

for service in ${ENABLEDSERVICES}; do
  systemctl enable ${service}
done