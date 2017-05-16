lvs

umount /vol1

# “resize2fs” required to check the filesystem consistency before reduce the FS.

e2fsck -f /dev/mapper/vol

resize2fs /dev/uavg/lvol0 100M

# deactivate volume
lvchange -an /dev/uavg/lvol0

# 5.Reduce the volume. “-L” – Final size of the volume.
Here i am giving volume final size as 104MB. So that  volume may have some room and  won’t touch the filesystem part.The extra 4MB can be recovered using resize2fs. Its up to you how you want to proceed.
Note:You can also give 100MB. For safer side, its better to give some extra space on the volume level.
Having good backup is recommeded before proceeding to volume resize. 

lvreduce -L 104M /dev/uavg/lvol0

```
[root@mylinz ~]# lvchange -ay /dev/uavg/lvol0
[root@mylinz ~]# mount -t ext4 /dev/uavg/lvol0 /vol1
[root@mylinz ~]# df -h /vol1
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/uavg-lvol0
                       97M  5.6M   87M   6% /vol1
[root@mylinz ~]#
```
