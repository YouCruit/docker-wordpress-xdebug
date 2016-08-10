#!/bin/bash

if [ ! -f /xdebug_configured ]; then
    echo "=> Xdebug is not configured yet, configuring Xdebug ..."
    if [ "x" == "x$XDEBUG_HOST" ]; then
        XDEBUG_HOST=$(netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}')
    fi
    echo "xdebug.remote_enable=on" >> /etc/php5/mods-available/xdebug.ini
    echo "xdebug.remote_host=$XDEBUG_HOST" >> /etc/php5/mods-available/xdebug.ini
    echo "xdebug.remote_port=$XDEBUG_PORT" >> /etc/php5/mods-available/xdebug.ini

    touch /xdebug_configured
else
    echo "=> Xdebug is already configured"
fi
