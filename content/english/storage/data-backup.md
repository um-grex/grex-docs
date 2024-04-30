---
weight: 3900
linkTitle: "Data Backup"
title: "Data Backup"
description: "Information about user data backup on Grex."
categories: ["Information"]
banner: true
bannerContent: "Work in progress."
draft: false
#tags: ["Configuration"]
---

## Backup policies
---

Since late 2023, there has been a tape backup for user data stored on main Grex filesystems, __/home__ and __/project__. Our limited resources and large amounts of data do put some limitations on what and how fast can be backed up and restored. All backup is done to tape in the same HPCC data centre.

The __/home__ filesystem is backed up daily using incremental backup. A new full backup is done quarterly.

We aim for the __/project__ filesystem to have a monthly backup, with a full backup done quarterly. However, due to the large amounts of data, the backup for particularly active projects having larger file counts and/or large amounts of data can be delayed past one month.

Retention of the data on tape is determined by our available tape space. Generally, there is a month's worth of retained data on __/project__ and three months on __/home__.


## Restoring your data from backup
---

Restoring data from tape backup requires a Sysadmin intervention.  

On __/project__ it may take more time if the request happens during the time of the full backup happening (in January, April, July, October). 

Please send us a [support](/support) request to restore your data from the tape backup if needed.

## Disclaimer of responsibility despite Backup
---

Any electronic or mechanical system can fail. The tape system is located in the same data centre as the storage is backed up. So, while backup we have added a level of data protection against system failures and user errors, __it is by no means absolute__.

Users are encouraged to search and adopt data preservation strategies for their research data that is particularly important to them (for example, a set of data that is unique and cannot be easily re-generated). One of the popular strategies is the 3+2+1: It usually is understood as keeping at least 3 copies of your data, on at least 2 storage locations, and at least 1 copy off-site.

---

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Apr 29, 2024.
-->
