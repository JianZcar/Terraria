FROM debian:bookworm

# Define build argument for version number with default 1449
ARG VERSION=1449

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    lib32gcc-s1 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /opt/terraria

# Download and extract Terraria server using the VERSION arg
RUN wget https://terraria.org/api/download/pc-dedicated-server/terraria-server-${VERSION}.zip -O terraria.zip && \
    unzip terraria.zip && \
    cp -r ${VERSION}/Linux/* . && \
    rm -rf terraria.zip ${VERSION}

# Make the server executable
RUN chmod +x TerrariaServer.bin.x86_64

# Expose default port
EXPOSE 7777

# Use volume for persistent worlds
VOLUME /root/.local/share/Terraria/Worlds

# Default command (can override in podman/docker run)
CMD ["./TerrariaServer.bin.x86_64"]
ENTRYPOINT ["./TerrariaServer.bin.x86_64"]
