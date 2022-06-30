#!/bin/bash

echo `date`

#CPU use Threshold

cpu_threshold='50'

#mem idle threshold

mem_threshold='50'

#disk use threshold

disk_threshold='50'

#---CPU usage Function

cpu_usage (){
	cpu_idle=`top -b -n 1 | grep Cpu | awk '{print $8}'|cut -f 1 -d"."`
	
	cpu_use=`expr 100 - $cpu_idle`
	
	echo "cpu utilization: $cpu_use"

	if [ "$cpu_use"-gt $cpu_theshold ]
	then 
		echo "cpu warning!!!"
	else 
		echo "Not to worry with CPU"
	fi
}
#---Memory Usage Check Function

mem_usage () {
	#GigaBytes as the units
	mem_free=`free -g | grep "Mem" | awk '{print $4+$6}'`
	
	echo "memory space remaining : $mem_free GB"
	
	if [ "$mem_free" -lt $mem_threshold ]
	then 
		echo "Memory Warning"
	else
		echo "Memory is okay"
	fi
}
# Disk Usage Check Function

disk_usage (){
	
	disk_use=`df -P | grep /dev | grep -v -E '(tmp|boot)' | awk '{print $5}' | cut -f 1 -d "%"`
	
	echo "disk usage : $disk_use %"

	if [ "$disk_use"-gt  $disk_threshold ]
	then
		echo "DISK WARNING!!!"
	else
		echo "DISK OKAY"
	fi
}

cpu_usage 
mem_usage
disk_usage

