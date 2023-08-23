#!/usr/bin/env sh
#
# touchpad-toggle: Toggle touchpad activation with gsettings.
# Copyright (C) 2015 Guillaume Kulakowski <guillaume@kulakowski.fr>
# Version 1.0
#

SCHEMA="org.gnome.desktop.peripherals.touchpad"
KEY="disable-while-typing"

STATUS=$(gsettings get ${SCHEMA} ${KEY})

if [ "${STATUS}" == "true" ]; then
    gsettings set ${SCHEMA} ${KEY} false
else
    gsettings set ${SCHEMA} ${KEY} true
fi
