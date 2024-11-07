---
weight: 4000
linkTitle: "Data sharing"
title: "Data sharing"
description: "Everything you need to know about sharing data on Grex."
categories: ["Information"]
#banner: true
#bannerContent: "Work in progress."
tags: ["Configuration", "Storage"]
---

## Data Sharing
---

By default, data on Grex are owned by the user and are not accessible to other Grex users or to external parties.

In research it’s often necessary to share datasets or code within a research group or with collaborating groups. This documentation explains how to share data stored on a specific HPC system, in this case, Grex. Sharing data outside the HPC system can be done through other methods, such as Globus or MS OneDrive.

{{< alert type="warning" >}}
* __How to not share data:__ Sharing account credentials is strictly forbidden. Similarly, making data "world-accessible" (open to all users) is discouraged.
{{< /alert >}}

> * Sharing account login information (like passwords or SSH keys) is strictly prohibited on Grex and most other HPC systems.
> * Making a directory universally accessible—especially with write permissions (e.g., using the Linux/Unix +rwx or 777 file mode)—is risky, as it allows anyone on the system to not only read but potentially delete the entire directory.

There is a secure mechanism for data sharing that doesn’t involve sharing account credentials. To access each other’s data on Grex, you should use UNIX groups and permissions, or ideally, Access Control Lists (ACLs) for more granular control over data access permissions.

## UNIX Groups and File Ownership
---

First, let’s review how permissions work on a Linux system.

Each UNIX (or Linux) filesystem object (such as a file or directory) is owned by an individual user (the owner) and a group (which may include multiple users). Access permissions can be set for the owner, the group, and "others" (all other users on the system). You can view ownership and permissions for objects in the current directory with the command ```ls -la```.

Depending on the filesystem (e.g., __/project__, __/home__, or, on Alliance systems, __/scratch__), group ownership is assigned either to the user’s personal group or to the Principal Investigator’s (PI's) group. For example, on /home, where users own their data, the listing might look like this:

{{< highlight bash >}}
[someuser@yak Data]$ ls -la
total 328408
drwxrwxr-x  2 someuser someuser        75 Aug  9  2023 .
drwxrwxr-x 25 someuser someuser      4096 Oct 18 10:46 ..
-rw-r--r--  1 someuser someuser  64479232 Aug  9  2023 file.txt
-rw-r--r--  1 someuser someuser 271805449 Aug  9  2023 Calgary_Adult_Skull_Atlas.mnc
{{< /highlight >}}

On __/project__, where a group-based hierarchy exists, ls will show group ownership assigned to the PI’s default allocation group, as follows:

{{< highlight bash >}}
someuser@yak Data]$ ls -la
total 328420
drwxrwsr-x 3 someuser def-somePI      4096 Oct 21 14:43 .
drwxrwsr-x 3 someuser def-somePI      4096 Oct 21 14:35 ..
-rw-r--r-- 1 someuser def-somePI   64479232 Oct 21 14:35 file.txt
-rw-r--r-- 1 someuser def-somePI  271805449 Oct 21 14:35 Calgary_Adult_Skull_Atlas.mnc
drwxrwsr-x 2 someuser def-somePI       4096 Oct 21 14:43 Docker
{{< /highlight >}}

In UNIX/Linux, permissions are associated with group ownership. To adjust access, you need to change both ownership and permissions. You can override defaults using the ```chmod``` command to modify file permissions, and ```chown``` or ```chgrp``` to change owner and group, respectively. This assumes the required group (or user) already exists on the system.

Sharing within the PI’s group is straightforward using ```chgrp``` and ```chmod``` with the __def-somePI__ group. These __def-somePI__ groups are automatically created based on CCDB group memberships and are available for each group on Grex, forming the directory structure on the __/project__ filesystem. To make a directory accessible to a group, a user can modify ownership masks as follows:

{{< highlight bash >}}
# Allow read, write, and search access for all members of the def-somePI group.

chmod g+rwX Calgary_Adult_Skull_Atlas.mnc Docker
{{< /highlight >}}

In some cases, you may need more precise control over access—perhaps only a subset of the PI’s group should access a dataset, or you need to grant access to users from multiple research groups (more than one PI). In such cases, a new UNIX group is required. Grex and Alliance systems receive group and user information from the CCDB. Thus, the group must be requested by the PI. 

### Requesting a Data-sharing Group

A Principal Investigator (PI) can request the creation of a special UNIX group to facilitate data sharing with other researchers. To set up a group, the PI should email support at support@tech.alliancecan.ca, including a list of users to be added to the group. Please designate one user as the authority/manager for the group. If someone requests to join the group later, we will ask the designated authority for approval before adding the new member.

The group name should follow the format wg-xxxxx, where xxxxx represents up to five characters. Indicate your preferred group name in the email.

