 # docker
 ## Build image
 ```bash
 docker build -t vop_iot/tick .
 ```
## show images
```bash 
docker images
```
 
## show containers
```bash
docker ps -a //all containers
docker ps //only running containers
```

## Create container from image
```bash
docker run -t -d --name tick vop_iot/tick
```
## start container
```bash
docker start ec98ccdd9f94 -a
```
-a will show all actions.

## access container
```bash
 docker exec -t -i a8f0e8326395 /bin/bash
 ```

## stop and delete all containers
```bash
docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)
```

## delete all images
```sh
docker rmi $(docker images -q)
```
