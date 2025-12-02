#!/bin/bash
echo "Commands Available"
echo "------------------"
echo "1.health-check    -- Show server health (Disk, Mem, CPU)"
echo "2.backup DIR      -- Backup a directory"
echo "3.show logs       -- View last 5 lines of log"
echo "4.exit            -- Quit"

server_health_check() {
    echo "DISK USAGE"
    df -h | head -n 1 && df -h | grep -E '(/$|/boot$|/home$)' 

    echo "MEMORY USAGE"
    free -h
    
    echo "CPU USAGE"
    uptime | awk -F'load average:' '{ print $2 }'
}

backup_DIR() {
    folder=$1
    backup="backup_$(date '+%s')"
    mkdir $backup
    cp -r $folder/* $backup
    echo "Backup created as $backup"
}

show_logs() {
    file=$1
    tail -n 5 $file
}

while true; do

read -p "Enter the command:" cmd1 cmd2

if [ "$cmd1" = "health-check" -o "$cmd1" = "1" ]; then
    server_health_check
elif [[ "$cmd1" == "backup" && "$cmd2" == "DIR" || "$cmd1" == "2" ]] ; then
    echo "Enter folder name or path without space:"
    read folder
    backup_DIR "$folder"
elif [[ "$cmd1" == "show" && "$cmd2" == "logs" || "$cmd1" == "3" ]] ; then
    echo "Enter file name:"
    read file
    show_logs "$file"
elif [ "$cmd1" = "exit" -o "$cmd1" = "4" ] ; then
    echo "Exiting...."
    sleep 1
    exit 0
else
    echo "Invalid Command"
fi
done
