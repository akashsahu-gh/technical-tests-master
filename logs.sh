# 
sudo docker build . -f Dockerfile -t go-hello-wrld

sudo docker build . -f dockerfile_new -t go-hello-wrld
sudo docker run -d --name website -p 8000:8000 go-hello-wrld
 

sudo docker run -it --rm -p 8000:8000 go-hello-wrld

sudo docker build . -f dockerfile -t python_api
sudo docker run -it --rm -p 8000:8000 python_api



Sending build context to Docker daemon 6.144 kB
Step 1/9 : FROM golang:alpine
Trying to pull repository docker.io/library/golang ... 
alpine: Pulling from docker.io/library/golang
801bfaa63ef2: Pull complete 
ee0a1ba97153: Pull complete 
1db7f31c0ee6: Pull complete 
ecebeec079cf: Pull complete 
63b48972323a: Pull complete 
Digest: sha256:49b4eac11640066bc72c74b70202478b7d431c7d8918e0973d6e4aeb8b3129d2
Status: Downloaded newer image for docker.io/golang:alpine
 ---> 1463476d8605
Step 2/9 : ENV GO111MODULE on
 ---> Running in be3c3e520726
 ---> 7e0d9e6e037a
Removing intermediate container be3c3e520726
Step 3/9 : WORKDIR /app
 ---> b3a158d6da2f
Removing intermediate container 1ec2edd706f3
Step 4/9 : ADD ./ /app
 ---> 8db32bef9761
Removing intermediate container 3eb812c1879c
Step 5/9 : RUN apk update --no-cache
 ---> Running in d7976be58cdf
fetch http://dl-cdn.alpinelinux.org/alpine/v3.12/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.12/community/x86_64/APKINDEX.tar.gz
v3.12.3-44-gb98f3f79fe [http://dl-cdn.alpinelinux.org/alpine/v3.12/main]
v3.12.3-44-gb98f3f79fe [http://dl-cdn.alpinelinux.org/alpine/v3.12/community]
OK: 12746 distinct packages available
 ---> 495d9b9fb25a
Removing intermediate container d7976be58cdf
Step 6/9 : RUN apk add git
 ---> Running in 8ba0db37fe70

fetch http://dl-cdn.alpinelinux.org/alpine/v3.12/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.12/community/x86_64/APKINDEX.tar.gz
(1/5) Installing nghttp2-libs (1.41.0-r0)
(2/5) Installing libcurl (7.69.1-r3)
(3/5) Installing expat (2.2.9-r1)
(4/5) Installing pcre2 (10.35-r0)
(5/5) Installing git (2.26.2-r0)
Executing busybox-1.31.1-r19.trigger
OK: 22 MiB in 20 packages
 ---> f1c0bb9be123
Removing intermediate container 8ba0db37fe70
Step 7/9 : RUN go build -o golang-test  .
 ---> Running in 47ad9d7f6368

go: downloading rsc.io/quote v1.5.2
go: downloading github.com/gorilla/mux v1.7.0
go: downloading rsc.io/quote/v3 v3.0.0
go: downloading rsc.io/sampler v1.3.0
go: downloading golang.org/x/text v0.0.0-20170915032832-14c0d48ead0c
 ---> e3376024ed5d
Removing intermediate container 47ad9d7f6368
Step 8/9 : ENTRYPOINT /app/golang-test
 ---> Running in e22fd9c95842
 ---> 819251d6e0c9
Removing intermediate container e22fd9c95842
Step 9/9 : EXPOSE 8000
 ---> Running in 6a10fbad3570
 ---> 1d6443aacc12
Removing intermediate container 6a10fbad3570
Successfully built 1d6443aacc12