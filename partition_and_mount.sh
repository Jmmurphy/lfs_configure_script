
function provide_disk_path(){
    read -p "Enter the hard disk path: " hard_disk
    read -p "Is the path correct? (y/n): " valid

    if [ "$valid" == "y" ]; then 
        # Return the disk path to the caller
        echo "$hard_disk"; return 0;
    else
        # Retry until the correct path is provided and capture the result
        provide_disk_path
    fi
}

function partition_disk(){
    disk_path=$1
    command="cfdisk ${disk_path}"
    echo "This is the command: $command"
    eval "$command"
    sleep 1 
    lsblk

    echo "Is the partition correct? (y/n): "
    read valid

    if [ "$valid" == "y" ]; then 
        return  
    else
        # Retry partitioning the disk
        partition_disk "$disk_path"
    fi
}

# Get the disk path by calling provide_disk_path and pass it to partition_disk
disk_path=$(provide_disk_path)
partition_disk "$disk_path"

lsblk
echo "Get partition for lfs:"
read fs

mkfs -v -t ext4 "$fs"

export LFS=/mnt/lfs

mkdir -pv $LFS
mount -v -t ext4 "$fs" $LFS
