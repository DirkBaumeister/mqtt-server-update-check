# MQTT Server Update Check

A simple bash script to publish apt update messages to a topic on a MQTT broker

## Getting Started

These instructions will help you to understand how you can use this script

### Prerequisites

Please install the mosquitto client tools to execute this script

```
apt-get install mosquitto-clients
```

### Configuration

Please configure the following variables in the script

```
# The FQDN to your MQTT broker.
MQTT_BROKER="broker.example.org"

# The port of your MQTT broker.
MQTT_PORT="1883"

# The topic where the update informaton
# should be published to.
MQTT_TOPIC="/notifier/server-updates"
```


Additionally you can also configure this

```
# The username to authenticate against MQTT
MQTT_USER=""

# The password to authenticate against MQTT
MQTT_PASSWORD=""

# The location of the cert file to
# validate MQTT broker
MQTT_CERT_FILE=""
```

### Usage

If you want to publish the update message in a human readable format, just execute

```
./mqtt-server-update-check.sh
```

To make the output a little bit more parsable, you can use

```
./mqtt-server-update-check.sh --json
```

to publish the data as json

## References

* [Eclipse Mosquitto](https://mosquitto.org/) - An open source MQTT broker

## Authors

* **Dirk Baumeister** - [DirkBaumeister](https://github.com/DirkBaumeister)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

