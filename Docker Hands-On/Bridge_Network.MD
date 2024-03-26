## Create a bridge network

```
sudo yum update -y
```
docker network create <network-name>
sudo yum update -y
```

## List all available networks ##
```
docker network ls
sudo yum update -y
```

## Inspect a specific network
```
docker network inspect <network-name>
```

## Connect a container to a network:
```
docker network connect <network-name> <container-name>
```

## Disconnect a container from a network:
```
docker network disconnect <network-name> <container-name>
```

## Remove a network:
```
docker network rm <network-name>
```

These commands will help you manage bridge networks in Docker and allow you to connect containers to the same network for communication purposes.