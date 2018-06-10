# Spigot Minecraft Server in a Docker

This container generates spigot server files from its build tool and starts the server at default port number. There is 2 main parts, which are builder and server.

## Build and Run the Server

### Build spigot.jar and its API


Build a docker image by using `Dockerfile` inside `Builder` folder, and then transfer the result to your host by running and mounting the image (Volume option in `docker run` requires full path, so we include `$(pwd)`) (`spgb` is a container name)
``` shell
docker build -t spigot-build .
docker run -v $(pwd)/result:/mcserver --rm --name spgb spigot-build
```
or use docker-compose for more convenient
``` shell
docker-compose up --build
docker-compose down
```

### Run a server
Put your spigot.jar file into `Server` folder and run following commands in the folder. *EULA needs to be accepted to use server by adding `-e EULA=true` as an argument to `docker run` command.*
``` shell
docker build -t spigot-server .
docker run -v $(pwd)/mcserver:/mcserver -itd -e EULA=true --name spg spigot-server /mccore/START.sh
```
or use docker compose instead. *EULA can be set in `docker-compose.yml`*
``` shell
docker-compose up -d --build
```
Now, your server is running. To access Minecraft console, use this command to get inside the container
``` shell
docker attach server_spg_1
```
If you don't know your container name, you can check it by typing `docker ps`.

To stop the server, use `docker attach` and type `stop` to stop the server. The container will be automatically stopped after stopped the server.

`START.sh` can be edited to change memory usage and other arguments.
`condi.sh` will check for EULA and then start the server. No need to change here.

enjoy :)

## For those who are using Docker for Mac

MacOS uses different mechanism of file system, which may decrease the performance of mounting volume. Therefore, we reccommended to put `:delegated` tag at the end of volumes in docker compose file to increase performance, like this:

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
