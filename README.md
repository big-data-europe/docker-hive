# docker-hive

This is a docker container for Apache Hive. It is based on https://github.com/big-data-europe/docker-hadoop so check there for Hadoop configurations.
This deploys Hive and starts a hiveserver2 on port 10000. 
Metastore is running with a connection to postgresql database. 
The hive configuration is performed with HIVE_SITE_CONF_ variables (see hadoop-hive.env for an example).

To build and run Hive with postgresql metastore:
```
    docker-compose build
    docker-compose up -d namenode hive-metastore-postgresql
    docker-compose up -d datanode hive-metastore
    docker-compose up -d hive-server
```

hive-metastore service depends on hive-metastore-postgresql, which should be up and running before you start hive-metastore.
hive-server service depends on hive-metastore service.

## Testing
docker exec -it hive-server bash 
```
  # /opt/hive/bin/beeline -u jdbc:hive2://localhost:10000
```

## Bugs
When starting the beeline client you will get the following error:
```
ls: cannot access /opt/hive/lib/hive-jdbc-*-standalone.jar: No such file or directory
```
This is a [known bug](https://issues.apache.org/jira/browse/HIVE-14223)  in Hive 2.1.0 . It will be fixed in 2.1.1 and 2.2.0 releases. This error does not affect the connectivity to Hive.
