#!/bin/bash

# MQTT Server Update Check
# Created by Dirk Baumeister (2018)
# https://github.com/DirkBaumeister
#
# Usage:
#
# mqtt-update-check.sh        // Publishes human readable update information to MQTT topic (If any)
# mqtt-update-check.sh --json // Publishes json update information to MQTT topic (If any)
#

# The FQDN to your MQTT broker.
MQTT_BROKER="broker.example.org"

# The port of your MQTT broker.
MQTT_PORT="1883"

# The topic where the update informaton
# should be published to.
MQTT_TOPIC="/notifier/server-updates"


# The following values are optional

# The username to authenticate against MQTT
MQTT_USER=""

# The password to authenticate against MQTT
MQTT_PASSWORD=""

# The location of the cert file to
# validate MQTT broker
MQTT_CERT_FILE=""


# Please do not change anything below
# unless you know what you are doing!

UPDATE_LIST=$(apt list --upgradable 2> /dev/null | grep -v 'Listing')

if [[ $(echo "$UPDATE_LIST" | wc -l) -gt 0 && "$UPDATE_LIST" != "" ]]; then

  echo "Updates available! Sending MQTT message to broker ${MQTT_BROKERR} on topic ${MQTT_TOPIC}..."

  if [ "$1" == "--json" ]; then

    UPDATE_STRING=$(echo "$UPDATE_LIST" | sed -n -e 'H;${x;s/\n/","/g;s/^","//;p;}')

    STRING="{"
    STRING="${STRING}\"hostname\":\"$(echo $(hostname))\","
    STRING="${STRING}\"updates\":["
    STRING="${STRING}\"${UPDATE_STRING}\""
    STRING="${STRING}]}"

  else

    STRING="Hostname: $(echo $(hostname))\n"
    STRING="${STRING}The following updates are available:\n"
    STRING="${STRING}${UPDATE_LIST}"

    STRING=$(echo -e "${STRING}")

  fi

  PARAMS=""

  if [ "$MQTT_USER" != "" ]; then
    PARAMS="${PARAMS} -u ${MQTT_USER}"
  fi

  if [ "$MQTT_PASSWORD" != "" ]; then
    PARAMS="${PARAMS} -P ${MQTT_PASSWORD}"
  fi

  if [ "$MQTT_CERT_FILE" != "" ]; then
    PARAMS="${PARAMS} --cafile ${MQTT_CERT_FILE}"
  fi

  mosquitto_pub $PARAMS -h ${MQTT_BROKER} -p ${MQTT_PORT} -t ${MQTT_TOPIC} -m "${STRING}"

else
  echo "No updates available..."
fi