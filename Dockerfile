# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set environment variables
ENV TERRARIA_VERSION=1449
ENV TERRARIA_WORLD=world
ENV TERRARIA_WORLD_SIZE=1

# Install dependencies
RUN apt-get update && \
    apt-get install -y unzip wget && \
    apt-get clean

# Download and extract Terraria server files
RUN mkdir /terraria && \
    cd /terraria && \
    wget https://terraria.org/api/download/pc-dedicated-server/terraria-server-${TERRARIA_VERSION}.zip && \
    unzip terraria-server-${TERRARIA_VERSION}.zip && \
    rm terraria-server-${TERRARIA_VERSION}.zip

# Expose port
EXPOSE 7777

# Set working directory
WORKDIR /terraria/${TERRARIA_VERSION}/Linux

RUN chmod +x TerrariaServer.bin.x86_64

# Command to start Terraria server
CMD ./TerrariaServer.bin.x86_64 -autocreate ${TERRARIA_WORLD_SIZE} -world /terraria/${TERRARIA_VERSION}/Linux/Worlds/${TERRARIA_WORLD}.wld -worldpath /terraria/${TERRARIA_VERSION}/Linux/Worlds -worldsize ${TERRARIA_WORLD_SIZE} -worldname ${TERRARIA_WORLD}  -port 7777 -ip 0.0.0.0