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

## Globus
---

As a Grex user, you have already access to globus from the Digital Research Alliance of Canada. You can start globus and link a new identity to access Grex endpoint __UManitoba Grex HPC__. Once the identity is linked, you should be able to access your data on Grex and initiate a data transfer between Grex and national sites or any other globus collection you may have access to.

### How to link your identity to Grex endpoint?

To link your identity in order to access Grex endpoint, please follow these instructions:

__1.__ First, start globus using your Digital Research Alliance of Canada as explained [here](https://docs.alliancecan.ca/wiki/Globus/en#Using_Globus).

__2.__ In the field __Collection__, search for __UManitoba Grex HPC__. For the first time, it should show a message asking to link a new identity:

{{< alert type="info" >}}
None of your authenticated identities are from domains allowed by resource policies

Session reauthentication required (Globus Transfer)

a rprox.hpc.umanitoba.ca identity
{{< /alert >}}

__3.__ Then, click on the link __Continue__

__4.__ After clicking on the menu __Continue__, you will see this message:

{{< alert type="info" >}}
Identity Required

An identity from one of the following identity providers is required to continue.

Reason: Session reauthentication required (Globus Transfer)

Please select the identity or identity provider to continue:

Link an identity from Grex HPC Login (rprox.hpc.umanitoba.ca)
{{< /alert >}}

__5.__ Then, click on the link ( username@rprox.hpc.umanitoba.ca ) from the step __4__. This should give you access to your data on Grex.

Once your identity is linked, you can use globus to initiate data transfer between Grex and any other globus connection, like cedar for example. For more information about using globus, please have a look to the [documentation](https://docs.alliancecan.ca/wiki/Globus/en).

## External links
---

* Globus [Documentation](https://docs.alliancecan.ca/wiki/Globus/en)

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Apr 29, 2024.
-->
