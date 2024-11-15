#! /usr/bin/bash

export LFS=/mnt/lfs

sudo mkdir -v $LFS/sources
sudo chmod -v a+wt $LFS/sources

# Getting packages for lfs
wget --input-file=https://lfs.gnlug.org/pub/lfs/lfs-packages/12.2/ --continue --directory-prefix=$LFS/sources

chown root:root $LFS/sources/*

#Populating filesystem
sudo mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}
for i in bin lib sbin; do
  sudo ln -sv usr/$i $LFS/$i
done
case $(uname -m) in
  x86_64) sudo mkdir -pv $LFS/lib64 ;;
esac

sudo mkdir -pv $LFS/tools
