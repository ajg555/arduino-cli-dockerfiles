
FROM debian:trixie-slim

WORKDIR /arduino-cli

ENV PATH="$PATH:/arduino-cli/bin"

RUN apt-get update \
   && apt-get install -y --no-install-recommends curl ca-certificates bash-completion \
      python3 python3-serial python3-setuptools python3-dev \
   && rm -rf /var/lib/apt/lists/* \
   && curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh \
   && arduino-cli config init \
   && arduino-cli completion bash > arduino-cli.sh \
   && mv arduino-cli.sh /etc/bash_completion.d/ \
   && cat <<-EOF >> /root/.bashrc
# enable bash completion in interactive shells
if ! shopt -oq posix; then
   if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
   elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
   fi
fi
EOF

COPY arduino-cli.yaml /root/.arduino15

RUN arduino-cli config set network.connection_timeout 600s \
   # for current board versions, uncomment the line below and remove version tags
   # arduino-cli core update-index \
   && arduino-cli core install arduino:avr@1.8.6 arduino:esp32@2.0.18-arduino.5 esp32:esp32@3.3.4 esp8266:esp8266@3.1.2 

WORKDIR /root/Arduino

COPY libraries/ /root/Arduino/libraries

ENTRYPOINT [ "arduino-cli" ]
