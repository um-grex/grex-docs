---
weight: 1600
linkTitle: "Containers"
title: "Containers for Software"
description: "Everything you need to know before to use Singularity containers"
categories: ["Software", "Applications"]
#tags: ["Configuration"]
---

## Introduction
---

Linux Containers are means to isolate software dependencies from the base Linux operating system. 
<<<<<<< HEAD
On Grex, we support the [Singularity](https://docs.sylabs.io/guides/latest/user-guide/) container system (developed by a company called SyLabs), and [Podman](https://podman.io/).
There was a fork of the Singularity project that produced a new project called [Apptainer](https://apptainer.org/).
As of now (early 2024), Singularity-CE by Sylabs and Apptainer by Linux Foundations are using the same SIF image format and thus are largely the same with respect to their usage and main features.
Grex supports Singularity-CE, while National DRI (the Alliance) HPC machines like Cedar or Graham support Apptainer.
Both Grex and National DRI (the Alliance) HPC machines like Cedar or Graham support Podman.
=======
On Grex, we support the [Singularity](https://sylabs.io/guides/3.11/user-guide/) container system, developed by a company called SyLabs. 
There was a fork of the Singularity project that produced a new project called [Apptainer](https://apptainer.org/). 
As of early 2024, Singularity-CE by Sylabs and Apptainer by Linux Foundations are using the same SIF image format and thus are largely the same with respect to their usage and main features.

Grex supports Singularity-CE, while National DRI (the Alliance) HPC machines like Cedar or Graham support Apptainer. 
>>>>>>> main

Several different Linux container engines exist, most notably [Docker](https://www.docker.com) which is a very popular tool in the DevOps community. With Singularity it is possible to run Docker images from [DockerHub](https://hub.docker.com/), as well as native Singularity images from other repositories, such as [SingularityHub](https://singularity-hub.org/) and [SyLabsCloud](https://cloud.sylabs.io/home).

## Using Singularity from SBEnv on Grex
---

Start with __module spider singularity__; it will list the current version. Due to the nature of container runtime environments, we update Singularity regularly, so the installed version is usually the latest one. Load the module (in the default Grex environment) by the following command:

{{< highlight bash >}}
module load singularity
{{< /highlight >}}

With **singularity** command, one can list singularity commands and their options:

{{< highlight bash >}}
singularity help
{{< /highlight >}}

A brief introduction on [getting started with Singularity](https://docs.sylabs.io/guides/latest/user-guide/quick_start.html) can be useful to get started. You will not need to install Singularity on Grex since it is already provided as a module.

To execute an application within the container, do it in the usual way for that application, but prefix the command with ''singularity exec image_name.sif". For example, to run R on an R script, using a container named R-INLA.sif:

{{< highlight bash >}}
singularity exec ./R-INLA.sif R --vanilla < myscript.R
{{< /highlight >}}
 
Quite often, it is useful to provide the containerized application with data residing on a shared HPC filesystem such as __/home__ or __/global/scratch__. This is done via [bind mounts](https://docs.sylabs.io/guides/latest/user-guide/bind_paths_and_mounts.html). Normally, the container **bind-mounts** $HOME, /tmp and the current working directory. On Grex to bind the global Lustre filesystem the following __-B__ option should be used:

{{< highlight bash >}}
singularity exec -B /sbb/scratch:/global/scratch ./R-INLA.sif R --vanilla < myscript.R
{{< /highlight >}}

In case you do not want to mount anything to preserve the containers' environment from any overlapping of data/code from say $HOME, use the __-\-containall__ flag.

Some attention has to be paid to Singularity's local cache and temporary directories. Singularity caches the container images it pulls and Docker layers under __$HOME/.singularity__. Containers can be large, in tens of gigabytes, and thus they can easily accumulate and exhaust the users' storage space quota on $HOME. Thus, users might want to set the __SINGULARITY_CACHEDIR__ and __SINGULARITY_TMPDIR__ variables to some place under their __/global/scratch__ space.

For example, to change the location of __SINGULARITY_CACHEDIR__ and __SINGULARITY_TMPDIR__, one might run:

{{< highlight bash >}}
mkdir -p /global/scratch/$USER/singularity/{cache,tmp}
export SINGULARITY_CACHEDIR="/global/scratch/$USER/singularity/cache"
export SINGULARITY_TMPDIR="/global/scratch/$USER/singularity/tmp"
{{< /highlight >}}

before building the singularity image.

### Getting and building Singularity images
---

The commands **singularity build** and **singularity pull** would get Singularity images from DockerHub, SingularityHub or SyLabsCloud. Images can also be built from other images, and from recipes. A recipe is a text file that specifies the base image and post-install commands to be performed on it.

### Singularity with GPUs
---

Use the __-\-nv__ flag to singularity run/exec/shell commands. Naturally, you should be on a node that has a GPU, in an interactive job. NVIDIA provides many pre-built Docker and Singularity container images on their ["GPU cloud"](https://ngc.nvidia.com/), together with instructions on how to pull them and to run them. These should work on Grex without much changes.

### Singularity with OpenScienceGrid CVMFS
---

We can run Singularity containers distributed with OSG CVMFS which is currently mounted on Grex's CVMFS. The containers are distributed via CVMFS as unpacked directory images. So, the way to access them is to find a directory of interest and point singularity runtime to it. The directories will then be mounted and fetched automatically. The repository starts with __/cvmfs/singularity.opensciencegrid.org/__. Then you'd need an idea from somewhere what you are looking for in the subdirectories of the above-mentioned path. An example (accessing, that is, exploring via __singularity shell__ command, Remoll software distributed through OSG CVMFS by __jeffersonlab__):

{{< highlight bash >}}
module load singularity
singularity shell /cvmfs/singularity.opensciencegrid.org/jeffersonlab/remoll\:develop
{{< /highlight >}}

It looks like the list of what is present on the OSG CVMFS is on Github: [OSG Github docker images](https://github.com/opensciencegrid/cvmfs-singularity-sync/blob/master/docker_images.txt) .

## Using Apptainer from CCEnv on Grex
---
The Alliance's (formerly ComputeCanada) software stack now provides Apptainer modules in the two latest Standard Environments , _StdEnv/2020_ and _StdEnv/2023_. Most recent Apptainer versions (1.2.4 and older) do not require "suexec" and thus can be used off the CVMFS as usual. The only caveat would be to first unload any "singularity" or "apptainer" modules from other software stacks by _module purge_. 

The following commands show how to run the image from the previous example _/R-INLA.sif_:

{{< highlight bash >}}
module purge
module load CCEnv
module load arch/avx512 
module load StdEnv/2023
module load apptainer

apptainer version
apptainer run ./R-INLA.sif R --vanilla < myscript.R
{{< /highlight >}}

Similar to singularity, you will need to bind mount all the directories for accessing data outside the container.

<!--
apptainer run docker://ghcr.io/apptainer/lolcow
-->

## (Advanced) Using Podman from SBEnv on Grex
---

We provide [Podman](https://podman.io/) modules as part of the default Grex environment. Podman is meant to be used only by experienced users for jobs that cannot be executed as regular binaries, or through Singularity.

Under no circumstances, users are allowed to use Podman to run services (inclunding and not limited to databases, and network services). Ignoring this policy will result in the forced termination of the job.

Due to the nature of container runtime environment, we strive to update Podman regularly, so the installed version is usually the latest one.

On Grex, Podman is configured as _rootless_, and uses _crun_ to actually run the containers.

Users can load the module and get some infomration using the following commmand:

{{< highlight bash >}}
module load podman
podman version
podman run --rm docker.io/godlovedc/lolcow
{{< /highlight >}}

When using Podman to run a job, we suggest to manually pre-download the required image to avoid wasting time during the job:

{{< highlight bash >}}
ssh someuser@yak.hpc.umanitoba.ca
module load podman
podman pull _required_image_
{{< /highlight >}}

Replace _required_image_ by the URL where the image is located.

Grex is hosting a Docker Registry proxy/cache locally to improve performances, while avoiding rate limits imposed by the official Docker Hub. In the future, users who build their own images will be able to ask write access to the Grex Docker Registry to push their artifacts (this service is currently under development, and not publicly available).

### Getting and building Podman images
---

The command **podman pull _image_name_** would get Podman images from a Docker Registry. Images can also be built from other images, or from containerfiles (e.g. dockerfiles) using the command **podman build _containerfile_**. A _containerfile_ is a text file that specifies the base image and commands to be run on it.

### Podman with GPUs
---

Use the __-\-device=nvidia.com/gpu=all__ flag when running a podman container. Naturally, you should be on a node that has a GPU. NVIDIA provides many pre-built Docker container images on their [NGC Cloud](https://ngc.nvidia.com/), together with instructions on how to pull and run them. These should work on Grex without much changes.

---

## External links
---

 * [Singularity/Sylabs homepage](https://sylabs.io)
 * [Apptainer homepage](https://apptainer.org/)
 * [Podman homepage](https://podman.io/)
 * [Singularity documentation on the Alliance Wiki](https://docs.alliancecan.ca/wiki/Singularity) 
 * [Docker Hub](https://hub.docker.com)
 * [RedHat Quay.io Hub](https://quay.io/search)
 * [Sylabs Cloud](https://cloud.sylabs.io/builder)
 * [NVIDIA NGC Cloud](https://ngc.nvidia.com/)

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Apr 30, 2024.
-->
