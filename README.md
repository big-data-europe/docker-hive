# docker-hive

This is a docker container for Apache Hive. It is based on https://github.com/big-data-europe/docker-hadoop so check there for Hadoop configurations.
This deploys Hive and starts a hiveserver2 on port 10000. 
By default metastore_db is located at /hive-metastore. All Hive configuration files are located in the conf directory.

To build docker-hive go into the docker-hive directory and run

    docker build -t hive .

To run it first deploy Hadoop (see https://github.com/big-data-europe/docker-hadoop)
Then start hiveserver2 by running

     docker run --name hive --net=hadoop -p 10000:10000 -p 10002:10002 -v <path/to/metastore_db/location>:/hive-metastore --env-file=./hadoop.env hive

Then you can access hiveserver2 from localhost:10000 and hiveserver2 UI from localhost:10002
 
