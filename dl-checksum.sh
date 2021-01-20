#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/weaveworks/eksctl/releases/download
APP=eksctl

dl()
{
    local ver=$1
    local lchecksums=$2
    local os=$3
    local arch=$4
    local archive_type=${5:-tar.gz}
    local platform="${os}_${arch}"
    local file=${APP}_${platform}.${archive_type}
    local url=$MIRROR/$ver/$file
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform `fgrep $file $lchecksums | awk '{print $1}'`
}

dl_ver()
{
    local ver=$1
    local lchecksums=$DIR/${APP}_${ver}_checksums.txt
    local rchecksums=$MIRROR/$ver/${APP}_checksums.txt
    if [ ! -e $lchecksums ];
    then
        wget -q -O $lchecksums $rchecksums
    fi

    printf "  # %s\n" $rchecksums
    printf "  '%s':\n" $ver

    dl $ver $lchecksums Darwin amd64
    dl $ver $lchecksums Linux amd64
    dl $ver $lchecksums Windows amd64 zip
}

dl_ver ${1:-0.36.1}
