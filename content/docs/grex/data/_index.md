---
title: "Storage and Data"
bookCollapseSection: true
weight: 30
---

# General Storage Information

As of now, the storage system of Grex consists of the following:

- The **/home** NFSv4 filesystem is served by a very fast NVME disk server. The total size of the filesystem is 15TB. The quota per-user is 100 GB of space and 500K of files. 

- The **/global/scratch** Lustre filesystem, Seagate SBB, total usable size of 418 TB. It is intended to be used as the high-performance, scalable workspace for active projects. It is not backed up and is not intended for long-time storage of users data that is not actively used. The default quota is 2 TB of space and 1M files per user and can be increased on request to 10 TB per research group. Larger disk space requires a local RAC application.

- The local node storage as defined by the environment variable $TMPDIR is recommended for temporary job data that is not needed after job completes. Grex nodes have SATA local disks of various capacities, leaving 150 Gb, 400 Gb, 800 Gb and 1700 Gb usable space per node, depending of the kind of local disk it has.

Most user would want to use */home* for code development, source code, scripts, visualization, processed data etc., that do not take much space and benefits for small files I/O. For production data processing, that is, massive I/O tasks from many compute or interactive jobs, */global/scratch* should be used. It is often beneficial to place temporary files on the local disk space of the compute nodes, if space permits, so that the jobs do not load Lustre or NFS extensively.

## Data retention and Backup

Data retention policy as of now conforms to the corresponding Compute Canada policy. Namely, the data will not be kept on Grex indefinitely after user's account is expired. The data retention period for expired accounts is 1 year. Note that we do not do regular, short term data purges for */global/scratch* filesystem. However, data on login and compute nodes local scratch gets purged regularly and automatically.

Backup: after migration to new /home, the backup temporarily lapsed. There is no backup on any of Grex filsystems now. We are working on resuming the backup.

## Data sharing

Sharing of accounts login information (like passwords or SSH keys) is stricty forbidden on Grex, as well as on most of the HPC systems. There is a mechanism of data/file sharing that does not require sharing of the accounts. 
To access each others' data on Grex, the UNIX groups and permissions mechanism can be used as explined here(Link).

## Disclaimer of any responsibility for Data loss

Every effort is made to design and maintain Grex storage systems in a way that they are a reliable store for researcher's data. However, we (Grex Team, or the University) make no guarantees that any data can be recovered, regardless of where they are stored, even in backed up volumes. Accidents happen, whether caused by human error, hardware or software errors, natural disasters, or any other reason. It is the user's responsibility that the data is protected against possible risks, as appropriate to the value of the data. 


