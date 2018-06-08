# Spigot Minecraft Server in a Docker

This container will generate a spigot server files from its build tools and start the server at default port number. The server's file can be modified in server folder

## Build and Start the server

Build the server
Build the image of the container
```
docker build -t spigot .
```
And then copy file to your host (docker run volume require full path, so we included $(pwd)) (spgb name can be changed to any unique name)
```
docker run -v $(pwd)/result:/mcserver --rm --name spgb spigot-build
```
or
```
docker-compose up
```

Run the server

First, you need to move/copy spigot.jar file into Server folder and then run this command to start running
Assuming that your current directory is Server
```
docker run -it --name spg spigot-server
```
Then, you stop the server by typing
```
stop
```
Then, copy files from container to the host
```
docker cp spg:/mcserver .
docker rm spg
```
Then, start again with mounting (spg name can be changed to any unique name)
```
docker run -v $(pwd)/mcserver:/mcserver -it --name spg spigot-server
```
or
```
docker-compose up
```

## Other instructions
To start the existing container
```
docker start spg
```
To stop the existing container
```
docker stop spg
```
To delete the stopped container
```
docker rm spg
```
To use the server console, use this command below. Note that it will not display previous log of the server console.
```
docker attach spg
```
To detach from the console, type
```
Ctrl+P, Ctrl+Q
```
To view server log, use the command below. Add -f before spg to stream the new log and type Ctrl+C to quit
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
After building the server, it will give spigot.jar which is the server file and spigot-API files which are shaded version and non-shaded version. This container may be used to generate server files or create server to play with your friends.

1. Mount volume
2. Copy spigot.jar, start.sh and spigot-api to mounted volume
3. run start.sh, edit eula, and run again
4. done
