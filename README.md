### To build and run each container:
- clone repo, cd into shiny-docker/simple-demo or shiny-docker/upload-demo
-
  ```
   chmod a+x ./build.sh
   chmod a+x ./run.sh
  ```
- build the image:
  ```
  ./build.sh
  ```
- run the image:
```
./run.sh
```
or depending on your system:
```
docker-compose up -d
```
or
```
docker compose up -d
```
- navigate to http://IP_of_Host:3838
