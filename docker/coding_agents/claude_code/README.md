# Claude Code Docker Container

This Docker container provides a development environment with Claude Code, Docker, and various development tools pre-installed.

## Features

- **Claude Code**: AI-powered coding assistant
- **Docker**: Docker CE with buildx and compose plugins
- **Development Tools**: Git, GitHub CLI, Node.js, and more
- **Auto-pull**: Automatically pull specified Docker images on startup

## Quick Start

### Basic Usage

```bash
# Run the container interactively
docker run -it --privileged ghcr.io/hakuturu583/naruto/claude-code:latest

# Run with workspace mounted
docker run -it --privileged -v $(pwd):/workspace ghcr.io/hakuturu583/naruto/claude-code:latest
```

### Auto-pull Docker Images

You can specify Docker images to be automatically pulled when the container starts:

```bash
# Pull a single image
docker run -it --privileged \
  -e DOCKER_IMAGE_TO_PULL=nginx:latest \
  ghcr.io/hakuturu583/naruto/claude-code:latest

# Pull multiple images (space-separated)
docker run -it --privileged \
  -e DOCKER_IMAGE_TO_PULL="nginx:latest ubuntu:22.04 python:3.11" \
  ghcr.io/hakuturu583/naruto/claude-code:latest
```

### With Docker Compose

```yaml
version: '3.8'
services:
  claude-code:
    image: ghcr.io/hakuturu583/naruto/claude-code:latest
    privileged: true
    volumes:
      - .:/workspace
    environment:
      - DOCKER_IMAGE_TO_PULL=nginx:latest ubuntu:22.04
    stdin_open: true
    tty: true
```

## Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `DOCKER_IMAGE_TO_PULL` | Space-separated list of Docker images to pull on startup | `nginx:latest ubuntu:22.04` |
| `TZ` | Timezone setting | `Asia/Tokyo` |

## Important Notes

### Privileged Mode Required

This container requires `--privileged` flag to run Docker daemon inside the container:

```bash
docker run -it --privileged ghcr.io/hakuturu583/naruto/claude-code:latest
```

### Docker-in-Docker (DinD)

The container runs Docker daemon inside Docker. This enables:
- Building Docker images
- Running containers
- Using docker-compose
- Testing containerized applications

### Security Considerations

- Only use `--privileged` mode in trusted environments
- Be aware that privileged containers have elevated access to the host system
- Consider using Docker-outside-Docker (DooD) for production environments

## Installed Tools

- **Claude Code**: AI coding assistant
- **Docker**: CE with buildx and compose plugins
- **Node.js**: Version 20.x with npm
- **GitHub CLI**: For Git operations
- **Development Tools**: git, curl, wget, jq, fzf, zsh
- **Network Tools**: iptables, ipset, iproute2, dnsutils

## Usage Examples

### Using Claude Code

```bash
# Inside the container
claude-code --help

# Start an interactive session
claude-code
```

### Building Docker Images

```bash
# Inside the container
docker build -t myapp .
docker run myapp
```

### Using Docker Compose

```bash
# Inside the container
docker-compose up -d
docker-compose logs -f
```

## Troubleshooting

### Docker Daemon Not Starting

If Docker daemon fails to start, try:

```bash
# Check Docker daemon status
docker info

# Manually start Docker daemon
dockerd &
```

### Permission Issues

If you encounter permission issues:

```bash
# Run container with user mapping
docker run -it --privileged -u $(id -u):$(id -g) \
  -v $(pwd):/workspace \
  ghcr.io/hakuturu583/naruto/claude-code:latest
```

### Image Pull Failures

If automatic image pulling fails:

```bash
# Check network connectivity
ping google.com

# Manually pull images
docker pull nginx:latest
```

## Building the Image

To build the image locally:

```bash
# Clone the repository
git clone https://github.com/hakuturu583/naruto.git
cd naruto/docker/coding_agents/claude_code

# Build the image
docker build -t claude-code:local .

# Run the locally built image
docker run -it --privileged claude-code:local
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the Docker image
5. Submit a pull request

## License

This project is licensed under the Apache-2.0 License.
