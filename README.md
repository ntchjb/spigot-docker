# Spigot Minecraft Server in Docker

Easily build & start Spigot Minecraft server in a container. No need to manually setup your server environment.

## Prerequisite

1. Docker with Docker Compose :whale:

That's all you need!

## Usage

You may need to get familiar with Docker before using it (which is easy!). Here is steps for building and running Spigot Minecraft server.

1. Clone this project.
2. Go the the project folder and edit [Spigot properties](#spigot-variables.env) as you preferred in `spigot-variables.env`. Note that you may need to agree [Minecraft EULA](https://account.mojang.com/documents/minecraft_eula) to be able to run the server.
3. Create an empty folder called `mcdata` in the project folder. All Spigot files will be generated inside this folder after run the server.
4. Run the following command to build and start Spigot Minecraft server.

```
docker-compose up -d
```

The above command creates a docker container called `spigot` and run it in background. Also, the command start building before run the server if the image hasn't been built yet.

5. Enjoy :tada:

## spigot-variables.env

**`EULA`**: The agreement status for Minecraft EULA. Can be either `true` or `false`. The EULA is agreed if the value is `true`. Otherwise, the value is `false`. In order to run Spigot Minecraft server, The Minecraft EULA need to be agreed.

**`START_RAM_USAGE`**: The beginning amount of RAM used by the server. After started the server, the amound of RAM allocated will not be lower than this value. The example syntax of the value is as follow.

```
# "2G" means 2 Gigabytes.
START_RAM_USAGE=2G

# "2M" means 2 Megabytes.
START_RAM_USAGE=2M
```

**`MAX_RAM_USAGE`**: The maximum amount of RAM used by the server. The server will not allocate RAM more than this specified value. The syntax is the same as `START_RAM_USAGE`.

Note that these properties are environment variables inside the Spigot's container. Feel free to provide the variables in [different ways](https://docs.docker.com/compose/environment-variables/).

## Update Spigot Version

In order to update or change Spigot version, rebuild Docker image is required, so that build tools can be updated. The command is as follow.

```
docker-compose build --no-cache --build-arg version=<your_preferred_version>
```

The command above rebuild the entire Docker image with disabling cache, so that build tool and other necessary files are newly downloaded from the internet. preferred version can also be specified as properties for building the image. Replace `<your_preferred_version>` to your preferred version of Spigot server e.g. `1.14.2`.

## Manipulate Server Files

In order to add plugins, datapacks, or modify `server.properties`, these files can be found in `mcdata` folder that you already created in project root folder.

## Access Server Console

Accessing Spigot server console can be done with the following command

```
docker attach spigot-docker_spigot_1
```

This command attach your terminal to container's terminal, so that the server console can be used. Press `Ctrl+P` followed by `Ctrl+Q` to exit the container terminal. Note that exit the container terminal doesn't stop the server. The terminal can be accessed again using `docker attach` command.

## For those who are using Docker for Mac

MacOS uses different mechanism of file system, which may decrease the performance of mounting volume when mounted to linux container. Therefore, we reccommended to put `:delegated` tag at the end of volumes in docker compose file to increase performance, like this:

``` yml
volumes:
  - ./mcserver/:/mcserver:delegated
```

## Other useful instructions (Docker commands)

Start & stop the existing container
```
docker start <container name>
docker stop <container name>
```
Delete the stopped container. Game files will not be deleted
```
docker rm <container name>
```
Use Minecraft console inside the container. Note that the previous logs won't be displayed.
```
docker attach <container name>
```
Exit after attached the container, type:
```
Ctrl+P, Ctrl+Q
```
View server logs. Add -f before spg to stream the new log and type Ctrl+C to quit
```
docker logs spg
```
Copy files from the container to host
```
docker cp spg:/mcserver mcserver
```
Copy files from the host to the container (Example)
```
docker cp mcserver/world spg:/mcserver/world
```

# Credits

Made by Nathachai Jaiboon