---
weight: 4000
linkTitle: "Data sharing"
title: "Data sharing"
description: "Everything you need to know about sharing data on Grex."
categories: ["Information"]
banner: true
bannerContent: "Work in progress."
tags: ["Configuration"]
---

## Data sharing
---

By default, data on Grex are owned by the user and are not open to other users of Grex, nor are they open for the outside access.

During a research project, it is often required to share datasets or code within a research group, or between collaborating research groups. This documentation page explains how to share data residing within a given HPC system (in our case, Grex). Sharing data outside of the HPC system is done by other means (for example Globus, MS OneDrive).

> How not to share data: no sharing account credentials, which is forbidden. Nor opening the data to be "World-accessible", which is a bad practice.

 * Sharing of accounts login information (like passwords or SSH keys) is strictly forbidden on Grex, as well as on most of the HPC systems. 
 * Opening a whole directory for everyone, especially for writing (using Linux/Unix +rwx or 777 file mode mask) is very dangerous because anyone on the system can not only read, but accidentally delete the whole directory.

There is a mechanism of data/file sharing that does not require sharing of the accounts. To access each other's data on Grex, the UNIX groups and permissions mechanism, or, preferrably, Access Control Lists (ACLs) mechanism should be used for a fine-grained control of permissions to a given data on the system. 

## UNIX groups and file ownership
---
First a bit of theory: how do permissions work on a Linux system?

Each UNIX (or Linux) filesystem object (a file or a directory) is owned by a single individual user (the owner) and also by a group (which may be composed of several users). The permission to access files and directories can be restricted to just the individual owning the file, to the group that owns the file, and to the "others" which is every other user on the system. Command ``` ls -la ``` would list ownership and permissions of all the objects in a current directory. 

Depending on the filesystem (__/project__ or __/home__ or, on the Alliance systems, __/scratch__ ) group ownership is either the users own "group", or the PI's "group". For example, on __/home_ , where users' own the data, a user would see something like this:

{{< highlight bash >}}
[someuser@yak Data]$ ls -la
total 328408
drwxrwxr-x  2 someuser someuser        75 Aug  9  2023 .
drwxrwxr-x 25 someuser someuser      4096 Oct 18 10:46 ..
-rw-r--r--  1 someuser someuser  64479232 Aug  9  2023 C0006853.AIM
-rw-r--r--  1 someuser someuser 271805449 Aug  9  2023 Calgary_Adult_Skull_Atlas.mnc
{{< /highlight >}}

Or, on __/project__, where the group-based hierarchy exists, ls would show a different group ownership to the default allocation of the PI of the research group of the user, as follows.

{{< highlight bash >}}
someuser@yak Data]$ ls -la
total 328420
drwxrwsr-x 3 someuser def-somePI      4096 Oct 21 14:43 .
drwxrwsr-x 3 someuser def-somePI       4096 Oct 21 14:35 ..
-rw-r--r-- 1 someuser def-somePI   64479232 Oct 21 14:35 C0006853.AIM
-rw-r--r-- 1 someuser def-somePI  271805449 Oct 21 14:35 Calgary_Adult_Skull_Atlas.mnc
drwxrwsr-x 2 someuser def-somePI       4096 Oct 21 14:43 Docker
{{< /highlight >}}

Because in UNIX/Linux, permissions are tied to group ownership, to change access two things are needed: changing ownership and group-ownership, and changing the permissions themselves. You override the default by using the __chmod__ command to modify access permissions to your files. You can use commands __chown__ and __chrgp__ to change owner and group of a filesystem object. This requires a group (or a user) to exist on the system. Sharing within PI's group thus is easily done with __chgrp__ and __chmod__ using the _def-somePI_ group. The def-somePI groups are created automatically based on CCDB group membershup, and are availeble for every group on Grex. They are also used to form directory structure on __/project__ filesystem. So, if a user would like to open a directory for this group, he'd need to modify the ownership masks as follows:

{{< highlight bash >}}
# opening a file and a directory for read write and search by all members of the def-somePI group.
chmod g+rwX Calgary_Adult_Skull_Atlas.mnc Docker
{{< /highlight >}}

However, there are cases when a more specific control over access is needed. Perhaps, only a subset of the PI's group needs the access to a dataset. Or, the set of users to access the dataset spans multiple research groups (that is, more than one PI). For such cases, a new UNIX group needs to be created. Grex and Alliance systems receive group and user information from CCDB. How are these groups created?

