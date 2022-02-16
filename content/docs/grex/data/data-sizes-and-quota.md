# Data sizes and quotas

This section explains how to find the actual use of your __/home/__ and __/global/scratch__ allocations on Grex. We limit the size of the data and the number of files that can be stored on these filesystems. To figure out where your current usage stands with the limit, POSIX __quota__ or Lustres' analog, __lfs quota__ commands can be used.

## NFS quota

The __/home/__ filesystem is served by NFSv1 and thus supports the standard POSIX __quota__ command. For the current user, it is just

{{< hint info >}}
```quota```
{{< /hint >}}

The command will result in something like this (note the __-s__ flag added to make units human readable:

{{< hint info >}}
```
[someuser@grex ~]$ quota -s
  Disk quotas for user auser (uid 12345):
  Filesystem   space   quota   limit   grace   files   quota   limit   grace
  192.168.0.1:/exports/home/home
                     4G   30G   33G             131k    500k   550k
```
{{< /hint >}}

The output is a self explanatory table. There are two values: __soft__ "quota" and __hard__ "limit" per each of (space, files). If you are over soft quota, the value of used resource (space or files) will have a star **\*** to it, and __grace__ countdown will be shown. Getting over grace period, or over the hard limit prevents you from writing new data or creating new file on the filesystem. If you are over quota on __/home/__, it is time to do some clean up there, or migrate the data-heavy items to __/global/scratch__ where they belong.

__CAVEAT:__ Compute Canada breaks the POSIX standard by redefining the quota command in their software stack. So after loading the __CCEnv__ module on Grex, the quota command may return garbage. For accurate output about your quota, load __GrexEnv__ first before running the command __quota__.

## Lustre quota

The __/global/scratch/__ filesystem is actually a link to a (new) Lustre filesystem called __/sbb/__. We have retained the old name for compatibility with the old Lustre filesystem that was used on Grex between 2011 and 2017. Lustre filesystem provides a __lfs quota__ sub-command that requires the name of the filesystem specified. So for the current user, the command to get current usage {space and number of files}, in the human-readable units, would be as follows:

{{< hint info >}}
```lfs quota -h /sbb/```
{{< /hint >}}

With the output:

{{< hint info >}}
```
[someuser@bison ~]$ lfs quota -h /sbb
 Disk quotas for usr auser (uid 12345):
 Filesystem    used   quota   limit   grace   files   quota   limit   grace
      /sbb    622G  2.644T  3.653T       - 5070447  6000000 7000000       -
```
{{< /hint >}}

Presently we do not enforce group or project quota on Grex.

If you are over quota on Lustre __/global/scratch__ filesystem, just like for NFS, there will be a star to the value exceeding the limit, and the grace countdown will be active. 

To make it easier, we have set a custom script with the same name as for Compute Canada, __diskusage_report__, that gives both __/home__ and __/global/scratch__ quotas (space and number of files: usage/quota or limits), as in the following example:

{{< hint info >}}
```
[someuser@bison ~]$  diskusage_report 
                Description (FS)        Space (U/Q)   # of files (U/Q)
                /home (someuser)          254M/104G          4953/500k
      /global/scratch (someuser)         131G/2147G         992k/1000k
```
{{< /hint >}}


