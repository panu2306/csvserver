## Steps: 
1. Firstly, pull the image mentioned using: 
```
docker pull infracloudio/csvserver:latest
```
2. Run the container with name as `part_i` in background(mentioned) using:
```
docker container run --name part_i -d infracloudio/csvserver:latest 
```	
3. See, if the container is running using:
```
docker container ls
```
4. Found out it is not running, check in all(stopped and running) the containers using:
```
docker container ls -a
```
5. Start again the stopped container but this time using -ai flag to get STDOUT:
```
docker container start -ai part_i
```
6. You will find out the error saying: `error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory`. Now, by looking at error we get to know that particular file named `inputdata` is missing. So, we need to create the file. 
7. As per mentioned steps we have to create a file `inputdata` using bash script `gencsv.sh` whose contents are:
```
#!/bin/bash                                                                                                                                                                                                                                                                                                                                   
# to read number of entries we want to have otherwise setting up 10 default entries:                                                                         
read -p "Enter number of entries you need(default=10):" n                                                                                                              
n=${n:-10}                                                                                                                                                                                                                                                                                                                             
# to get random numbers with index for each random number generated:                                                                                               
for i in `seq 0 $((n-1))`                                                                                                                                           
do                                                                                                                                                                           
echo $i, $RANDOM >> inputFile                                                                                                                                  
done                                                                                                                                                                           
```
8. Run above script using `./gencsv.sh`, it will ask for `entries you want to create`. Enter number of entries you want to create or it will by default create 10 entries if not provided. 	
9. The above script will generate a file named `inputdata`, it will have the entries as `index, RANDOM Number` e.g. `0, 193`.
10. Now, this `inputdata` file should be present in container's `/csvserver` directory. To copy this file let us create a Dockerfile as follows:
```
# Uses infracloudio/csvserver:latest image as a base:                                                                                                                   
FROM infracloudio/csvserver:latest                                                                                                                                                                                                                                                                                                              
# Copy the `inputdata` file into `/csverver/` directory:                                                                                                                
COPY inputdata /csvserver 
```
11. Now, delete the container that was earlier ran using previous image using: 
```
docker container rm part_i
```
12. Now, lets see the ports that have been exposed using: 
```
docker image inspect --format='{{.Config.ExposedPorts}}' infracloudio/csvserver:latest
``` 
13. Lets, run the container using:
```
docker container run --name part_i -p 9393:9300 -e CSVSERVER_BORDER=Orange infracloudio/csvserver:latest
```
14. At last open the application using browser by entering:
```
http://localhost:9393
```
