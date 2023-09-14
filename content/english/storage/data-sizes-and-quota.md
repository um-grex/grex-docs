---
weight: 2000
linkTitle: "Data sizes and Quotas"
title: "Data sizes and quotas"
description: "Everything you need to know about data sizes and quota."
categories: ["Information"]
#tags: ["Configuration"]
---

## Data size and quotas
---

This section explains how to find the actual space and inode usage of your __/home/__ and __/global/scratch__ allocations on Grex. We limit the size of the data and the number of files that can be stored on these filesystems.

| File system         | Type        | Total space | Quota per user |
| -----------         | :---:       | :---------: | :------------: |
| __/home__           | NFSv4/RDMA  | **15 TB**   | 100 GB         |
| __/global/scratch__ | Lustre      | **418 TB**  | 4 TB           |
| __/project__        | Lustre      | **1 PB**    | -              |

To figure out where your current usage stands with the limit, POSIX __quota__ or Lustre's analog, __lfs quota__, commands can be used.

### NFS quota 
---

The __/home/__ filesystem is served by NFSv1 and thus supports the standard POSIX __quota__ command. For the current user, it is just:

{{< highlight bash >}}
quota
{{< /highlight >}}

or

{{< highlight bash >}}
quota -s
{{< /highlight >}}

The command will result in something like this (note the __-s__ flag added to make units human readable):

{{< highlight bash >}}
[someuser@bison ~]$ quota -s
  Disk quotas for user someuser (uid 12345):
     Filesystem  space quota limit grace files quota limit grace
192.168.24.70:/   249M  100G  105G        4953  500k 1000k       
{{< /highlight >}}

The output is a self-explanatory table. There are two values: __soft__ "quota" and __hard__ "limit" per each of (space, files) quotas. If you are over soft quota, the value of used resource (space or files) will have a star _*_ to it, and a __grace__ countdown will be shown. Getting over grace period, or over the hard limit prevents you from writing new data or creating new files on the filesystem. If you are over quota on __/home__, it is time to do some clean up there, or migrate the data-heavy items to __/global/scratch__ where they belong.

{{< alert type="warning" >}}
__CAVEAT:__ The Alliance (Compute Canada) breaks the POSIX standard by redefining the quota command in their software stack. So, after loading the __CCEnv__ module on Grex, the quota command may return garbage. For accurate output about your quota, load __GrexEnv__ first before running the command __quota__ or use the command __diskusage_report__ (see below).
{{< /alert >}}

### Lustre quota
---

The __/global/scratch/__ filesystem is actually a link to a (new) Lustre filesystem called __/sbb/__. We have retained the old name for compatibility with the old Lustre filesystem that was used on Grex between 2011 and 2017. Lustre filesystem provides a __lfs quota__ sub-command that requires the name of the filesystem specified. So, for the current user, the command to get current usage {space and number of files}, in the human-readable units, would be as follows:

{{< highlight bash >}}
lfs quota -h -u $USER /sbb
{{< /highlight >}}

With the output:

{{< highlight bash >}}
[someuser@bison ~]$ lfs quota -h -u $USER /sbb
 Disk quotas for usr someuser (uid 12345):
 Filesystem  used   quota  limit  grace   files  quota   limit  grace
      /sbb   622G  2.644T  3.653T     - 5070447 6000000 7000000     -
{{< /highlight >}}

Presently we do not enforce __group__ or __project__ quota on Grex.

If you are over quota on Lustre __/global/scratch__ filesystem, just like for NFS, there will be a star to the value exceeding the limit, and the grace countdown will be active. 

## A wrapper for quota
---

To make it easier, we have set a custom script with the same name as for the Alliance (Compute Canada) clusters, __diskusage_report__, that gives both __/home__ and __/global/scratch__ quotas (space and number of files: usage/quota or limits), as in the following example:

{{< highlight bash >}}
[someuser@bison ~]$  diskusage_report 
           Description (FS)     Space (U/Q) # of files (U/Q)
           /home (someuser)      254M/104G        4953/500k
 /global/scratch (someuser)     131G/2147G       992k/1000k
{{< /highlight >}}

for more details[^1], run the command:

[^1]: These options are not implemented on the Alliance clusters.

{{< highlight bash >}}
diskusage_report -dd -vv
{{< /highlight >}}

as in the example:

{{< highlight bash >}}
[someuser@bison ~]$ diskusage_report -dd -vv
+ Space and Inode quotas for user: someuser
+ Date: Thu Feb 24, 2022
          Description (FS)      Space (U/Q/L)   # of files(U/Q/L)
          /home (someuser)     254M/104G/110G     4953/500k/1000k
/global/scratch (someuser)    131G/2147G/3221G   992k/1000k/1100k

FS ==> File System (/home, /global/scratch)
U  ==> Current Usage (Space, Inode)        
Q  ==> Soft Quota (Space, Inode)           
L  ==> Hard Quota (Space, Inode)    
{{< /highlight >}}

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* 
*
*
-->