### Requesting a Data-sharing group

A PI can ask us to create a special __UNIX__ group containing the usernames of other researchers with whom you want to share your data by sending an email to support (__support@tech.alliancecan.ca__). Include a list of the users who should be added to that group. One user should be designated as the authority/manager for the group. If a request to join the group is made from someone else, we will ask the designated authority for the permission to add the new researcher to the group. The group name must be of the format __wg-xxxxx__ where __xxxxx__ represents up to five characters. Please indicate your preference for a group name in your email to Support.

The group will be set up on the Grex system. This may take a day or two to set up. You will get an email whenever you are added or removed from a UNIX group. Now that you have a __wg-xxxxx__ UNIX group created, permissions for data sharing can be set using either __chown__ / __chmod__ or using Linux ACLS as described below.

The directory you wish to share should be owned by the group and permitted to the group. For example:

{{< alert type="warning" >}}
In the following example and for demonstration purposes, we have used __/global/scratch__ but the instructions could be applied to __/project__ directories as well.
{{< /alert >}}

{{< highlight bash >}}
chgrp -R wg-group dir
chmod g+s dir
{{< /highlight >}}

You must ensure that there is access to parent directories as well.

A directory and all the files in it can be permitted to the group as follows:

{{< highlight bash >}}
chmod -R g+rX /global/scratch/dirname
{{< /highlight >}}

To set access for the /global/scratch/dirname directory and all its subdirectories. Note the uppercase X in the command. This will set x permissions on the subdirectories (needed for others to list the directories) as well as regular execute permission on executable files.

If you want them to allow other members to not only read files in the shared directory "dir", but also permit write access to allow them to create and change files in that directory, then all members in the group must add a line:

umask 007

to the __~/.bashrc__ or __~/.cshrc__ file in their respective home directories. Furthermore, you must add write permission to the shared directory itself:

{{< highlight bash >}}
chmod -R g+rwX dir
{{< /highlight >}}

which would allow read and write access to the directory dir and all its files and subdirectories.

## Linux ACLs
---

On most of modern Linux filesystems (such as Lustre FS serving Grex's __/project__), it is possible to use Linux access control lists (ACLs). ACLs offer more fine-grained control over access than UNIX groups, because they decouple "ownership" of a file from "access rights" to it. It is, for example, possible to give access to more than one user or group, without changing ownership. This makes ACLs more flexible and thus preferred way to organize data sharing.  

The Alliance's [Sharing Data](https://docs.alliancecan.ca/wiki/Sharing_data "Sharing data") documentation describes how to use ACLs for data sharing, and Grex has a similar hierarchical structure of the __/project__ filesystem. __/home__ on Grex is an NFSv4 and has its own syntax of ACLs. Generally, we assume that it is the __/project__ where the data would be shared, and __/home__ is per-user and private.

There are two commands to manipulate Linux ACLs on files and directories: ```getfacl``` to display the current ACL settings on a filesystem object, and ```setfacl``` to modify the settings. The modes of the access are similar to the symbolic codes of ```chmod```, that is ```r```, ```w``` and ```X```` stand for read, write and executa access. 

Because ACLs are not tied to ownership of the file, they can be used to give access to any individual user, many individual users, and one or more UNIX groups. To share a file and a directory under __/project__ :

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

Another requirements for data sharing between different research groups exists. Data residing under different /project trees belonging to different PIs, requires for sharing  the top project directory must be opened for "Search" only. An example the  ACL command, to allow for "search" access of the top directory to a group wg-abcdf, presumably with some of the directories under it being shared by a UNIX group (the 123456 is the project GUID of the PI):

{{< highlight bash >}}
setfacl -m g:wg-abcde:X /project/123456/
{{< /highlight >}}

How to display existing access setting and remove existing ACLs when they are no longer needed?

{{< highlight bash >}}
# display current ACLs

getfacl /home/someuser/projects/def-somePI/Shared_data

# remove all the ACLs from it
setfacl -bR /home/someuser/projects/def-somePI/Shared_data

{{< /highlight >}}


For data sharing between different research groups, that is, the data residing under different /project trees belonging to different PIs, the top project directory must be opened for "Search" only. An example the  ACL command, to allow for "search" access of the top directory to a group wg-abcdf, presumably with some of the directories under it being shared by a UNIX group (the 123456 is the project GUID of the PI):

{{< highlight bash >}}
setfacl -m g:wg-abcdf:X /project/123456
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
