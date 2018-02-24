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
  docker start ec98ccdd9f94
  ```
## access container
```bash
 docker exec -t -i a8f0e8326395 /bin/bash
 ```
