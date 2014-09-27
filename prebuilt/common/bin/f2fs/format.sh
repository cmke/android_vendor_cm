#!/sbin/sh

# format partition as f2fs if is mounted otherwise as ext4
mount | grep -q $1' type f2fs'
F2FS=$?

if [ $F2FS -eq 0 ]; then
    mkfs.f2fs /dev/block/platform/msm_sdcc.1/by-name$1
elif [ $F2FS != 0 ]; then
    mkfs.ext4 /dev/block/platform/msm_sdcc.1/by-name$1
fi
