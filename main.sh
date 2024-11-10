#! /usr/bin/bash

echo "The following script assumes you meet the following requirements:
	> You have run the scripts as sudo
	> Your current working directory is where your scripts are stored 
	> You already have a second hard drive with enough space (20G)"

echo "If true, confirm to continue (y/n):"
read answer

if [ "$answer" == "y" ]; then 
       echo "Continuing with the script..."
else 
    echo "Exiting the script."
    exit
fi

# Getting Current path where scripts are stored
script_path=$(pwd)

echo "Updating and installing necessary host system packages"

${script_path}/update.sh
echo "......................................................"
${script_path}/version_check.sh
echo "......................................................"

echo "If all is fine continue. (y/n)"
read answer

if [ "$answer" == "y" ]; then 
        echo "Continuing with the script..."
else
        exit;
fi

#Partitioning hard disk and mounting partition to lfs
sudo ${script_path}/partition_and_mount.sh

#Getting packages for lfs and populating file system
sudo ${script_path}/getting_packages.sh

#Adding lfs user
sudo groupadd lfs
sudo useradd -s /bin/bash -g lfs -m -k /dev/null lfs

echo "Set your password for lfs group:"
sudo passwd lfs

sleep 5

sudo chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
x86_64) sudo chown -v lfs $LFS/lib64 ;;
esac

su - lfs

