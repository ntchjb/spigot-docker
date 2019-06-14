# Spigot Minecraft Server in a docker.
# Dockerfile for build and run spigot server
# Author: ntchjb

FROM openjdk:12

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

# Set open port, current directory, and volume path
EXPOSE 25565
WORKDIR /data
VOLUME [ "/data" ]

# Build Spigot from its build tools
RUN mkdir /buildResult
ARG version
WORKDIR /mcbuild
RUN curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -jar BuildTools.jar --rev ${version}

# Copy the result to a specific folder
RUN cp Spigot/Spigot-API/target/spigot-api* /buildResult/ && \
    cp spigot-*.jar /buildResult/spigot.jar

# Set current login user
USER minecraft
# Always run this scripts after started container
CMD /scripts/start.sh