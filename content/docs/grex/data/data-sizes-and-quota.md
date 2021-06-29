# Data sizes and quotas

This section explains how to find the actual use of your _/home/_ and _/global/scratch_ allocations on Grex.
We limit the size of the data and the number of files that can be stored on these filesystem. To figure
out where your current usage stands with the limit,  POSIX _quota_ or Lustres' analog, _lfs quota_ commands can be used.

## NFS quota

The _/home/ filesystem is served by NFS and thus supports the standard POSIX _quota_ command. For the current user it is just:

```quota```

The command will result in something like this (note the _-s_ flag added to make units human readable:

```

[auser@grex ~]$ quota -s
Disk quotas for user auser (uid 12345):
     Filesystem   space   quota   limit   grace   files   quota   limit   grace
     192.168.0.1:/exports/home/home
                        4G   30G   33G             131k    500k   550k
```

The output is a self explanatory table. There is two values: soft "quota" and hard "limit" per each of (space, files). 
If you are over soft quota, the value of used resource (space or files) will have  a star **\*** to it, and "grace" countdown will be shown.
Getting over grace period, or over the hard limit prevents you to writing new data or creating new file on the filesystem.
If you are over quota on _/home/_ it is time to do some clean up there, or migrate the data-heavy items to _/global/scratch_ where they belong.

CAVEAT: ComputeCanada breaks the POSIX standard by redefining the quota command in their software stack.
So after loading the _CCEnv_ module on Grex, the quota command will return garbage. Load _GrexEnv_ first.

## Lustre quota

The _/global/scratch/_ filesystem is actually a link to a (new) Lustre filesystem _/sbb/_. 
We have retained the old name for compatibility with the old Lustre filesystem that was used on Grex between 2011 and 2017.
Lustre filesystem provides a _lfs quota_ subcommand that requires the name of the filesystem specified. So for the current user, the command to
get current usage, in the human-readable units, would be as follows:

```lfs quota -h /sbb/```

With the output:

```
[auser@grex ~]$ lfs quota -h /sbb
Disk quotas for usr auser (uid 12345):
     Filesystem    used   quota   limit   grace   files   quota   limit   grace
           /sbb    622G  2.644T  3.653T       - 5070447  6000000 7000000       -
```

Presently we do not enforce group or project quota on Grex.

If you are over quota on Lustre _/global/scratch_ filesystem, just like for NFS, there will be a star to the value exceeding the limit, and
the grace countdown will be active. 
