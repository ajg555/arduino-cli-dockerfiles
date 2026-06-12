# Arduino CLI Docker Image

This image provides the Arduino CLI inside a Docker container, allowing you to compile sketches, manage board packages, test projects, and upload firmware without installing Arduino CLI on your host system.

## Features

* Arduino CLI pre-installed
* ESP32 support
* Board package management
* Firmware upload support
* Persistent development environment
* Helper commands (`compile`, `upload`)
* Bash auto-completion

## Repository

The Dockerfiles used to build the images are available at:

https://github.com/ajg555/arduino-cli-dockerfiles

## Arduino CLI

Official Arduino CLI repository:

https://github.com/arduino/arduino-cli

## Documentation

Official Arduino CLI documentation:

https://docs.arduino.cc/arduino-cli/getting-started

# Quick Start

Create a persistent container:

```bash
docker container run \
    -it \
    --name arduino \
    --entrypoint bash \
    -v ~/projects:/root/Arduino/projects \
    --privileged \
    -v /dev:/dev \
    ajg555/arduino-cli
```

Reconnect later:

```bash
docker container start -ai arduino
```

# Usage Examples

## Show help

```bash
docker container run --rm -it --name arduino ajg555/arduino-cli --help
```

## List installed boards

```bash
docker container run --rm -it --name arduino ajg555/arduino-cli core list
```

## Open an interactive shell

This allows you to use Arduino CLI as if it were installed locally.

```bash
docker container run \
    --rm \
    -it \
    -v ~/my-codes:/my-codes \
    --device=/dev/ttyUSB0 \
    --entrypoint bash \
    --name arduino \
    ajg555/arduino-cli
```

## Create a shell alias

To simplify usage, add the following alias to your `~/.bashrc`:

```bash
alias arduino-dk="docker container run --rm -it \
-v ~/my-codes:/my-codes \
--entrypoint bash \
--name arduino \
ajg555/arduino-cli"
```

Example:

```bash
$ arduino-dk

root@0353861fa74d:~/Arduino#
```

# Recommended Workflow

## Create a persistent container

```bash
docker container run \
    -it \
    --name arduino \
    --entrypoint bash \
    -v ~/projects:/root/Arduino/projects \
    --privileged \
    -v /dev:/dev \
    ajg555/arduino-cli
```

## Reopen the container

```bash
docker container start -ai arduino
```

# Board and Port Configuration

The helper commands use two environment variables:

* `BOARD` – Arduino board FQBN (Fully Qualified Board Name)
* `PORT` – Serial port used for uploads

## Check current values

```bash
echo $BOARD
echo $PORT
```

Example:

```text
esp32:esp32:esp32
/dev/ttyACM0
```

These values are defined by default in the Docker image and can be changed during the current shell session.

## Change the board

For example, to use an ESP32 Dev Module:

```bash
export BOARD=esp32:esp32:esp32
```

For an ESP32-S3:

```bash
export BOARD=esp32:esp32:esp32s3
```

For an ESP32-C3:

```bash
export BOARD=esp32:esp32:esp32c3
```

For an ESP32-C6:

```bash
export BOARD=esp32:esp32:esp32c6
```

For an Arduino Uno:

```bash
export BOARD=arduino:avr:uno
```

## Change the upload port

For devices detected as `/dev/ttyUSB0`:

```bash
export PORT=/dev/ttyUSB0
```

For devices detected as `/dev/ttyACM0`:

```bash
export PORT=/dev/ttyACM0
```

## Discover available serial ports

List the available serial devices:

```bash
ls /dev/ttyUSB* /dev/ttyACM* 2>/dev/null
```

You can also use Arduino CLI to identify connected boards:

```bash
arduino-cli board list
```

Example:

```text
Port         Protocol Type              Board Name FQBN Core
/dev/ttyACM0 serial   Serial Port (USB) Unknown
/dev/ttyS0   serial   Serial Port       Unknown
```

The detected port can then be assigned to `PORT`, and the reported FQBN can be assigned to `BOARD`.

# Helper Commands

The image provides helper commands:

* `compile` – compile the current sketch
* `upload` – compile and upload the sketch using the configured `BOARD` and `PORT`

# Compile a Sketch

```bash
cd ~/Arduino/projects/examples/WiFiScan
```

```bash
compile
```

Example output:

```text
Sketch uses 883563 bytes (67%) of program storage space. Maximum is 1310720 bytes.
Global variables use 43968 bytes (13%) of dynamic memory, leaving 283712 bytes for local variables. Maximum is 327680 bytes.
```

# Upload Firmware

```bash
upload
```

Example output:

```text
Sketch uses 883563 bytes (67%) of program storage space. Maximum is 1310720 bytes.
Global variables use 43968 bytes (13%) of dynamic memory, leaving 283712 bytes for local variables. Maximum is 327680 bytes.
esptool v5.1.0
Connected to ESP32 on /dev/ttyACM0:
Chip type:          ESP32-D0WDQ6-V3 (revision v3.1)
Features:           Wi-Fi, BT, Dual Core + LP Core, 240MHz, Vref calibration in eFuse, Coding Scheme None
Crystal frequency:  40MHz
MAC:                xx:xx:xx:xx:xx:xx

Stub flasher running.
Changing baud rate to 921600...
Changed.

Configuring flash size...
Flash will be erased from 0x00001000 to 0x00007fff...
Flash will be erased from 0x00008000 to 0x00008fff...
Flash will be erased from 0x0000e000 to 0x0000ffff...
Flash will be erased from 0x00010000 to 0x000e7fff...
Wrote 25184 bytes (16080 compressed) at 0x00001000 in 0.7 seconds (274.0 kbit/s).
Hash of data verified.
Wrote 3072 bytes (146 compressed) at 0x00008000 in 0.1 seconds (351.7 kbit/s).
Hash of data verified.
Wrote 8192 bytes (47 compressed) at 0x0000e000 in 0.1 seconds (472.7 kbit/s).
Hash of data verified.
Wrote 883712 bytes (567786 compressed) at 0x00010000 in 9.7 seconds (729.1 kbit/s).
Hash of data verified.

Hard resetting via RTS pin...
New upload port: /dev/ttyACM0 (serial)

```

# Build Locally

Clone the repository and build the image:

```bash
git clone https://github.com/ajg555/arduino-cli-dockerfiles.git
cd arduino-cli-dockerfiles
docker build -t arduino-cli .
```
# Installed Arduino Cores

This image includes the following cores:

```text
arduino:avr     1.8.6
arduino:esp32   2.0.18-arduino.5
esp32:esp32     3.3.4
esp8266:esp8266 3.1.2
```

---

# Installed Libraries

Preinstalled Arduino libraries include:

```text
AceButton
Adafruit BME280 Library
Adafruit BusIO
Adafruit GFX Library
Adafruit SSD1306
Adafruit Unified Sensor
ArduinoJson
AsyncTCP
DHT sensor library
ESP Async WebServer
EspMQTTClient
LoRa
RadioHead
RadioLib
TinyGPS++
TinyGSM
U8g2
WiFiManager
TFT_eSPI
OneWire
PID
PubSubClient
```

Full list available via:
```bash
arduino-cli lib list
```

---

# Build Locally

```bash
git clone https://github.com/ajg555/arduino-cli-dockerfiles.git
cd arduino-cli-dockerfiles
docker build -t arduino-cli .
```

---

# Notes

- USB access is required for flashing boards.
- Use `--privileged` for reliable device access.
- `BOARD` and `PORT` are session-based environment variables.
- Libraries and cores are preinstalled to reduce setup time.
