This is a docker container for the following services:

* [hadoop & hive](https://github.com/big-data-europe/docker-hive)
* [HBase](https://github.com/HariSekhon/Dockerfiles)

All credit goes to the creators of these images. Please see original repos/dockerfiles for information about how they are configured. Modifications to hive configuration have been made in order to support operation with the UChicago MPCS Big Data course.

## Setup and Usage
After cloning the repo, cd into the directory and run
```bash
docker-compose up
```
It will probably take a while to pull the images, so make sure you have good internet connection and time to spare. Once everything is up and running you should be good to go. To stop the containers run
```bash
docker-compose stop
```

Both the HBase and Hive containers share a mounted volume on your host system, named `MPCS_data`. Use this directory to use files (text files, jars, etc) in these containers.

Here are some of the more useful ports to know:
* hbase master status: 16010
* zookeeper client port: 2181
* hbase rest api port: 8080

### Hive
#### Basic Usage
Exec into the hive container to run HQL and such:
```
docker exec -it docker-hive_hive-server_1 bash
```
Then to start beeline run `beeline -u jdbc:hive2://localhost:10000`

#### Adding JARs
To add a jar to hive, for example for a SERDE operation, you must copy your uberjar into the mounted volume, then in hive container, into the hive lib.

Example:
```
cp /MPCS_data/uber-MyJar-1.0-SNAPSHOT.jar /opt/hive/lib
```
Then once in beeline add the jar:
```
hive> add jar /opt/hive/lib/uber-MyJar-1.0-SNAPSHOT.jar;
```
The `lib` volume is not persistent so you'll have to do this every time you want to add a jar (too lazy to fix this for now).

### HBase
#### Basic Usage
Exec into the HBase container like so:
```
docker exec -it docker-hive_hbase_1 bash
```
Start the hbase shell by running `hbase shell`.
