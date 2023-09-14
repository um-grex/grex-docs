---
weight: 4500
linkTitle: "Storage and Data"
title: "Storage and Data"
description: "All you need to know about storage on Grex."
titleIcon: "fa-solid fa-house-chimney"
#categories: ["How-To", "Information"]
#tags: ["Content management"]
---

## General Storage Information
---

As of now, the storage system of Grex consists of the following:

- The **/home** NFSv4/RDMA filesystem is served by a very fast NVME disk server. The total size of the filesystem is __15 TB__. The quota per-user is __100 GB__ of space and __500K__ files. 

- The **/global/scratch** Lustre filesystem, Seagate SBB, total usable size of **418 TB**. It is intended to be used as the high-performance, scalable workspace for active projects. It is not backed up and is not intended for long-time storage of users' data that is not actively used. The default quota is **4 TB** of space and **1 M** files per user and can be increased on request to **10 TB** per research group. Larger disk space requires a local RAC application.

- The **/project** Lustre filesystem: ias of Sep 2022, an additional storage of **1 PB** was added to Grex. There is no backup and it is allocated per group.

<!--
- The **/project**: a project file system is in the process of installation on Grex. More information will be available in time.
-->

| File system         | Type       | Total space | Quota/User | Number of files |
| :---------:         | :--:       | :---------: | :--------: | :-------------: |
| __/home__           | NFSv4/RDMA | **15 TB**   | 100 GB     | 500 K           |
| __/global/scratch__ | Lustre     | **418 TB**  | 4 TB       | 1 M             |
| __/project__        | Lustre     | **1 PB**    | -          | -               |

- The [local node storage](running-jobs/using-localdisks) as defined by the environment variable __$TMPDIR__ is recommended for temporary job data that is not needed after job completes. Grex nodes have SATA local disks of various capacities, leaving 150 Gb, 400 Gb, 800 Gb and 1700 Gb usable space per node, depending on the kind of local disk it has.

Most users would want to use **/home/USERNAME** for code development, source code, scripts, visualization, processed data, ... etc., that do not take much space and benefits for small files I/O. For production data processing, that is, massive I/O tasks from many compute or interactive jobs, __/global/scratch/USERNAME__ should be used. It is often beneficial to place temporary files on the local disk space of the compute nodes, if space permits, so that the jobs do not load Lustre or NFS servers extensively.

## Data retention and Backup
---

Data retention policy as of now conforms to the corresponding of the Alliance (former Compute Canada) policy. Namely, the data will not be kept on Grex indefinitely after the user's account has expired. The data retention period for expired accounts is 1 year. Note that we do not do regular, short term data purges for __/global/scratch__ filesystem. However, data on login and compute nodes local scratch gets purged regularly and automatically.

{{< alert type="warning" >}}
**Backup:** after migration to new __/home__, the backup temporarily lapsed. There is no backup on any of the Grex filesystems now. We are working on resuming the backup.
{{< /alert >}}

## Data sharing
---

Sharing of accounts login information (like passwords or SSH keys) is strictly forbidden on Grex, as well as on most of the HPC systems. There is a mechanism of data/file sharing that does not require sharing of the accounts. To access each other's data on Grex, the UNIX groups and permissions mechanism can be used. For more information, please refer to the section [sharing data](storage/data-sharing).

## Disclaimer of any responsibility for Data loss
---

> Every effort is made to design and maintain Grex storage systems in a way that they are a reliable storage for researcher's data. However, we (Grex Team, or the University) make no guarantees that any data can be recovered, regardless of where they are stored, even in backed up volumes. Accidents happen, whether caused by human error, hardware or software errors, natural disasters, or any other reason. It is the user's responsibility that the data is protected against possible risks, as appropriate to the value of the data. 

## Internal links
---
 
{{< treeview />}}

---

<!-- Changes and update:
* 
*
*
-->
