# Arduino CLI Docker Image

This image uses the Arduino CLI within a container for compilation, board management, project testing, and firmware flashing without requiring a local installation.

## Dockerfile

The Dockerfile used to build custom images can be found in the repository:

https://github.com/ajg555/arduino-cli-dockerfiles

## Arduino CLI

The official Arduino CLI project is available at:

https://github.com/arduino/arduino-cli

## Documentation and setup instructions for arduino-cli:

https://docs.arduino.cc/arduino-cli/getting-started

# Usage Examples

- Show help
```
docker container run --rm -it --name arduino arduino-cli --help
```

- List installed boards
```
docker container run --rm -it --name arduino ajg555/arduino-cli core list
```

- Enter the container with bash auto-completion enabled. This allows you to use arduino-cli freely as if it were installed locally:
```
docker container run --rm -it -v ~/my-codes:/my-codes --device=/dev/ttyUSB0 --entrypoint bash --name arduino ajg555/arduino-cli
```

- To simplify usage, an alias can be added to '~/.bashrc', reducing typing. Example:
```
alias arduino-dk="docker container run --rm -v ~/my-codes:/my-codes -it --entrypoint bash --name arduino ajg555/arduino-cli"
```
```
$ arduino-dk 
root@0353861fa74d:~/Arduino# 
```






