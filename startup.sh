#!/bin/bash

hadoop fs -mkdir       /tmp
hadoop fs -mkdir -p    /user/hive/warehouse
hadoop fs -chmod g+w   /tmp
hadoop fs -chmod g+w   /user/hive/warehouse

if [ ! -d /hive-metastore/metastore_db ]; then
  cd $HIVE_HOME/bin
  ./schematool -initSchema -dbType derby
fi

cd $HIVE_HOME/bin
./hiveserver2 --hiveconf hive.server2.enable.doAs=false
