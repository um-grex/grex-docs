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
* __Fixed Quota:__ 100 GB per user.
* __Backup Policy:__ Weekly backup without offsite copy.
* __Access Methods:__ Web interface, Nextcloud Desktop Sync Client, Nextcloud mobile apps, and any WebDAV client.
* __Documentation:__ [PDF](https://docs.nextcloud.com/server/33/Nextcloud_User_Manual.pdf) and [online](https://docs.nextcloud.com/)

{{< alert type="warning" >}}
As of now, the quota per user is __100 GB__. The quota per user may change depending on the demand, available space and the performance.
{{< /alert >}}

## Connect to nextCloud

To connect to nextCloud:

> __1.__ Point your Web browser to [__nextcloud.hpc.umanitoba.ca__](https://nextcloud.hpc.umanitoba.ca). This will redirect you to our Keycloack IDP screen.

> __2.__ Use your Alliance/CCDB username and password to log in to Grex nextCloud.

{{< collapsible title="Use your Alliance username and password to log in to Grex nextCloud." >}}
![MFA second factor](/globus/grex-keycloak.png)
{{< /collapsible >}}

> __3.__ Provide your Alliance’s Duo second factor authentication when asked.

Once connected, the interface shows the following view:

{{< collapsible title="nextCloud interface." >}}
![MFA second factor](/nextcloud/nextcloud-view.png)
{{< /collapsible >}}

## How to use nextCloud interface?

To open the web interface, log in to [Grex nextCloud](https://nextcloud.hpc.umanitoba.ca) from a web browser using your Grex (the Alliance) username and password as described above. Once connected to nextCloud interface, use the menu __+New__ and its sub-memus can be to upload file or folders:

{{< collapsible title="Upload files or folders to nextCloud." >}}
![MFA second factor](/nextcloud/nextcloud-upload.png)
{{< /collapsible >}}

Once you have your data uploaded to nextCloud, it is possible to download the data and also share files with other users.

To download data, navigate through your data and select the file or the directory to download and use the menu __Download__:

{{< collapsible title="Download files or folders to nextCloud." >}}
![MFA second factor](/nextcloud/nextcloud-download.png)
{{< /collapsible >}}

When downloading a directory (for example with the name _TEST_), nextCloud will save it on your local machine as a _zip_ archive (in this case, the file will be _TEST.zip_).

The files and directories on nextCloud can be shared with other users:

{{< collapsible title="Share files or folders with other users." >}}
![MFA second factor](/nextcloud/nextcloud-share.png)
{{< /collapsible >}}

## Desktop and mobile clients

There is a possibility to install [nextCloud clients](https://nextcloud.com/features/#clients) to sync automatically and changes between the local folder and your nextCloud account. The following are the steps to follow to setup a Desktop client on Mac:

> __1.__ First, download the appropriate Desktop client for Mac. The Desktop installers are available from the nextCloud [website](https://nextcloud.com/install/#desktop-files).

> __2.__ Install the Desktop client using the installer you downloaded in the first step.

> __3.__ Launch the Desktop client from your Mac. This will ask you to login. In the field _Server address_ put the URL for Grex nextCloud and follow the instructions. 

{{< collapsible title="Desktop client." >}}
![MFA second factor](/nextcloud/nextcloud-desktop-login.png)
{{< /collapsible >}}

> __4.__ The above will open a page in your browser and asks you to connect to your account as shown in the following screenshot:

{{< collapsible title="Link the Desktop client to your nextCloud account." >}}
![MFA second factor](/nextcloud/nextcloud-link-account.png)
{{< /collapsible >}}

Afer granting access, your account will be linked to your nextCloud account on Grex. A location for nextcloud will be added to your Mac. It should be visible from the Finder. Also, a shortcut will be visible from your menu bar. It can be used to access your nextCloud account.

{{< collapsible title="Access nextCloud from Desktop client." >}}
![MFA second factor](/nextcloud/nextcloud-access-menu.png)
{{< /collapsible >}}
   
From this menu, you can access nextCloud interface (or dashboard), Files and Activity. This later traces the latest operations, like uploading or downloading data, deleting data, ... etc.

If you use your Finder and go to the nextcloud folder on your Mac, you can work on that directory and the changes will be synced automatically to your nextCloud folder on Grex. Note that it may take some time to synchronize all the data.

{{< alert type="warning" >}}
The above steps can be used on Mac OS. For other operating system, please download the corresponding version of the Desktop client (Linux or Windows). For more information on how to proceed, please refer to nextCloud [user manual](https://docs.nextcloud.com/server/33/Nextcloud_User_Manual.pdf) and [online](https://docs.nextcloud.com/) documentation.
{{< /alert >}}

{{< alert type="info" >}}
The nextCloud mobile clients were not addreed here. If needed, please refer to the officila documentation of nextCloud.
{{< /alert >}}

## External links
---

* nextCloud official website: [__nextCloud__](https://docs.nextcloud.com)
* [__Online__](https://docs.nextcloud.com/server/latest/user_manual/en/) documentation.

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Apr 7, 2025.
-->
