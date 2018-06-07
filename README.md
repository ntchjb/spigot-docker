# Spigot Minecraft Server in a Docker

This container will generate a spigot server files from its build tools and start the server at default port number. The server's file can be modified in server folder

## Build and Start the server

Build the docker to produce spigot files
```
docker build -t spigot .
```
And then run it
```
docker run -it -d -p 25565:25565 --name spg spigot
```
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
docker cp spg:/mcserver server
```
Copy files from the host to the container (Example)
```
docker cp server/world spg:/mcserver/world
```
After building the server, it will give spigot.jar which is the server file and spigot-API files which are shaded version and non-shaded version. This container may be used to generate server files or create server to play with friends.

1. Mount volume
2. Copy spigot.jar, start.sh and spigot-api to mounted volume
3. run start.sh, edit eula, and run again
4. done
