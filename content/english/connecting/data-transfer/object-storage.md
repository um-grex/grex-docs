---
weight: 100
linkTitle: "Object Storage on OpenStack"
title: "Data transfers for OpenStack Object Storage"
description: "How to move data between OpenStack Object Storage and Grex"
categories: ["How to"]
banner: false
tags: ["Configuration", "Storage"]
---

## What is Object Storage
---

Object storage is a storage technology that allows large amounts of data to be stored as “objects.” This differs from a traditional POSIX-compliant filesystem, which organizes data as randomly accessible “files” and “directories” on block-based storage. Object storage enables access to entire objects only (for loading, storing, or retrieving). Each object contains the data itself (e.g., a photo, video, or document), metadata that describes the object, and a unique identifier used to retrieve it. Access to the content inside an object is typically handled by client software.

Object storage often offers a better cost/performance ratio than traditional HPC storage systems. However, it is entirely software-driven, and many traditional HPC applications are not compatible with Object Storage out of the box.

A very common use case for Object Storage is simply storing large volumes of unstructured data. Another is serving web content through an API-based frontend. In particular, Object Storage can act as a basic Content Delivery Network (CDN): for example, if you store static website content (such as images, HTML pages, and JavaScript files), it can be an accessed via a web browser as a regular website. A practical example of this is the [PointCloud](https://en.wikipedia.org/wiki/Point_cloud) described below.

## Arbutus (and other) National DRI Object Storage instances
---

There is no Object Storage provided on Grex. However, the National DRI (Alliance) provides the Arbutus OpenStack Cloud, which is available on request to users with an active CCDB account. As part of the Arbutus service offering, Object Storage is available and can be requested—up to 10 TB—via the regular [RAS process](https://docs.alliancecan.ca/wiki/Cloud).

Once approved, you can create one or more “buckets” within your Object Storage allocation. These buckets can then be accessed using the S3 protocol.

{{< alert type="warning" >}}
Please refer to UM Data Security Classification to determine what types of data are appropriate for storage on this service. Note that Arbutus Object Storage is provided by the Alliance and the University of Victoria, and is not hosted by the University of Manitoba’s IT services.
{{< /alert >}}

Also note that there is a single namespace across the entire system, meaning bucket names must be unique globally. Once a bucket is created, and if configured as “public” in its settings, it can be accessed via a __URL__: **http://object-arbutus.cloud.computecanada.ca/BUCKET_NAME** where BUCKET_NAME is the name of the bucket. Alternatively, buckets can be kept private, in which case a pair of access and secret keys will be required to authenticate, as described below.

## Authentication into the OpenStack Objects Storage

Authentication is done using a Bash shell environment and the [OpenStack Python client](https://docs.openstack.org/python-openstackclient/pike/) package. The easiest way to do this is from a Linux command-line environment on a trusted machine, where your credentials won’t be exposed to other users. One suitable environment is Grex.

Two components are required for authentication:

  * An OpenStack RC file, which can be downloaded from your Arbutus Horizon Dashboard.
  * The OpenStack client Python package.

Open the Arbutus cloud dasboard at [Arbutus Cloud Link](https://arbutus.cloud.computecanada.ca). You can navigate it to your project's Object Storage at screenshot below, and, when your Resource Allocation Allows, create buckets there, change their permissions etc..

![Arbutus Dashboard for Object Storage tab](/globus/arbutus-objecstore.png)

Navigate to the top right corner of the OpenStack Dashboard, click on your account name ( __username__ on the screenshot above) and use the item in the dropdown menue to Download the RC file. The RC file is a shell script; you can then copy it to Grex, or, alternatively, copy and paste its contents into a text editor on Grex and save it.

{{< alert type="info" >}}
__Note:__ If your user account belongs to multiple projects, each project will have its own RC file, even though your dashboard login remains the same. Be sure to select the appropriate project (__project-name__ on the screenshot above) before downloading the RC file.
{{< /alert >}}

First, load a suitable Python module (if required on your system), and create a virtual environment:

{{< highlight bash >}}
python -m venv OS
source OS/bin/activate
pip install python-openstackclient
# Need to add it to this session's PATH to have access to the openstack command
export PATH=$PATH:`pwd`/OS/bin
{{< /highlight >}}

{{< alert type="info" >}}
On Grex, __openstack-client__ is provided as a module. So the above Python/venv steps can be replaced with convenient <code> module load openstack-client/8.2.0 </code> .
On other HPC systems, installation of the openstack-python in a _virtual environment_ is necessary, if the openstack command is not available from the system. 
{{< /alert >}}

Once the module is loaded or the client is installed, source the OpenStack RC file to load your credentials into the environment. It will ask for your password. 
Then, generate EC2-compatible credentials using the following __openstack__ command:

{{< highlight bash >}}
# Load your projects' credentials using your CCDB account/password
source openstack.rc
# Enter password when asked!
# Create the buckets access credentials
openstack ec2 credentials create
{{< /highlight >}}

The resulting output will contain various hashes (long strings of numbers and letters). There should be an "access" hash, which is your access key, and a "secret" hash, which is the password to it. This pair of credentials, "access"/"secret"  is used to access OpenSTack Object Storage with any kind of client software: WinSCP, Rclone, GlobusOnline, etc.
The output will contain a set of long alphanumeric strings:

 * The "Access" key (labeled access) is your access identifier.
 * The "Secret" key (labeled secret) is your authentication password.

This access/secret key pair is used to authenticate with OpenStack Object Storage using any compatible client software, such as WinSCP, Rclone, or Globus, among others. 

{{< alert type="warning" >}}
Note that the access/secret pair has to be treated as user's password! Keep them in a secure place and do not share.
{{< /alert >}}

## Accessing Arbutus OpenStorage using Globus
---

ObjectStorage is universal and can be accessed, in general, by many tools like s3cmd or rclone or WinSCP, or by using a Python library like _requests_. 
[Globus](connecting/data-transfer/globus) provides a fast and convenient service to organize large data transfers over WAN, and that includes Object Storage endpoints. However, this requires the storage endpoint to purchase and install a "Globus connector" and be registered in the Globus Federation. 

Fortunately, Arbutus provides such a Globus endpoint, which can be accessed using your CCDB (Alliance) credentials. The official documentation is available [here](https://docs.alliancecan.ca/wiki/Globus#Object_storage_on_Arbutus).

To access Object Storage buckets via Globus Online, you will need:

 * A Globus account that is linked to your CCDB account (Grex and Alliance users typically already meet this requirement).
 * Access credentials for a specific Object Storage bucket on Arbutus, created as per above.

The following steps can be followed to set it up:

 * Log in to Grex and ensure you have your OpenStack RC file ready.
 * Follow the earlier steps to create your access/secret key pair using __sourcing OpenStack RC file__  and running __openstack ec2 credential creation__.

Then, 

 * Log in to the Globus Online portal using your CCDB  credentials (Arbutus access is via CCDB).
 * Search for the collection named "Arbutus S3 buckets".
 * When prompted, consent to link your accounts and allow Globus to access metadata. Globus will request this consent once for each new endpoint or collection.
 * When prompted, enter your Access Key and Secret Key. This links your bucket credentials to the Arbutus endpoint.

After successful authentication into Arbutus Endpoint and the buckets, your Object Storage buckets should appear in the Globus File Manager interface. You can now transfer files using Globus , between Arbutus buckets and HPC machines , be that National Alliance systems or Grex, as you would with any other storage collection.

<!--
### Using multiple buckets or multiple projects with Globus
TBD
-->


###  Accessing ObjectStorage using Rclone

[__Rclone__](https://rclone.org) is a versatile command-line tool for uploading and downloading data to and from a wide variety of cloud storage systems. It is especially useful for transferring data between a Linux HPC system (such as Grex) and Object Storage. Any S3-compatible storage endpoint would work.

Before you can use rclone, a one-time configuration step is required to provide it with your Object Storage credentials. This can be done entirely from the command line—no web browser access is needed. You may also configure it manually by editing rclone's configuration file.

In the same SSH session on Grex, type "deactivate" to leave the virtualenv. Then, run the following commands:

{{< highlight bash >}}
module load rclone
rclone config
{{< / highlight >}}

{{< alert type="info" >}}
On Grex, rclone is provided as a module. On other systems, rclone might be available from the system. If not available, you can install it locally.  
{{< /alert >}}

This last command will launch an interactive prompt that asks a series of configuration questions. This is where you will provide the access/secret credentials pair to the tool! Answer them as follows

* Q: "No remotes found -- make a new one"
    * Answer "n" for a new remote
* Q: "name>"
    * Call it "ObjectStorageMy"
* Q: "Storage>"
    * From the numbered list of storage, pick the number corresponding to "Amazon S3 Compliant Storage Providers". 
    * The numbers change version to version. As of now, '4'.
* Q: "Option provider. Choose your S3 provider>" 
    * Any other S3 compatible provider. As of now, 34.
* Q: "Get AWS credentials from runtime (environment variables or EC2/ECS meta data if no env vars)" 
    * Enter "false" to Enter AWS credentials in the next step.
* Q: "Option access_key_id. AWS Access Key ID."
    * Enter your "access" key from the openstack config !
* Q: "Option secret_access_key.AWS Secret Access Key (password). "
    * Enter your "secret" key from the openstack config !
* Q: "Option region. Region to connect to."
    * Leave blank, press Enter. There is no region.
* Q: "Option endpoint. Endpoint for S3 API.Required when using an S3 clone"
    * Enter "https://object-arbutus.cloud.computecanada.ca" for Arbutus Openstack here.
* Q: "Option location_constraint. Location constraint - must be set to match the Region."
    * Leave blank, press Enter. 
* Q: "Option acl.Canned ACL used when creating buckets and storing or copying objects."
    * Leave blank, press Enter for the default (private)
* Q: "Edit advanced config?"
    * Answer "n" for No
* Q: "Configuration complete. Keep this "ObjectStorageMy" remote?"
    * Answer "y" for Yes
* Q: "Current remotes:"
    * Answer "q" to quit if it lists all the remotes correctly.

If the configuration was successful, you should now have an rclone "remote" destination named ObjectStorageMy. The access credentials have been stored under your home directory, and you can begin using rclone from any SSH session on Grex.
To test the connection, run the following command (note the colon at the end — rclone follows a Microsoft-like naming convention for remotes, such as C: for a disk):

{{< highlight bash >}}
rclone lsd ObjectStorageMy:
{{< /highlight >}}

This command would connect to the remote, and list the buckets available on that remote, if any exist. 

### Using Rclone for Data Transfers to the ObjectStorage


As with other Grex [software](/software/#lmod), _rclone_'s module must be loaded before use. Once loaded, you can use commands like rclone ls to explore your configured “remote” endpoint directories, and rclone copy to transfer files to and from Object Storage, as shown in the example below:

{{< highlight bash >}}
module load rclone
# Working with remote endpoints.
rclone list remotes
rclone lsd ObjectStorageMy:
# Working with files and directories.
rclone ls ObjectStorageMy:/
rclone copy myfile.txt ObjectStorageMy:/mybucket/
rclone ls ObjectStorageMy:/mybucket
rclone copy ObjectStorageMy:/mybucket/myfile.txt myfile.bak
{{< / highlight >}}

Please refer to rclone [documentation](https://rclone.org/docs/) for more information and options. Rclone is an universal data transfer tool that can be used for a variety of storages. You can also refer to our OneDrive and Nextcloud documentation for using Rclone with those services.
 
### Using Rclone in OpenOnDemand

On Grex, [OpenOnDemand](/ood) supports Rclone connections automatically within the Files app. After completing the rclone config setup as described above, the ObjectStorageMy folder will appear as a mounted remote in the OOD interface for the user. The Rclone folder ObjectStorageMy will appear for the user after he performs the above __rclone config__ step. 


## Example: Uploading PointCloud data from Grex to Arbutus 

TBD

## External links
---

* [Arbutus object storage](https://docs.alliancecan.ca/wiki/Arbutus_object_storage)
* [Globus](https://docs.alliancecan.ca/wiki/Globus)
* [Rclone](https://rclone.org/docs/)

<!-- Changes and update:
* Last reviewed on: Aug 25, 2025.
-->
