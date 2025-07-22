# Zephyr RTOS Docker Environment

This repository provides a Dockerfile to set up a Zephyr RTOS development environment based on Ubuntu 22.04.

## Usage

1. Build the Docker image:
   ```sh
   docker build -t zephyr-update-docker .
   ```
2. Run the container:
   ```sh
   docker run --rm -it zephyr-update-docker
   ```

## Features
- Installs Zephyr RTOS and its dependencies
- Archives the environment for portability

## License
MIT
