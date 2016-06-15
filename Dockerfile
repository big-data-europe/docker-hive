FROM bde2020/hadoop-base

MAINTAINER Yiannis Mouchakis <gmouchakis@iit.demokritos.gr>

ENV HIVE_VERSION 2.0.0

ENV CORE_CONF_fs_defaultFS hdfs://namenode:8020
ENV CORE_CONF_hadoop_http_staticuser_user root
ENV CORE_CONF_hadoop_proxyuser_hue_hosts *
ENV CORE_CONF_hadoop_proxyuser_hue_groups *

ENV HDFS_CONF_dfs_webhdfs_enabled true
ENV HDFS_CONF_dfs_permissions_enabled false

ENV YARN_CONF_yarn_log___aggregation___enable true
ENV YARN_CONF_yarn_resourcemanager_recovery_enabled true
ENV YARN_CONF_yarn_resourcemanager_store_class org.apache.hadoop.yarn.server.resourcemanager.recovery.FileSystemRMStateStore
ENV YARN_CONF_yarn_resourcemanager_fs_state___store_uri /rmstate
ENV YARN_CONF_yarn_nodemanager_remote___app___log___dir /app-logs
ENV YARN_CONF_yarn_log_server_url http://historyserver:8188/applicationhistory/logs/
ENV YARN_CONF_yarn_timeline___service_enabled true
ENV YARN_CONF_yarn_timeline___service_generic___application___history_enabled true
ENV YARN_CONF_yarn_resourcemanager_system___metrics___publisher_enabled true
ENV YARN_CONF_yarn_resourcemanager_hostname resourcemanager
ENV YARN_CONF_yarn_timeline___service_hostname historyserver
ENV YARN_CONF_yarn_resourcemanager_address resourcemanager:8032
ENV YARN_CONF_yarn_resourcemanager_scheduler_address resourcemanager:8030
ENV YARN_CONF_yarn_resourcemanager_resource__tracker_address resourcemanager:8031

WORKDIR /opt

RUN apt-get update && apt-get install -y wget && \
	wget http://www-eu.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz && \
	apt-get --purge remove -y wget && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	tar -xzvf apache-hive-$HIVE_VERSION-bin.tar.gz && \
	mv apache-hive-$HIVE_VERSION-bin hive && \
	rm apache-hive-$HIVE_VERSION-bin.tar.gz

ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH
ENV HADOOP_HOME /opt/hadoop-$HADOOP_VERSION

ADD conf/hive-site.xml $HIVE_HOME/conf
ADD conf/beeline-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-env.sh $HIVE_HOME/conf
ADD conf/hive-exec-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-log4j2.properties $HIVE_HOME/conf
ADD conf/ivysettings.xml $HIVE_HOME/conf
ADD conf/llap-daemon-log4j2.properties $HIVE_HOME/conf

COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh

EXPOSE 10000
EXPOSE 10002

CMD startup.sh
