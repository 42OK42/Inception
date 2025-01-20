# Inception
# Inception

A Docker-based web infrastructure project that sets up a complete LEMP stack (Linux, Nginx, MariaDB, PHP) running WordPress in separate containers.

## Overview

This project implements a containerized web infrastructure with the following components:

- NGINX container with TLS v1.2/1.3 support
- WordPress + PHP-FPM container
- MariaDB container
- Docker volumes for persistent data
- Docker network for container communication
- Secure secrets management
- Automated setup and initialization

## Prerequisites

- Docker and Docker Compose
- Make
- OpenSSL (for certificate generation)
- Linux/Unix environment

## Usage

### Initial Setup

1. Clone the repository:
```bash
git clone git@github.com:42OK42/Inception.git
```

2. Navigate to the project directory:
```bash
cd inception
```

3. Initialize secrets and environment files:
```bash
make init
```

4. Build the Docker images:
```bash
make build
```

5. Start the containers:
```bash
make run
```

6. Access WordPress:
```bash
https://okrahl.42.fr
```

## Special Thanks to the owner of the guide i used 

- [Roibos22](https://github.com/roibos22)

## License

This project is part of the 42 School curriculum.

