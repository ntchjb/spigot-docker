# Spigot Minecraft Server in a Docker

This container will generate a spigot server files from its build tools and start the server at default port number. The server's file can be modified in server folder

# How to use

## Step One: Initialize the server

Build the docker to produce spigot files
```
docker build -t spigot .
docker run -it -d --name spg spigot
```
copy generated spigot files from the container to host
```
docker cp spg:/mcserver server
docker rm spg
```
And then start the server with mounted directory
```
docker run -it -v server:/mcserver -p 25565:25565 --name spg spigot /mcserver/START.sh
```

After building the server, it will give spigot.jar which is the server file and spigot-API files which are shaded version and non-shaded version. This container may be used to generate server files or create server to play with friends.
