#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/sonar/runner/bin:/usr/lib/jvm/java-8-oracle/bin:/usr/lib/jvm/java-8-oracle/db/bin:/usr/lib/jvm/java-8-oracle/jre/bin
LOGFILE="/var/log/startupscripts/idempiere/vagrant_startup.log"
STANDARDLOGFILE="/var/log/startupscripts/idempiere/vagrant_startingGuest.log"
vagrant_idemp=`which vagrant`
WDIR="/opt/vms/vagrant/idempiere/erp_academy"

cd $WDIR

#check if vagrant idempiere VM  is running 
if [[ $($vagrant_idemp status | grep 'poweroff (virtualbox)') == "default                   poweroff (virtualbox)" ]] || [[ $($vagrant_idemp status | grep 'aborted (virtualbox)') == "default                   aborted (virtualbox)" ]];then
    echo Vagrant Idempiere instance is not running $(date) >> $LOGFILE
        
    #Go to the vagrant idempiere directory
    cd $WDIR

    #start vagrant
    $vagrant_idemp up &> $STANDARDLOGFILE

    sleep 5

    #Check if the guest OS is now running
    cd $WDIR
    $vagrant_idemp status &> $STANDARDLOGFILE
else
    echo The vagrant server is running $(date) 2> /dev/null
fi
