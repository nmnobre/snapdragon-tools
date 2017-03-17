#!/bin/sh

#### The help/usage message.

usage() {
	printf "usage: %s [-h] -c cpu
	-h: prints this message
	-c cpu: the number of the core to switch on/off \n" $(basename $0) >&2
}

#### Parse options

if [ $# -lt 1 ] ; then
   usage
   exit 1
fi

while getopts ":c:h" opt; do
  case $opt in
    c)
      CPU=$OPTARG ;;
    h)
	  usage
	  exit 1 ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      exit 1 ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      usage
      exit 1 ;;
  esac
done

####

echo $(( $(cat /sys/devices/system/cpu/cpu$CPU/online) ^ 1 )) > /sys/devices/system/cpu/cpu$CPU/online