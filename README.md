# docker-hive

This is a docker container for Apache Hive. It is based on https://github.com/big-data-europe/docker-hadoop so check there for Hadoop configurations.
This deploys Hive and starts a hiveserver2 on port 10000. 
Metastore is running with a connection to postgresql database. 
The hive configuration is performed with HIVE_SITE_CONF_ variables (see hadoop-hive.env for an example).

To run Hive with postgresql metastore:
```
    docker-compose up -d
```

To deploy in Docker Swarm:
```
    docker stack deploy -c docker-compose.yml hive
```

## Testing
docker exec -it hive-server bash 
```
  # /opt/hive/bin/beeline -u jdbc:hive2://localhost:10000
```
