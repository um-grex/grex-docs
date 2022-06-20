# Data sharing

Sharing of accounts login information (like passwords or SSH keys) is stricty forbidden on Grex, as well as on most of the HPC systems. There is a mechanism of data/file sharing that does not require sharing of the accounts. To access each others' data on Grex, the UNIX groups and permissions mechanism can be used as explined below. 
<!--
We use a Westgrid exlpanation because Grex is still using Westgrid accounts and groups database, so the text below is still relevant.
-->

## UNIX groups

Each UNIX (or Linux) file or directory is owned by an individual user and also by a group (which may be comprised of several users). The permission to access files and directories can be restricted to just the individual owning the file, to the group that owns the file, or access can be unrestricted.

By default, each account (username) is set up with an associated UNIX group containing just that single username. So, even if you have set permission for your UNIX group to access files, they are still not being shared with anyone else. You can override the default by using the __chmod__ command to set unrestricted read access to your files. However, if you need more specific control over access, you can ask us to create a special UNIX group containing the usernames of other researchers with whom you want to share data by sending an email to [support](mailto:support@tech.alliancecan.ca) to ask that a new UNIX group be created for you. Include a list of the users who should be added to that group. One user should be designated as the authority for the group. If a request to join the group is made from someone else, We will ask the designated authority for the permission to add the new researcher to the group. The group name must be of the format __wg-xxxxx__ where __xxxxx__ represents up to five characters. Please indicate your preference for a group name in your email. 

The group will be set up on Grex system. This may take a day or two to set up. You will get an email whenever you are added or removed from a UNIX group.

Now that you have a __wg-xxxxx__ UNIX group created, you can set up the data sharing with it, by setting the permissions as described below.

The directory you wish to share should be owned by the group and permitted to the group. For example:

{{< hint info >}}
chgrp -R wg-group dir

chmod g+s dir
{{< /hint >}}

You must ensure that there is access to parent directories as well.

A directory and all the files in it can be permitted to the group as follows:

{{< hint info >}}
chmod -R g+rX /global/scratch/dirname
{{< /hint >}}

Tto set access for the /global/scratch/dirname directory and all its subdirectories. Note the uppercase X in the command. This will set x permissions on the subdirectories (needed for others to list the directories) as well as regular execute permission on executable files.

If you want the to allow other members to not only read files in the shared directory "dir", but also permit write access to allow them to create and change files in that directory, then all members in the group must add a line:

{{< hint info >}}
umask 007
{{< /hint >}}

to the __~/.bashrc__ or __~/.cshrc__ file in their respective home directories. Furthermore, you must add write permission to the shared directory itself:

{{< hint info >}}
chmod -R g+rwX dir
{{< /hint >}}

which would allow read and write access to the directory dir and all its files and subdirectories.

## Linux ACLs

On Lustre filesystem (__/global/scratch/$USER__), it is possible to use Linux access control lists (ACLs) which offer more fine-grained control over access than UNIX groups. Compute Canada's [Sharing Data](https://docs.alliancecan.ca/wiki/Sharing_data "Sharing data") documentation might be relevant, with one caution: on Grex, there is no project layout as exists on Compute Canada clusters.

An example setting of ACL command, to allow for "search" access of the top directory to a group wg-abcdf, presumably with some of the directories under it being shared by a UNUX group:

{{< hint info >}}
setfacl  -m g:wg-abcdf:X /global/scratch/$USER
{{< /hint >}}

## Related links

* [Linux permissions](https://linuxize.com/post/understanding-linux-file-permissions/ "Understanding Linux File Permissions")

* [ACLs](https://www.geeksforgeeks.org/access-control-listsacl-linux/ "Access Control Lists in Linux")

<!-- -->
