#!/bin/sh

ping -q -c5 3.13.80.190 > /dev/null

if [ $? -eq 0 ]
then
	echo "ok"
fi