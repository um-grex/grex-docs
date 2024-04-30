---
weight: 100
linkTitle: "Rclone and OneDrive"
title: "Connecting to OneDrive using Rclone"
description: "How to use Rclone command line tool to connect to UM OneDrive"
categories: ["How to"]
banner: false
#bannerContent: "X2Go clients may not work currently on Grex because their lack the Duo MFA support"
#tags: ["Configuration"]
---

## UM OneDrive
---

The University of Manitoba provides [Microsoft OneDrive](https://www.microsoft.com/en-ca/microsoft-365/onedrive/onedrive-for-business) to its users as part of the Microsoft Office 365 contract. 
While not suited, for performance reasons, for online computation work or for storing large datasets, OneDrive can be a useful storage space to store important data of smaller size, documents, articles and such. 
It also offers some data preservation features like data recovery and data history.

> Please also refer to [UM Data Security Classification](https://umanitoba.ca/information-services-technology/sites/information-services-technology/files/2022-05/data-security-classification.pdf) to learn which kinds of data can be stored where.

[__rclone__](https://rclone.org) is a universal tool for uploading and downloading data to and from a wide variety of cloud storage systems.
In particular, it is the tool for transferring data between a Linux HPC system and the Microsoft OneDrive. 

However, due to the nature of Web-storage like OneDrive, needs for MFA, etc. a configuration step is required to make __rclone__ on Grex connect to the OneDrive.
The configuration step requires access to a Web browser.

## Configuring Rclone for OneDrive on Grex

Please login to Grex's [OpenOnDemand](/ood/) portal and request a _"Simplified Desktop"_ session. 
The desktop session is required to do the Web-based part of OneDrive authentication; however, main configuration is done in the command line because __rclone__ is a command line tool.

When the Desktop session is ready, connect to it in OOD's Desktop tab, and open a terminal. Run the following commands:

{{< highlight bash >}}
module spider rclone
module load rclone
rclone config
{{< / highlight >}}

The last command shows a prompt and will ask a large number of interactive questions. Answer them as follows:

* Q: "No remotes found -- make a new one"
    * answer "n" for a new remote
* Q: "name>"
    * call it "OneDrive"
* Q: "Storage>"
    * From the numbered list of storage, pick the number corresponding to "Microsoft OneDrive". The numbers change version to version. As of now, '31'.
* Q: "client_id>" 
    * leave blank (press Enter)
* Q: "client_secret>" 
    * leave blank (press Enter)
* Q: "Edit advanced config?"
    * answer "n" for No
* Q: "Use auto config?"
    * answer "y" for Yes
* at this point, a browser window will pop up. Not every browser works, so we recommend Firefox (__firefox__ command in the terminal) to be used as the default browser. Please inspect the browser window and URL to see if it looks like an authentic UManitoba login page!
    * Authenticate using your UManitoba email and UManitoba credentials and MFA. 
    * Go back to your terminal when "Success" is displayed.
* Q: "Your Choice>"
    * type a number to use your business OneDrive (as of now, '1')
* Q: "Choose drive to use>"
    * type '0'
* Q: "Is this ok y/n>"
    * answer "y" to confirm the drive selection
* Q: "y/e/d>"
    * answer "y" to confirm adding the remote to __rclone__
    
If the configuration was successful, at this point an OneDrive access token has been created under your home directory, valid for a number of days (90 days). You can start using command line __rclone__ tools from any SSH session on Grex.
When the token expires, it can be regenerated with __rclone config reconnect remote:__ command.


## Using Rclone for data transfers
---

The command line __rclone__ tool should be available, so as usual for the Grex [software](/software/#lmod), its module should be loaded.
Then __rclone ls__ command can be used to explore your OneDrive, and __rclone copy__ to copy the files to and from OneDrive as per the example below:

{{< highlight bash >}}
module load rclone
rclone ls OneDrive:/
rclone copy myfile.txt OneDrive:/testdir
rclone ls OneDrive:/testdir
rclone copy OneDrive:/testdir/myfile.txt myfile.bak
{{< / highlight >}}

{{< alert type="info" >}}
Note that MS OneDrive follows Windows rather than Linux file naming conventions, thus filenames are case-insensitive, may treat special characters in the names differently, etc.
{{< /alert >}}

Please refer to [rclone Documentation](https://rclone.org/docs/) for more information. 
Rclone is an universal data transfer tool that can be used for a variety of storages, and OneDrive is just one application for it.

## Using Rclone in OOD
---

On Grex, [OpenOnDemand](/ood) supports Rclone connection within the File App automatically. 
The Rclone folder will appear for the user after he performs the above __rclone config__ step. 
As with the command line access, the access token has to be periodically refreshed.

## External links
---

* [OSC Documentation on using Rclone with OneDrive we are indebted to](https://www.osc.edu/resources/getting_started/howto/howto_use_rclone_to_upload_data)
* [UManitoba IST OneDrive pages](https://umanitoba.ca/information-services-technology/microsoft-365/onedrive-setup-support)
<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Apr 29, 2024.
-->
