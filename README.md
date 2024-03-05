# Employee Management System

## Setup EMS

##### Software you need | Application stacks
- Java 17 (OpenJDK17 `or above`)
- Maven (Apache Maven 3.9.4 `or above`)
- Cassandra
- Using H2 In-memory DB
- docker (for testing purpose)

##### Running ems 
- run runApp.sh

##### TO DOs
Once you complete any one, change it's marker with ☑️icon.

- 🔲 Installation guide for software
- 🔲 Add CI/CD pipe line 
- 🔲 Add JUnit and code coverage to 85% 
- 🔲 Mock data
- 🔲 Scripts for various ways of app running
- 🔲 Connecting UI with Backend

Happy exploring !!! :-)

###CMD 
- `mvn clean install` | to create jar 
- `docker build . -t employee-management:v1 -f ./docker/Dockerfile` 
- Above line will create docker image, with image name as `employee-management:v1`,
- `docker build .`, the (`.`) dot means current working directory 
- since `Dockerfile` is in side `./docker` folder : we had to add `-f` with `Dockerfile` present in `./docker/Dockerfile`  

- To run the created docker image in docker container 
  `docker run -p 9092:9090 --name emp-management-container -d employee-management:v1`

- Curl request 
- `curl --location 'http://localhost:9092/employee-management/testing/endpoint/1'`
