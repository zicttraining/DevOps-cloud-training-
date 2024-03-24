# To work with Docker, you can use the following basic commands:

1. Check Docker version:
```
     docker --version
```
2. Pull an image from Docker Hub:
```
     docker pull <image_name>
```
3. Run a container:
```
     docker run -d --name <container_name> <image_name>
```
 This command starts a container in detached mode (-d) and assigns a name to the container (--name)

4. List running containers:
```
     docker ps
```
5. Stop a container:
```
     docker stop <container_name>
```
6. Remove a stopped container:
```
     docker rm <container_name>
```
7. Remove all unused images:
```
     docker image prune
```
8. Inspect a running container:
```
    docker inspect <container_name>
```
9. Open a shell inside a running container:
```
    docker exec -it <container_name> bash
```
10. Remove all unused images and containers:
```
    docker system prune
```

#### These commands will help you manage Docker images and containers
