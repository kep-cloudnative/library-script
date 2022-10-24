#!/bin/bash
. /data/script/app-env.sh

SERVICE_PROCESS="library-monolithic"
PS_OUT=""
PROCESS_ID=""

JAVA_OPT=" -Dspring.profiles.active=${PROFILE} "
JAVA_OPT=${JAVA_OPT}" -DMYSQL_HOST=${MYSQL_HOST} "
JAVA_OPT=${JAVA_OPT}" -Dspring.datasource.hikari.username=${DB_USERNAME} "
JAVA_OPT=${JAVA_OPT}" -Dspring.datasource.hikari.password=${DB_PASSWORD} "

process_check(){
    PS_OUT=`ps -ef | grep -v grep | grep ${SERVICE_PROCESS} `
    if [[ ${PS_OUT} != "" ]]; then
        PROCESS_ID=`echo ${PS_OUT} | awk '{print $2}'`
        echo "${SERVICE_PROCESS}(${PROCESS_ID}) is running now."
    else
        echo "${SERIVCE_PROCESS} is not running. please check your service."
    fi
}

kill_process(){
    if [[ "${PROCESS_ID}" != "" ]]; then
        RESULT=`kill -9 ${PROCESS_ID}`
        sleep 2
        echo "${SERVICE_PROCESS}(${PROCESS_ID}) is killed."
    fi
}

process_check
kill_process

echo "JAVA_OPT=${JAVA_OPT}"
nohup java -jar ${JAVA_OPT} /data/library-monolithic.jar 1>/dev/null 2>&1 &
#java -jar ${JAVA_OPT} /data/library-monolithic.jar

process_check
