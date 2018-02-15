#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/sonar/runner/bin:/usr/lib/jvm/java-8-oracle/bin:/usr/lib/jvm/java-8-oracle/db/bin:/usr/lib/jvm/java-8-oracle/jre/bin
LOGFILE="/var/log/rocketchat_restart_script/startup.log"
STANDARDLOGFILE="/var/log/rocketchat_restart_script/starting_services.log"
ERRORLOGFILE="/var/log/rocketchat_restart_script/error_starting_services.log"
docker_compose_rocketchat=`which docker-compose`
docker_compose_hubot=`which docker-compose`
WDIR="/opt/rocketchat"

#check if docker rocketchat container is running 

if [[ $(docker inspect -f {{.State.Status}} rocketchat_rocketchat_1) == "restarting" ]]; then
    echo Container is not running $(date) >> $LOGFILE
        
    #Go to the rocketchat directory
    cd $WDIR

    #start hubot
    $docker_compose_rocketchat up -d rocketchat >> $STANDARDLOGFILE 2>> $ERRORLOGFILE

    sleep 5

    #start rocketchat
    cd $WDIR
    $docker_compose_hubot up -d hubot >> $STANDARDLOGFILE 2>> $ERRORLOGFILE
else
    echo The container is running $(date) 2> /dev/null
fi
