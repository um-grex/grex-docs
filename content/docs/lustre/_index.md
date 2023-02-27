---
weight: 1
bookFlatSection: true
title: "Grex changes: Storage and OS updates"
date: Feb 27, 2023
---

**Feb 27, 2023**

# Motivation / Scope of the outage

As announced, we have added a new storage of 1 PB on Grex. It is called “/project” filesystem. The called outage since Feb 22 was used to add this storage and connect it to a new UPS, as well as some other OS updates.

{{< hint info >}}
Start Time : 2.00 PM (Winnipeg Time), Wednesday, Feb 22, 2023

Anticipated End Time : Friday, Feb 24, 2023

The outage was extended to Monday, Feb 27 to let the electricians finish powering up the new UPS.
{{< /hint >}}

During the Grex’s outage, many changes have been made on Grex. We have rebooted and reinstalled all of Grex compute and login nodes, connected the new Project storage, and performed some re-cabling of the Infiniband fabric of the cluster. The data was migrated from scratch to the new project {with some exceptions as listed below}. The jobs that were still running by the time of the outage were lost, and Grex login nodes were not available during the outage window.

# Main changes:

## Queued jobs: 

To be able to work on lustre during the planned outage, we have:

{{< hint info >}}
 Killed all jobs {running} to have a quite lustre file system for data migration.

 We kept the pending jobs on hold [JobHeldAdmin] that will start once grex is online. However, most of them will fail because we moved all the data from scratch to a new storage project {see below for more information}
{{< /hint >}}

## Compute and login nodes:

* Rebooted and re-installed all login nodes.
* Rebooted and re-installed all compute nodes from a new image that fixes the errors with UCX and OpenMPI encountered when running some large jobs. 

## Project file system

### Type of the storage

{{< hint info >}}
A new file system called project was attached to Grex. The storage is hybrid, that is, consisting of spinning hard drive disks for the bulk of its data, with metadata and fast data served by solid state NVMe storage. 
{{< /hint >}}

### Structure of the storage

{{< hint info >}}
Similarly to Compute Canada (the Alliance) clusters, there is now a new directory “projects” under the home directory for each user. It has symlinks to user’s projects. For example, a user who is sponsored  by two PIs (professor1 and professor2) will have two links: projects/def-professor1 and projects/def-professor2

What will change is also the layout of user data and the way we handle users' storage quota. We will follow a similar /project layout to Compute Canada (Alliance) systems: each research group will have its own project directory, with a project quota assigned for it summarily; each group member will then have a subdirectory there. Each project directory will be named by the project’s group identifier in CCDB. For example,

/project/601234 is a project directory for def-professor1 and 
/project/601234/USER1 is a user directory for that project. 

To make finding and organizing the project directories easier, we create two sets of links to these directories: per Faculty and per user. Per-faculty links are collected for groups that belong to a Faculty under /project/Faculty-name. Faculties are abbreviated for easy handling (i.e., /project/Sci and /project/Eng are for Science and engineering correspondingly). Note that users taking part in more collaboration across research groups or faculties, will end up having more than one project space.  

A user (USER1) sponsored by a Faculty member (professor1) from Science, his project is to be found under “/project/Sci”

/project/Sci/def-professor1 (is a link to /project/601234). 
/project/Sci/def-professor1/USER1 is the user directory.

Under home directories, each user will have a /home/USER/projects/ directory with links to each of his /project spaces.  For the above example user, /home/USER1/projects/def-professor1 will be the link in home directory, and /home/USER1/projects/def-professor1/USER1/ is his user’s directory on that project.

Note that all the links mentioned above point to the same “real” location on the filesystem, and are subject to the same quota limits. The default quota will be 5TB (expandable to 10TB on request) and 2M files per project. There is also 1M files per user default quota limit. A larger allocation will be available for members of the Faculties (Science and Engineering) that contributed to the purchase of the new storage, through Grex local Resource Allocation Call.

In the coming days, a script “diskusage_report” will be customized to show the quota under project. As for now, it shows only home and scratch.

{{< /hint >}}

## scratch file system

* The data from /global/scratch was migrated to a new storage called project. Please do not panic if you do not see your data under scratch but it should be under project. We still have not migrated some users who have more than 1 project since we do not know to which project the data belong to. The users have been contacted and we will proceed case by case when they answer.
* Since the data was moved from your scratch to new project, please expect to find an emty "/global/scratch/USERNAME" directory.

## Backups

* Even if we now have the same structure for the file system as on Compute Canada, please be advised that we do not have any backup system at this time.

## What to do?

{{< hint info >}}
Inspect your previous jobs and re-submit them if needed.

If you have compiled your program locally, you may have to re-compile again if it is still giving errors with UCX and OpenMPI. If you get similar errors from the existing modules, please get in touch with us so we can re-compile them and fix the errors.

If you are working with more than one sponsor, you may have to go through your data and copy the files according to the project they belong to as now the quota may . 
{{< /hint >}}

Thank you for your patience and thank you for your attention to this message! 
In case you have further questions, check out our FAQ entry (link, TBD).
In case you have further questions, check out our contact us at support@tech.alliancecan.ca 

## Frequently asked questions (to be added on docs page, and referenced from MOTD):

### **Q: What happens to the old /home storage?**

{{< hint info >}}
**A:** It stays as it is now. /home/USER/projects directory will be created and filled with the links to project directories
{{< /hint >}}

### **Q: What happens to my data on /global/scratch?**

{{< hint info >}}
**A:** The data will be migrated to the /project space of each user, and then purged off /global/scratch. The /project space has links to it, from users’ home directories under /home/USER/projects/def-PI/user. Members of more than one group (i.e., collaborations between two or more PIs) will now have more than one project space. We will contact the groups that involve such collaborations individually.
{{< /hint >}}

### **Q: what happens to my data sharing settings on /global/scratch?**

{{< hint info >}}
**A:** Data sharing looks different on /project because of different directory structure. So the data sharing that used to be between users and groups on /global /scratch will have to be re-created. Please contact us to tell us how to set up your data sharing. 
{{< /hint >}}

### **Q: What happens to the /global/scratch filesystem? There still is 418 TB of space, and it still works?**

{{< hint info >}}
**A:** It will be purged, reinstalled to an updated version of the filesystem. We will keep the space as a temporary, scratch filesystem for as long as we can support its hardware and software. We will purge it periodically of old and long unused files, similar to ComputeCanada’s policy, to prevent permanent storage of files on a best-effort storage. 
{{< /hint >}}

### **Q: I assume there is some backup on the new /project like on ComputeCanada /project?**

{{< hint info >}}
**A:** No, there is no backup on Grex. Due to large volumes of data, we cannot backup them at this time on any University resources available to us.
{{< /hint >}}

<!-- Docs to Markdown version 1.0β17 -->
