---
weight: 100
linkTitle: "Globus"
title: "Globus"
description: "How to use Globus interface on Grex"
categories: ["How to"]
banner: false
#bannerContent: "X2Go clients may not work currently on Grex because their lack the Duo MFA support"
#tags: ["Configuration"]
---

## Introduction
---

[Globus](https://docs.globus.org/) is a service for fast, reliable, secure file transfer. Designed specifically for researchers, Globus has an easy-to-use interface with background monitoring features that automate the management of file transfers between any two resources, whether they are on supercomputing facility, a campus cluster, lab server, desktop or laptop. Globus improves transfer performance over pther file transfer tools, like rsync, scp, and sftp, by automatically tuning transfer settings, restarting interrupted transfers, and checking file integrity. 

Globus transfers data between any two so-called “Globus endpoints” or “Data Collections”. Since the data can reside across different organizations, Globus provides a way to manage and link “identities” between these organizations to facilitate data transfers and data sharing. University of Manitoba has a Globus subscription, so its users can participate in the Globus identity federation using their UMNetIDs and University’s authentication system, protected with UM multi-factor authentication. Globus can be accessed via the [main](https://www.globus.org/) globus website or [UManitoba](http://globus.umanitoba.ca/) or via the [Alliance](http://globus.alliancecan.ca/) globus portals. 

After starting Globus, you can link a new identity to access Grex endpoint, called __UManitoba Grex HPC__. Once the identity is linked, you should be able to access your data on Grex and initiate a data transfer between Grex and national sites or any other globus collection you may have access to.

### How to add Grex endpoint?

To use __UManitoba Grex HPC__ endpoint, a user will need to link the globus identity. For these instructions, we will use the [UManitoba](http://globus.umanitoba.ca/) globus portal. You could also use any other globus portal you may have access to.

To access __UManitoba Grex HPC__ endpoint, please follow these instructions:

__1.__ First, start [UManitoba](http://globus.umanitoba.ca/) globus portal. Use the menu under _Use your existing organizational login__ and select __University of Manitoba__ and click on **Continue**.

{{< collapsible title="UManitoba globus login interface: Globus Web App" >}}
![UManitoba globus Web App](/globus/um-globus-login.png)
{{< /collapsible >}}

__2.__ The previous step will redirect you the UM Microsoft login webpage and ask for UM Multifactor authentication. After a successful authentication, you should be able to access globus file manager as shown in the picture below:

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

__6.__ Then, click on the link ( rprox.hpc.umanitoba.ca ) from the previous step and redirect you the authentification page where you should use your Grex user name and password and your second factor you usually use to connect to Grex:

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

{{< collapsible title="Log into your primary identity." >}}
![MFA second factor](/globus/globus-id-rprox-required2.png)
{{< /collapsible >}}

__8.__ Then select _username@rprox.hpc.umanitoba.ca_. This will redirect you to a file manager where your data under your home directory on Grex is shown:

{{< collapsible title="UManitoba Grex HPC." >}}
![Globus Web App](/globus/grex-globus-file-manager.png)
{{< /collapsible >}}

Once your identity is linked, you can use globus to initiate data transfer between Grex and any other globus connection, like cedar for example.

## How to use globus to initiate transfer between two collections?

Once the identity is linked as shown in the previous section, you could launch globus web application to initiate file transfer between what is called __Collections__. Here are the steps to follow:

__1.__ Launch globus web app:

__2.__ Select the two pannel file manager

__3.__ Search for the collections you want to use and navigate through your directory.

__4.__ Initiate the transfer
 
## External links
---

* Globus [Documentation](https://docs.alliancecan.ca/wiki/Globus/en)

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Apr 29, 2024.
-->
