# Spigot Minecraft Server in a docker.
# Dockerfile for build and run spigot server
# Author: ntchjb

FROM openjdk:13

# Install packages and setup git
WORKDIR /
RUN yum update -y
RUN yum install -y git curl

# Add normal user who run and manipulate server
WORKDIR /
RUN groupadd -g 1000 minecraft \
  && useradd -m -u 1000 -g minecraft minecraft \
  && chown minecraft:minecraft /home/minecraft

# Create a folder where it store server files
RUN mkdir -m 770 /data && \
    chown minecraft:minecraft /data

# Import script files
WORKDIR /scripts
ADD ./scripts/start.sh .
ADD ./scripts/runserver.sh .
RUN chmod +x start.sh runserver.sh

# Set open port and volume path
EXPOSE 25565
VOLUME [ "/data" ]

# Build Spigot from its build tools
RUN mkdir /buildResult
WORKDIR /mcbuild

# This version specify Spigot server version
ARG version
# This argument is a dummy argument which break cache if its value is changed.
ARG revision
# Load build tool, run it, copy the result to a specific folder, and delete all build files
RUN curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar && \
    java -jar BuildTools.jar --rev ${version} && \
    cp Spigot/Spigot-API/target/spigot-api* /buildResult/ && \
    cp spigot-*.jar /buildResult/spigot.jar && \
    rm -rf /mcbuild

# Set current login user
USER minecraft
WORKDIR /data
# Always run this scripts after started container
CMD /scripts/start.sh
