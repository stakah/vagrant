#!/bin/sh

# shutdown.sh

sh ./startup-is.sh stop
sh ./startup-am.sh stop
sh ./startup-esb.sh stop
