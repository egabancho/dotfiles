# Raspberry Pi 3 B CentOS 7.5 macos installation

First get the image from http://mirror.centos.org/altarch/7/isos/armhfp/ and
unxz.
```
wget http://mirror.centos.org/altarch/7/isos/armhfp/CentOS-Userland-7-armv7hl-RaspberryPI-Minimal-1804-sda.raw.xz
unxz CentOS-Userland-7-armv7hl-RaspberryPI-Minimal-1804-sda.raw.xz
```

We need to discover which one is the device of the SD card using `diskutil
list`, in this case `/dev/disk2s1`

Clean up the SD card just in case

```
sudo diskutil partitionDisk /dev/disk2 1 MBR "Free Space" "%noformat%" 100%
```

Write the image to the SD card

```
sudo dd bs=1m if=CentOS-Userland-7-armv7hl-RaspberryPI-Minimal-1804-sda.raw of=/dev/rdisk2 conv=sync
```

And extract the SD! `sudo diskutil eject /dev/rdisk2`

To discover the IP address of the raspberry pi and SSH we can use `arp`. All
raspberry devices MAC addresses start with `B8:27:EB`. 

```
arp -na | grep -i b8:27:eb
```

SSH should be possible after a few second using user : "root" with pass:
"centos".


## Increase the root partition to cover the whole disk

You should start with something like:

```
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       1.4G  1.1G  294M  79% /
devtmpfs        460M     0  460M   0% /dev
tmpfs           464M     0  464M   0% /dev/shm
tmpfs           464M   12M  452M   3% /run
tmpfs           464M     0  464M   0% /sys/fs/cgroup
/dev/mmcblk0p1  667M   44M  624M   7% /boot
tmpfs            93M     0   93M   0% /run/user/0
```

Why? Because when doing `dd` over a disk image to a larger disk image, your
partition table changes to that of the disk image.  This means you won’t be able
to use the full allotted space of your SD card without resizing things.  

This should work

```
$ touch /.rootfs-repartition
$ systemctl reboot
```

But it doesn't, so we go for the old fashion way.

```
$ lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
mmcblk0     179:0    0   29G  0 disk
├─mmcblk0p2 179:2    0  488M  0 part [SWAP]
├─mmcblk0p3 179:3    0  1.4G  0 part /
└─mmcblk0p1 179:1    0  668M  0 part /boot
```

The partition we want to increase if the third one.

Run `fdisk /dev/mmcblk0`. Issue `p` to print your current partition table and
copy that output to some safe place. 
```
Command (m for help): p

Disk /dev/mmcblk0: 31.1 GB, 31104958464 bytes, 60751872 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x0008a224

        Device Boot      Start         End      Blocks   Id  System
/dev/mmcblk0p1   *        2048     1370111      684032    c  W95 FAT32 (LBA)
/dev/mmcblk0p2         1370112     2369535      499712   82  Linux swap / Solaris
/dev/mmcblk0p3         2369536     5298175     1464320   83  Linux
```
Now issue `d` followed by `3` to remove the second partition. 
Issue `n`` to create a new second partition. 
Make sure the start equals the start of the partition table you printed earlier. 
Make sure the end is at the end of the disk (usually the default).

Issue `t` followed by `2` followed by `83` to toggle the partition type of your
new second partition to 83 (Linux).

Issue `p` to review your new partition layout and make sure the start of the new
third partition is exactly where the old second partition was.

```
Command (m for help): p

Disk /dev/mmcblk0: 31.1 GB, 31104958464 bytes, 60751872 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x0008a224

        Device Boot      Start         End      Blocks   Id  System
/dev/mmcblk0p1   *        2048     1370111      684032    c  W95 FAT32 (LBA)
/dev/mmcblk0p2         1370112     2369535      499712   82  Linux swap / Solaris
/dev/mmcblk0p3         2369536    60751871    29191168   83  Linux
```

If everything looks right, issue `w` to write the partition table to disk. 
You will get an error message from partprobe that the partition table couldn't
be reread (because the disk is in use).

```
Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 16: Device or resource busy.
The kernel still uses the old table. The new table will be used at
the next reboot or after you run partprobe(8) or kpartx(8)
Syncing disks.
```

Now reboot the system `systemctl reboot` and once you're back run `resize2fs
/dev/mmcblk0p3`.

```
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       1.4G  1.1G  280M  80% /
devtmpfs        460M     0  460M   0% /dev
tmpfs           464M     0  464M   0% /dev/shm
tmpfs           464M   12M  452M   3% /run
tmpfs           464M     0  464M   0% /sys/fs/cgroup
/dev/mmcblk0p1  667M   44M  624M   7% /boot
tmpfs            93M     0   93M   0% /run/user/0
[root@localhost ~]# resize2fs /dev/mmcblk0p3
resize2fs 1.42.9 (28-Dec-2013)
Filesystem at /dev/mmcblk0p3 is mounted on /; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 4
The filesystem on /dev/mmcblk0p3 is now 7297792 blocks long.
```

Reboot again and everything should be the way it's supposed to be.

```
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        28G  1.1G   27G   4% /
devtmpfs        460M     0  460M   0% /dev
tmpfs           464M     0  464M   0% /dev/shm
tmpfs           464M   12M  452M   3% /run
tmpfs           464M     0  464M   0% /sys/fs/cgroup
/dev/mmcblk0p1  667M   44M  624M   7% /boot
tmpfs            93M     0   93M   0% /run/user/0
```

The real magic here is that you delete the root, then recreate it (using the
original start sector) before writing the data to the disk. As a result you
don't erase the existing data from the root partition.
