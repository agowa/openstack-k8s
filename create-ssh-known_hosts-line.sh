#!/bin/sh

openstack console log show `echo $1 | sed 's/^.*,//'` | awk '/-----BEGIN SSH HOST KEY KEYS-----/,/-----END SSH HOST KEY KEYS-----/' | sed "1d;\$d;s/^/$1 /;s/\[//;s/\]//"
