#!/bin/bash

dscheck_users(){
    awk -F: '{if($3 >= 1000 && $3 < 65000){ printf $3 ";" $1 ";" $5 ";" $6 ";"; system("groups " $1 " | grep -o sudo"); printf "\n"}}' /etc/passwd
}

dscheck_groups(){
    awk -F: '{if($4 != ""){ print $3 ";" $1 ";" $4}}' /etc/group
}

dscheck_ports(){
    sudo lsof -i | awk 'NR>1{print $2 ";" $1 ";" $3 ";" $9 ";" $8}'
}

dscheck_history(){
    last | head -n -2 | awk '{if($1 != "reboot"){
                                print $1";"$3";"$4" "$5" "$6" "$7" - "$9";"$10
                            }else{
                                print $1";"$4";"$5" "$6" "$7" "$8" "$10";"$11
                            }}'
}

dscheck_get_servernames(){
   ls /etc/apache2/sites-available/ | awk '{system("cat /etc/apache2/sites-available/" $1 " | grep ServerName | awk '\''{print $0}'\''")}'
}

dscheck_websites(){
   dscheck_get_servernames | awk '{if($1 != "#") print $2}'
}

dscheck_syshard(){
    echo -n 'hostname: '; uname -n
    echo -n 'installed: '; last | tail -n 1 | awk '{print $4 " " $5 " " $6 " " $7}' | tr : -
    echo -n 'uptime: '; uptime -p
    echo -n 'os_version: '; lsb_release -d | awk '{for(i=2;i<=15;i++)printf "%s ",$i; printf "\n"}'
    echo -n 'kernel_version: '; uname -r
    echo -n 'architecture: '; uname -m
    echo -n 'memory: '; cat /proc/meminfo | grep MemTotal | awk '{ print $2/1048576 " GiB"}'
    echo -n 'disk_space: '; df -hT / | awk 'NR==2{print $4 " " $5 "/" $3 " " $6}'
    echo -n 'cpu_model: '; cat /proc/cpuinfo | grep 'model name' | awk 'NR==1{print $4 " " $5 " " $6 " " $9}';
    echo -n 'cpus: '; lscpu | grep 'CPU(s):' | awk 'NR==1{print $2}'
    echo -n 'public_ip: '; curl -sS ipinfo.io/ip
}

dscheck_programs(){
    IFS=: read -ra dirs_in_path <<< "$PATH"

    for dir in "${dirs_in_path[@]}"; do
        for file in "$dir"/*; do
            [[ -x $file && -f $file ]] && printf '%s\n' "${file##*/}"
        done
    done
}

dscheck_stack(){
    dscheck_programs | grep -w 'php\|apache2\|python\|sshd\|mysqld\|ruby\|rails\|phpmyadmin\|letsencrypt\|nodejs\|npm\|ufw\|openssl\|vsftp\|virtualbox\|vagrant'
}

if [[ "$#" -eq 1 ]]; then
    if [[ $1 == "users" ]]; then
        dscheck_users | column -s ';' -t
    elif [[ $1 == "groups" ]]; then
        dscheck_groups | column -s ';' -t
    elif [[ $1 == "ports" ]]; then
        dscheck_ports | column -s ';' -t
    elif [[ $1 == "stack" ]]; then
        dscheck_stack
    elif [[ $1 == "history" ]]; then
        dscheck_history | column -s ';' -t
    elif [[ $1 == "syshard" ]]; then
        dscheck_syshard | column -s ':' -t
    elif [[ $1 == "websites" ]]; then
        dscheck_websites
    else
        echo "Oops."
    fi
elif [[ $1 == "daemon" ]]; then
    if [[ $2 == "users" ]]; then
        dscheck_users
    elif [[ $2 == "groups" ]]; then
        dscheck_groups
    elif [[ $2 == "ports" ]]; then
        dscheck_ports
    elif [[ $2 = "stack" ]]; then
        dscheck_stack
    elif [[ $2 == "syshard" ]]; then
        dscheck_syshard
    fi
fi
