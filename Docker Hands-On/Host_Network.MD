## Run a container with host networking:
```
docker run --network host <image_name>
```
This command starts a container with host networking, which means the container shares the host's networking namespace and doesn't get its own IP address allocated.

## List running containers:
```
docker ps
```

## Stop a container:
```
docker stop <container_name>
```

## Remove a stopped container:
```
docker rm <container_name>
```

#### These commands will help you manage containers using host networking in Docker