The group will be set up on the Grex system, which may take a day or two. You will receive an email notification whenever you are added to or removed from a UNIX group. Once your wg-xxxxx UNIX group is created, data sharing permissions can be configured using either chown / chmod commands or Linux Access Control Lists (ACLs), as described below.

To share a directory with the group, set group ownership and permissions on the directory. For example:

{{< highlight bash >}}
chgrp -R wg-group ./dirname
chmod g+s ./dirname
{{< /highlight >}}

> Ensure that the parent directories also have the minimally necessary permissions (the search permission __X__) to allow access. 

To grant read and access permissions to all files in a directory, use the following:

{{< highlight bash >}}
chmod -R g+rX ./dirname
{{< /highlight >}}

The uppercase __X__ in this command sets execute permissions on subdirectories (allowing group members to list contents) and on executable files.

If group members need both read and write access in the shared directory (to create and modify files), each member should add the following line to their __~/.bashrc__ or __~/.cshrc__ file:

```umask 007```

to the __~/.bashrc__ or __~/.cshrc__ file in their respective home directories. Furthermore, you must add write permission to the shared directory itself:

{{< highlight bash >}}
chmod -R g+rwX dirname
{{< /highlight >}}

which would allow read and write access to the directory dir and all its files and subdirectories.

## Linux ACLs
---

On most modern Linux filesystems, such as Lustre FS used for Grex’s __/project__, Linux Access Control Lists (ACLs) provide more fine-grained access control than traditional UNIX groups. ACLs allow flexible permissions by decoupling file ownership from access rights, enabling access control for multiple users or groups without changing file ownership. This flexibility makes ACLs the preferred method for organizing data sharing.

The Alliance’s [Sharing Data](https://docs.alliancecan.ca/wiki/Sharing_data "Sharing data")a documentation describes using ACLs, and Grex’s /project filesystem has a similar hierarchical structure. Grex’s __/home__ uses a NFSv4 FS, which has its own ACL syntax, not compatible with Linux ACLs. Generally, data sharing is recommended under __/project__, while $HOME remains private to each user.

Two main commands control ACLs on files and directories:

 * ```getfacl```: displays the current ACL settings.
 * ```setfacl```: modifies ACL settings.

The access modes are similar to ```chmod```'s symbolic codes:

 * ```r``` for read
 * ```w``` for write
 * ```X``` for execute/search permissions on directories

Since ACLs are independent of file ownership, they allow setting permissions for individual users, multiple users, group or multiple groups. For example, to share a file or directory under __/project__:

{{< highlight bash >}}
# share a single file for full access
setfacl -m u:otherusers:rwX Calgary_Adult_Skull_Atlas.mnc 

#share a directory for reading and search, but first  make it the Default setting, i.e. for current and future files there

setfacl -d -m u:otheruser:rX /home/someuser/projects/def-somePI/Shared_data
setfacl -R -m u:otheruser:rX /home/someuser/projects/def-somePI/Shared_data

# share a directory for full access  based on a Unix group wg-abcde

setfacl -d -m g:wg-abcde:rwX /home/someuser/projects/def-somePI/Shared_data
setfacl -R -m g:wg-abcde:rwX /home/someuser/projects/def-somePI/Shared_data
 
{{< /highlight >}}

> Note that the above example refers to /home and uses the symlink to project. This will not work for data sharing between different PIs because $HOME is private. Thus, to refer to the shared data, "real" paths on __project__ of the form /project/PI-GIDnumber/Shared_data must be used.

### Data sharing across Research Groups

Linux ACLs described above are the way to share data across research groups. 

When sharing data between different PIs, residing under separate __/project__ directories, "search" access must be granted at the top project directory level. For example, to allow search access for group __wg-abcde__ on a PI's project directory:

{{< highlight bash >}}
setfacl -m g:wg-abcde:X /project/123456/
{{< /highlight >}}

Note that the real, absolute path to the project must be used rather than a $HOME-based symbolic link. 
To get the absolute path to the PI's project, use ```diskusage_report``` tool.

### Managing ACLs: viewing and removing 

Use ```getfacl``` to display current ACL settings. 
Use ```setfacl -b``` to remove ACLs when they are no longer needed:

{{< highlight bash >}}
# Display current ACLs for a directory
getfacl /home/someuser/projects/def-somePI/Shared_data

# Remove all ACLs from a directory
setfacl -bR /home/someuser/projects/def-somePI/Shared_data

{{< /highlight >}}

## External links
---

* [Linux permissions](https://linuxize.com/post/understanding-linux-file-permissions/ "Understanding Linux File Permissions")

* [ACLs](https://www.geeksforgeeks.org/access-control-listsacl-linux/ "Access Control Lists in Linux")

---

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Apr 29, 2024.
-->
