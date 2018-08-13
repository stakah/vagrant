#! /bin/sh
export JAVA_HOME="/opt/java"

startcmd='/opt/wso2is/bin/wso2server.sh start > /dev/null &'
restartcmd='/opt/wso2is/bin/wso2server.sh restart > /dev/null &'
stopcmd='/opt/wso2is/bin/wso2server.sh stop > /dev/null &'

case "$1" in
start)
   echo "Starting WSO2 Identity Server ..."
   su -c "${startcmd}" wso2isuser
;;
restart)
   echo "Re-starting WSO2 Identity Server ..."
   su -c "${restartcmd}" wso2isuser
;;
stop)
   echo "Stopping WSO2 Identity Server ..."
   su -c "${stopcmd}" wso2isuser
;;
*)
   echo "Usage: $0 {start|stop|restart}"
exit 1
esac
