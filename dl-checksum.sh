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
    # https://github.com/weaveworks/eksctl/releases/download/v0.66.0/eksctl_checksums.txt
    local lchecksums=$DIR/${APP}_${ver}_checksums.txt
    local rchecksums=$MIRROR/$ver/${APP}_checksums.txt
    if [ ! -e $lchecksums ];
    then
        curl -sSLf -o $lchecksums $rchecksums
    fi

    printf "  # %s\n" $rchecksums
    printf "  %s:\n" $ver

    dl $ver $lchecksums Darwin amd64
    dl $ver $lchecksums Darwin arm64
    dl $ver $lchecksums Linux amd64
    dl $ver $lchecksums Linux armv6
    dl $ver $lchecksums Linux armv7
    dl $ver $lchecksums Linux arm64
    dl $ver $lchecksums Windows amd64 zip
    dl $ver $lchecksums Windows armv6 zip
    dl $ver $lchecksums Windows armv7 zip
    dl $ver $lchecksums Windows arm64 zip
}


dl_ver ${1:-v0.106.0}
