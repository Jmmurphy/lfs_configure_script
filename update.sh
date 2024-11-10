#! /usr/bin/bash

bail() { echo "FATAL: $1"; exit 1; }
grep --version > /dev/null 2> /dev/null || bail "grep does not work"
sed '' /dev/null || bail "sed does not work"
sort /dev/null || bail "sort does not work"

ver_update()
{
        if ! type -p $2 &>/dev/null
        then
                echo "ERROR: Cannot find $2 ($1)";
                echo "Installing $2..."
                if [ "$2" == "texi2any" ]; then
                        sudo apt-get install -y texinfo
                else
                        sudo apt-get install -y "$2"
                fi

                if ! type -p "$2" &>/dev/null; then
                        echo "ERROR: Failed to install $2"
                        return 1
                fi
        fi
        v=$($2 --version 2>&1 | grep -E -o '[0-9]+\.[0-9\.]+[a-z]*' | head -n1)
        if printf '%s\n' $3 $v | sort --version-sort --check &>/dev/null
	then
                return 0;
        else
                printf "ERROR: %-9s is TOO OLD ($3 or later required)\n" "$1";
                echo "Updating $2..."
                sudo apt install --only-upgrade -y "$2"
                return 1;
        fi
}

ver_update Coreutils sort 8.1 || bail "Coreutils too old, stop"
ver_update Bash bash 3.2
ver_update Binutils ld 2.13.1
ver_update Bison bison 2.7
ver_update Diffutils diff 2.8.1
ver_update Findutils find 4.2.31
ver_update Gawk gawk 4.0.1
ver_update GCC gcc 5.2
ver_update "GCC (C++)" g++ 5.2
ver_update Grep grep 2.5.1a
ver_update Gzip gzip 1.3.12
ver_update M4 m4 1.4.10
ver_update Make make 4.0
ver_update Patch patch 2.5.4
ver_update Perl perl 5.8.8
ver_update Python python3 3.4
ver_update Sed sed 4.1.5
ver_update Tar tar 1.22
ver_update Texinfo texi2any 5.0
ver_update Xz xz 5.0.0
