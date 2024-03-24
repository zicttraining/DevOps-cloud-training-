# To create a volume, use the following command:
```
docker volume create <volume-name>
```

## To list all available volumes, use:
```
docker volume ls
```

## To inspect a specific volume, use:
```
docker volume inspect <volume-name>
```

## To remove a volume, use:
```
docker volume rm <volume-name>
```

#### Volumes can be mounted to container paths that already contain data. When this happens, Docker will copy the existing container data into the new volume. To mount a volume in read-only mode, include ro or readonly as the third field in your docker run command’s -v flag. Volumes are the preferred way to persist data in Docker containers and services and are easier to back up or migrate than bind mounts. They can be managed using Docker CLI commands or the Docker API and work on both Linux and Windows containers