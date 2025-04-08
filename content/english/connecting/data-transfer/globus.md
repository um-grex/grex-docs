---
weight: 100
linkTitle: "Globus on Grex "
title: "Using Globus on Grex"
description: "How to use Globus file transfer service on Grex"
categories: ["How to"]
banner: false
#bannerContent: "X2Go clients may not work currently on Grex because their lack the Duo MFA support"
#tags: ["Configuration"]
---

## Introduction
---

[Globus](https://docs.globus.org/) is a service for fast, reliable, secure file transfer. Designed specifically for researchers, Globus has an easy-to-use interface with background monitoring features that automate the management of file transfers between any two resources, whether they are on a supercomputing facility, a campus cluster, lab server, desktop or laptop. Globus improves transfer performance over other file transfer tools, like rsync, scp, and sftp, by automatically tuning transfer settings, restarting interrupted transfers, and checking file integrity. 

> Globus transfers data between any two so-called “Globus endpoints” or “Data Collections”. Since the data can reside across different organizations, Globus provides a way to manage and link “identities” between these organizations to facilitate data transfers and data sharing. 

University of Manitoba has a Globus subscription, so its users can participate in the Globus identity federation using their UMNetIDs and University’s authentication system, protected with UM multi-factor authentication. Globus can be accessed via the [main](https://www.globus.org/) Globus website or [UManitoba](http://globus.umanitoba.ca/) or via the [Alliance](http://globus.alliancecan.ca/) Globus portals. 

There are two methods of using Globus that are available for Grex users: using a Grex Server endpoint, or using their own Personal Endpoints on Grex login nodes. Both methods are described below.

### How to use Grex Server endpoint


To use the  __UManitoba Grex HPC__ endpoint, a user will need to link its Globus "identity" to his master identity in the GlobusOnline portal. For the purpose of these instructions, we will use the [UManitoba](http://globus.umanitoba.ca/) Globus portal. You could also use any other Globus identity you may have access to (for example, the Alliance / CCDB identity).

To access __UManitoba Grex HPC__ endpoint, please follow these instructions:

__1.__ First, open [UManitoba](http://globus.umanitoba.ca/) Globus portal in your browser. Use the menu under __Use your existing organizational login__ and select __University of Manitoba__ and click on **Continue**.

{{< collapsible title="UManitoba globus login interface: Globus Web App" >}}
![UManitoba globus Web App](/globus/um-globus-login.png)
{{< /collapsible >}}

__2.__ The previous step will redirect you to the UM Microsoft login webpage and ask for UM Multifactor authentication. After a successful authentication, you should be able to access Globus file manager as shown in the picture below:

{{< collapsible title="Globus file manager" >}}
![Globus interface](/globus/globus-file-manager.png)
{{< /collapsible >}}

__3.__ In the field __Collection__, search for __UManitoba Grex HPC__. For the first time, it should show a message asking to link a new identity:

{{< alert type="info" >}}
None of your authenticated identities are from domains allowed by resource policies

Session reauthentication required (Globus Transfer)

a rprox.hpc.umanitoba.ca identity
{{< /alert >}}

as shown in the following screenshot:

{{< collapsible title="None of your authenticated identities are from domains allowed by resource policies" >}}
![Session reauthentication required (Globus Transfer)](/globus/globus-rprox-required.png)
{{< /collapsible >}}

__4.__ Then, click on the link __Continue__

__5.__ After clicking on the menu __Continue__, you will see this message:

{{< alert type="warning" >}}

Identity Required

An identity from one of the following identity providers is required to continue.

Reason: Session reauthentication required (Globus Transfer)

Please select the identity or identity provider to continue:

__Link an identity from Grex HPC Login (rprox.hpc.umanitoba.ca)__

{{< /alert >}}

Here is a screenshot of the message:

<!--
{{< collapsible title="An identity from one of the following identity providers is required to continue." >}}
![Please select the identity or identity provider to continue:](/globus/globus-id-rprox-required.png)
{{< /collapsible >}}
-->

{{< collapsible title="An identity from one of the following identity providers is required to continue" >}}
![Session reauthentication required (Globus Transfer)](/globus/globus-id-rprox-required.png)
{{< /collapsible >}}

__6.__ Then, click on the link ( rprox.hpc.umanitoba.ca ) from the previous step and redirect you the authentification page where you should use your [Grex user name and password](/access/) and your second factor authentication method you usually use to connect to Grex:

{{< collapsible title="Use MFA to login" >}}
![MFA second factor](/globus/grex-keycloak.png)
{{< /collapsible >}}

This will display a message to log into your primary identity: 

{{< alert type="info" >}}
Log into your primary identity.

In order to link username@rprox.hpc.umanitoba.ca to your Globus account, please log into your primary identity (username @ domainname ). 

By selecting Continue, you agree to Globus terms of service and privacy policy. 
{{< /alert >}}

{{< collapsible title="Log into your primary identity." >}}
![MFA second factor](/globus/login-to-primary-identity.png)
{{< /collapsible >}}

__7.__ Then, click on __Continue__ to proceed. This will dispal a messsage:

{{< alert type="info" >}}
Identity Required

An identity from one of the following identity providers is required to continue.

Reason: Session reauthentication required (Globus Transfer)

Please select the identity or identity provider to continue:

username@rprox.hpc.umanitoba.ca
Link an identity from Grex HPC Login (rprox.hpc.umanitoba.ca)
{{< /alert >}}

__8.__ Then select _username@rprox.hpc.umanitoba.ca_. This will redirect you to a file manager where your data under your home directory on Grex is shown:

{{< collapsible title="UManitoba Grex HPC." >}}
![Globus Web App](/globus/grex-globus-file-manager.png)
{{< /collapsible >}}

Once your identity is linked, you can use Globus to initiate data transfer between Grex and any other Globus connection, like cedar for example.

### How to use Globus Web App to initiate transfer between two collections?

Once the identity is linked as shown in the previous section, you could launch Globus web application to initiate file transfer between what is called __Collections__. Here are the steps to follow:

__1.__ Launch Globus web app.

__2.__ Select the two panel file manager.

__3.__ Search for the collections you want to use and navigate through your directory.

__4.__ Initiate the transfer.


> Limitations of the Grex server endpoint : At the moment of writing, the "Grex HPC" server endpoint does not support browser-based "Upload" functionality. The server endpoint also does not support data sharing and data publishing. The only use case for this endpoint is data transfer between two Endpoints/Connections.

[OpenOnDemand](/ood) web portal on Grex now provides integration with the "UManitoba Grex HPC" endpoint: in the OOD's File manager interface, the "Globus" button would redirect to the Globus WebApp on the endpoint, pointing to the current directory.

## How use personal endpoints and Globus CLI on Grex 

It is  possible to use personal endpoints on Grex login nodes instead of the Grex (limited) server endpoint. Each user can use Globus Connect Personal to transfer data between any Server Endpoint and Grex. 
The method above is also useful for the use cases (data transfer automation)  that require using Globus Command Line Interface (CLI) rather than the WebApp.

To get access to the Globus CLI and to create their personal endpoint on Grex, under their account, the following instruction have to be followed.

{{< highlight bash >}}
[~]$ module load globus
#
# Use an existing Globus identity to authenticate in the step below
#
[~]$ globus login --no-local-server
Please authenticate with Globus here:
------------------------------------
https://auth.globus.org/v2/oauth2/authorize?[...]
------------------------------------

Enter the resulting Authorization Code here: [...]

You have successfully logged in to the Globus CLI!

You can check your primary identity with
  globus whoami

For information on which of your identities are in session use
  globus session show

Logout of the Globus CLI with
  globus logout
[~]$ globus gcp create mapped <YOUR_NEW_ENDPOINT_NAME>
Message:     Endpoint created successfully
Endpoint ID: abcdef00-1234-0000-4321-000000fedcba
Setup Key:   12345678-aaaa-bbbb-cccc-87654321dddd
[~]$ globusconnectpersonal -setup 12345678-aaaa-bbbb-cccc-87654321dddd
[~]$ tmux new-session -d -s globus 'globusconnectpersonal -start'
### You can now start a transfer by navigating to https://globus.alliancecan.ca/
### and searching/choosing <YOUR_NEW_ENDPOINT_NAME> as the "Collection"
{{< /highlight >}}

Once the endpoint had been created and the personal Globus server started, the endpoint will be visible/searchable in the GlobusOnline Web interface. Now it can be used for data transfers. The ```module load globus``` command also provides Globus command line interface (CLI) that can also be used to move data  as described here: [Globus CLI examples](https://docs.globus.org/cli/examples/)

### Filesystems and symbolic links

Often, there is more than one filesystem on a Linux machine the personal endpoint is started on. For example, an endpoint on Grex login node would have  __$HOME__ and __/project__ available for sharing.
However, on Linux, Globus does no share everything by default, other than users $HOME ! Even when there exist symbolic links to __/project__ or __/scratch__, they would not yet be navigable in the Globus Web UI or CLI.
Symbolic links across the filesystems do not work in Globus, unless both filesystems are shared!

To enable sharing filesystems other than $HOME, the following special file has to be edited: `~/.globusonline/lta/config-paths`
By default Globus creates this file with only one line, `~/,0,1` that corresonds to user's home directory. To add your project, or other filesystems, an extra line per filesystem must be added to the file.
The example below shows a template `~/.globusonline/lta/config-paths` file for Grex.

{{< highlight bash >}}
# modify the file as needed. Each line is of the format Path,SharingFlag,RWFlag.
# the SharingFlag must be 0 for non-Globus+ endpoints.
cat ~/.globusonline/lta/config-paths
~/,0,1
/scratch/,0,1
/project/<YOUR_PROJECT_ID>/,0,1
{{< /highlight >}}

Note that you would replace __<YOUR_PROJECT_ID>__ above with your real path to the __/project__ filesystem. One way to get it on Grex is to examine the output of the `diskusage_report` script.
Another, more general way, is to use `realpath` command to resolve the project symlink, as in `realpath /home/${USER}/projects/def-<YOUR_PI>/` .

More information about configuring the Paths is available at [Globus Documentation on Linux Endpoints](https://docs.globus.org/globus-connect-personal/install/linux/#config-paths) .

### Managing personal endpoints

It is a good practice to not to keep unnecessary processes running on Grex login nodes. Thus, when all data transfers are finished, user should stop their Globus server process running personal endpoint as follows:
{{< highlight bash >}}
[~]$ tmux kill-session -C -t globus
{{< /highlight >}}

Once an endpoint had been created, there is (usually) no need to repeat the above steps creating a new endpoint. To restart the same existing endpoint, as needed for new data transfer sessions, it will be enough to run:
{{< highlight bash >}}
[~]$ tmux new-session -d -s globus 'globusconnectpersonal -start'
{{< /highlight >}}

Another, more general but older guide on how to use Globus personal endpoint on a Linux system, can be found on the [Frontenac "Data Transfers" page](https://info.cac.queensu.ca/wiki/index.php/UploadingFiles:Frontenac#Using_Globus_through_a_command-line_interface).

### Using Upload button and HTTP access

Globus v.5 adds a new feature to server endpoints that allows for [using HTTP protocol](https://docs.globus.org/globus-connect-server/v5/https-access-collections) (instead of the traditional globus-url-copy) .
This feature can be used from the Web UI (Upload button), and from CLI for accessing Globus using the HTTPS URL someone had shared with you.

> Note that the Upload feature is not available for Personal Globus endpoints. It only can be used for properly configured Server endpoints.
 
## External links
---

* Globus official [Documentation](https://docs.globus.org/guides/tutorials/manage-files/transfer-files/)
* Globus [CLI Documemtation](https://docs.globus.org/cli/)
* DRAC Globus [Wiki page](https://docs.alliancecan.ca/wiki/Globus/en)
* Check out the [ESNet](https://fasterdata.es.net/ "ESNet") website if you are curious about Globus, and why large data transfers over WAN might need specialized networks and software setups.


<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Apr 7, 2025.
-->
