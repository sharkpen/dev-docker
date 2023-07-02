# 构建镜像的命令
```
docker build . -t centos-lijinqi:latest
```

在Dockerfile中可以修改 ARG user_name=yoursefl

# 启动container
```
docker run -ti -d --name centos -p <host_port>:<container_port> centos-lijinqi:latest
```

# 进入docker
```
docker exec -it <container-id> /bin/zsh
```



