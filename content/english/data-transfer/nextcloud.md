---
weight: 4130
linkTitle: "NextCloud on Grex"
title: "Using NextCloud on Grex"
description: "How to use NextCloud service on Grex"
categories: ["How to"]
banner: True
bannerContent: "__nextCloud pilot project on Grex__"
#tags: ["Configuration"]
---

## Introduction
---

Starting from Apr 2026, we provide [nextCloud](https://docs.nextcloud.com), a Dropbox-like cloud storage service, for all Grex users. You can use your Grex (the Alliance) username and password to log in to the [Grex nextCloud](https://nextcloud.hpc.umanitoba.ca) server. Similar to [ood](ood) and all other services, accessing nextCloud on Grex requires [MFA](connecting/mfa). 

A complete nextCloud user manual is available from the official nextCloud [documentation](https://docs.nextcloud.com/server/latest/user_manual/en/). All data transfers between local devices and Grex's nextCloud are encrypted. 

* __Server URL:__ https://nextcloud.hpc.umanitoba.ca
* __Server Location:__ High Performance Computing data centre, University of Manitoba.
* __Fixed Quota:__ 100 GB per user
* __Backup Policy:__ Daily backup without offsite copy?
* __Access Methods:__ Web interface, Nextcloud Desktop Sync Client, Nextcloud mobile apps, and any WebDAV client?
* __Documentation:__ [PDF](https://docs.nextcloud.com/server/33/Nextcloud_User_Manual.pdf) and [online](https://docs.nextcloud.com/)

## Connect to nextCloud

To connect to nextCloud:

> __1.__ Point your Web browser to [__nextcloud.hpc.umanitoba.ca__](https://nextcloud.hpc.umanitoba.ca). This will redirect you to our Keycloack IDP screen.

> __2.__ Use your Alliance/CCDB username and password to log in to Grex nextCloud.

{{< collapsible title="Use your Alliance username and password to log in to Grex nextCloud." >}}
![MFA second factor](/globus/grex-keycloak.png)
{{< /collapsible >}}

> __3.__ Provide Alliance’s Duo second factor authentication when asked.

Once connected, the interface shows the following view:

{{< collapsible title="nextCloud interface." >}}
![MFA second factor](/nextcloud/nextcloud-view.png)
{{< /collapsible >}}

## Quota on nextCloud

As of now, the quota per user is __100 GB__ 

{{< alert type="warning" >}}
The quota per user may change depending on the demand, available space and the performance.
{{< /alert >}}

## Using the nextCloud web interface

To use the web interface, log in to Grex nextCloud from a web browser using your Grex (the Alliance) username and password as described above. You can upload and download files between nextCloud and your mobile device or computer and share files with other Grex users. For more information, see the nextCloud [user manual](https://docs.nextcloud.com/server/33/Nextcloud_User_Manual.pdf) and [online](https://docs.nextcloud.com/) documentation.

## Using Nextcloud Desktop Synchronization Client and mobile apps

You can download the nextCloud Desktop Sync Client or nextCloud mobile apps to synchronize data from your computer or your mobile device respectively. Once installed, the software will "sync" everything between your Nextcloud folder and your local folder. It may take some time to synchronize all data. You can make changes to files locally and they will be updated in nextCloud automatically.  

## External links
---

* nextCloud official website: [__nextCloud__](https://docs.nextcloud.com)
* [__Online__](https://docs.nextcloud.com/server/latest/user_manual/en/) documentation.

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Apr 7, 2025.
-->
