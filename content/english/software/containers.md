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

Linux Containers are means to isolate software dependencies from the base Linux operating system.  Several different Linux container engines exist, most notably [Docker](https://www.docker.com) which was first to emerge as the most popular tool in the DevOps community. 

Since then, a lot of work had been done by major Linux players like Google, RedHat and others to develop an open standard for container runtimes, which developed based on Docker, [OCI](https://opencontainers.org/).

There are HPC-specific container engines/runtimes that offer similar or equivalent functionality but allow for easier integration with shared Linux HPC systems. At the time of writing, the most widely used of them is the  [Singularity](https://sylabs.io/guides/3.11/user-guide/) container system, developed by a company called SyLabs, and its fork, a Linux Foundation project called [Apptainer](https://apptainer.org/). 
They are [compatible](https://apptainer.org/docs/user/latest/singularity_compatibility.html) with each other. Singularity/Apptainer provides functionality for running most Docker images by converting them to the Singularity Image format (SIF). However, Singularity/Apptainer own format is [not completely OCI-compatible](https://apptainer.org/docs/user/latest/docker_and_oci.html#differences-and-limitations-vs-docker), so there exists Docker images that would not work properly. 

Finally, recent developments in Linux Kernel namespaces allowed to happen such projects as "rootless Docker" and "rootless [Podman](https://podman.io)" which are more suitable for HPC systems than the original Docker implementation which requires privileged access to the Linux system.

On Grex, Sylabs Singularity-CE is supported on local SBEnv software stack, while Apptainer is supported as part of the ComputeCanada/Alliance CCEnv stack. At the time of writing, these engines can be used largely interchangeably.

> New: There is also support for rootless Podman on Grex, for the use cases that require full OCI-compatibility. 

## Using Singularity from SBEnv on Grex
---

A brief introduction on [getting started with Singularity](https://docs.sylabs.io/guides/latest/user-guide/quick_start.html) can be useful to get started. You will not need to install Singularity on Grex since it is already provided as a module.

Start with __module spider singularity__; it will list the current version. Due to the nature of container runtime environments, we update Singularity regularly, so the installed version is usually the latest one. Load the module (in the default Grex environment) by the following command:

{{< highlight bash >}}
module load singularity
{{< /highlight >}}

With **singularity** command, one can list singularity commands and their options:

{{< highlight bash >}}
singularity help
{{< /highlight >}}

To execute an application within the container, do it in the usual way for that application, but prefix the command with __singularity exec image_name.sif__ or, if the container has a valid _entry point_, execute it with __singularity run image_name.sif__. 

{{< highlight bash >}}
singularity run docker://ghcr.io/apptainer/lolcow
{{< /highlight >}}

In the example above, Singularity downloads a Docker image from a registry, and runs it instantly. It is advisable, to avoid getting banned by container registries for massive downloads off a single HPC system, to "pull" or "build" containers first as images, and then "run" and "exec" them locally.

{{< highlight bash >}}
singularity pull lolcow_local.sif docker://ghcr.io/apptainer/lolcow
# The above should create a local image lolcow_local.sif 
# Lets run it with singularity
singularity run lolcow_local.sif
{{< /highlight >}}

For another example, to run R on an R script, using an existing container image named R-INLA.sif (INLA is a popular R library installed in the container):

{{< highlight bash >}}
singularity exec ./R-INLA.sif R --vanilla < myscript.R
{{< /highlight >}}
 
Quite often, it is necessary to provide the containerized application with data residing outside of the container image. For running HPC jobs, the data usually resides on a shared filesystem such as __/home__ or __/project__. This is done via [bind mounts](https://docs.sylabs.io/guides/latest/user-guide/bind_paths_and_mounts.html). Normally, the container **bind-mounts** $HOME, /tmp and the current working directory. It is possible to mount a subdirectory, such as _$PWD/workdir_, or an entire filesystem such as _/project_. 
Example below bind-mounts a __./workdir__ folder relative to the current path. The folder must exist before being bind-mounted.

{{< highlight bash >}}
singularity exec -B `pwd`/workdir:/workdir ./R-INLA.sif R --vanilla < myscript.R
{{< /highlight >}}

In case you do not want to mount anything to preserve the containers' environment from any overlapping of data/code from say $HOME, use the __-\-containall__ flag.

Some attention should be paid to Singularity's local cache and temporary directories. Singularity caches the container images it pulls and Docker layers under __$HOME/.singularity__. Containers can be large, in tens of gigabytes, and thus they can easily accumulate and exhaust the users' storage space quota on $HOME. Thus, users might want to set the __SINGULARITY_CACHEDIR__ and __SINGULARITY_TMPDIR__ variables to some place under their __/global/scratch__ space.

For example, to change the location of __SINGULARITY_CACHEDIR__ and __SINGULARITY_TMPDIR__, before building the singularity image, one might run:

{{< highlight bash >}}
mkdir -p /global/scratch/$USER/singularity/{cache,tmp}
export SINGULARITY_CACHEDIR="/global/scratch/$USER/singularity/cache"
export SINGULARITY_TMPDIR="/global/scratch/$USER/singularity/tmp"
{{< /highlight >}}


### Getting and building Singularity images
---

The commands __singularity build__ and/or __singularity pull__ would get pre-built Singularity images from DockerHub, SingularityHub, or SyLabsCloud. “pulling” images does not require elevated permissions (that is, sudo). There are several kinds of container repositories from which containers can be pulled. These repositories are distinguished by the URI string (library://, docker://, oras://, etc.)

{{< highlight bash >}}
module load singularity
# Building Ubuntu image using Sylabs Library
singularity build ubuntu_latest0.sif library://ubuntu
# or using DockerHub, this will create ubuntu_latest.sif
singularity pull docker://ubuntu:latest
{{< /highlight >}}

Singularity (SIF) images can also be built from other local images, local “sandbox” directories, and from recipes. A [Singularity recipe or definition file](https://apptainer.org/docs/user/main/definition_files.html) is a text file that specifies the base image and post-install commands to be performed on it. However, Singularity-CE requires _sudo_ (priviliged) access to build images from recipes, which is not available for users of HPC machines. There are two solutions to this problem.

 * Using remote build on Sylabs cloud with _\-\-remote_ option. This requires [setting up a free account on Sylabs and getting access key](https://cloud.sylabs.io/builder). 
 * Using Apptainer with _\-\-fakeroot_ option (see below) instead of Singularity-CE .

> Make sure you understand licensing and intellectual property implications before using remote build services!
The second (_fakeroot_) method appears to be easier and does not require an external account. 

### Singularity with GPUs
---

Use the __-\-nv__ flag to __singularity__ run/exec/shell commands. Naturally, you should be on a node that has a GPU, in an interactive job. NVIDIA provides many pre-built Docker and Singularity container images on their [GPU cloud](https://ngc.nvidia.com/), together with instructions on how to pull them and to run them. NVidia's NGC Docker images should, as a rule, work on HPC machines with Singularity without any changes.

### Singularity with OpenScienceGrid CVMFS
---

We can run Singularity containers distributed with OSG CVMFS which is currently mounted on Grex's CVMFS. The containers are distributed via CVMFS as unpacked directory images. So, the way to access them is to find a directory of interest and point singularity runtime to it. The directories will then be mounted and fetched automatically. The repository starts with __/cvmfs/singularity.opensciencegrid.org/__. Then you'd need an idea from somewhere what you are looking for in the subdirectories of the above-mentioned path. An example (accessing, that is, exploring via __singularity shell__ command, Remoll software distributed through OSG CVMFS by __jeffersonlab__):

{{< highlight bash >}}
module load singularity
singularity shell /cvmfs/singularity.opensciencegrid.org/jeffersonlab/remoll\:develop
{{< /highlight >}}

It looks like the list of what is present on the OSG CVMFS is on GitHub: [OSG GitHub docker images](https://github.com/opensciencegrid/cvmfs-singularity-sync/blob/master/docker_images.txt) .

## Using Apptainer from CCEnv on Grex
---

The Alliance's (formerly ComputeCanada) software stack now provides Apptainer modules in the two latest Standard Environments, _StdEnv/2020_ and _StdEnv/2023_. Most recent Apptainer versions (1.2.4 and older) do not require "suexec" and thus can be used off the CVMFS as usual. The only caveat would be to first unload any "singularity" or "apptainer" modules from other software stacks by _module purge_. Apptainer on the CCEnv stack is installed in suid-less mode.

The following commands show how to run the image from the previous example _/R-INLA.sif_:

{{< highlight bash >}}
module purge
module load CCEnv
module load arch/avx512 
module load StdEnv/2023
module load apptainer
# testing if apptainer command works
apptainer version
# running the basic example
apptainer run docker://ghcr.io/apptainer/lolcow
{{< /highlight >}}

Similarly to Singularity, you will need to bind mount the required data directories for accessing data outside the container. 
The same best practices mentioned above for Singularity (pulling containers beforehand, controlling the cache location) equally apply for the Apptainer. The environment variables for Apptainer should be using APPTAINER_ instead of SINGULARITY_ prefixes.

### Building apptainer images with "fakeroot"

Apptainer supports building of SIF images from recipes without __sudo__ access using __-\-fakeroot__ option where available.

On Grex, it can be used as in the following example:

{{< highlight bash >}}
module purge
module load CCEnv
module load StdEnv/2023
module load apptainer
# testing if apptainer command works
apptainer version
# build an image, INLA, from a local Singularity.def recipe
# --fakeroot makes the build possible without elevated access
apptainer build --fakeroot INLA.sif Singularity.def
{{< /highlight >}}

The resulting SIF image should be compatible with either Singularity-CE or Apptainer runtimes.

## Using Podman from SBEnv on Grex
---

[Podman](https://podman.io/) modules are now provided under the default Grex SBEnv environment. On Grex, Podman is configured as _rootless_. Podman is meant to be used by experienced users for jobs that cannot be executed as regular binaries, or through Singularity due to OCI requirements. Grex is an HPC systems, so it is expected that users would be using Podman to run compute jobs rather than persistent services (including and not limited to databases, and network services). Thus, Podman jobs and/or running Podman containers that deemed to be inappropriate for HPC may be terminated without notice.

It is forbidden to run Podman on login nodes; it must be run only on compute nodes (e.g. using __sbatch__ or __salloc__).

The only allowed use on login nodes is to pull images before actually starting a job.

Access to the Podman runtime is through a module. Due to the nature of the container runtime environment, we strive to update Podman regularly, so in most cases, the latest installed version must be used:

{{< highlight bash >}}
module load podman
podman version
podman run --rm docker.io/godlovedc/lolcow
{{< /highlight >}}

The above command would pull a container image and run it. 


### Getting and Managing Podman images
---

When using Podman to run a job, we suggest to manually pre-download the required image to avoid wasting time during the job. 
Grex is hosting a Docker Registry proxy/cache locally to improve the download performance, and for avoiding rate limits that can be imposed by various container registries.

{{< highlight bash >}}
module load podman
podman pull _required_image_
{{< /highlight >}}

The command **podman pull _image_name_** would get Podman images from a container registry. 
Images can also be built from other images, or from containerfiles (e.g. Dockerfiles) using the command **podman build _Containerfile_**. 
A _containerfile_ is a text "recipe" that specifies the base image and commands to be run on it. Podman's recipes are compatible with Docker's _Dockerfiles_.

Podman, as configured on Grex, by default would store all pulled and locally built images inside the Slurm TMPDIR directory. This means that images will be deleted when the job finishes, or get cancelled. To avoid rebuilding the same image every time the job runs, users can take advantage of **podman save** and **podman load** commands (it is the user's responsibility to manage their Podman images (delete the old/unused ones)):

{{< highlight bash >}}
# after building an image locally, save it to a file
podman save --format=docker-archive -o ${HOME}/my-local-image.tar _locally_built_image_name_
# when running a job that needs that image, load it
podman load -i ${HOME}/my-local-image.tar
{{< /highlight >}}

To manage images, users can take advantage of the following commands:

{{< highlight bash >}}
# list images
podman image ls
# delete an unnecessary image
podman image rm <IMAGE_ID>
{{< /highlight >}}

### Podman with GPUs
---

Use the __-\-device=nvidia.com/gpu=all__ flag when running a podman container. Naturally, you should be on a node that has a GPU. 
NVIDIA provides many pre-built Docker container images on their [NGC Cloud](https://ngc.nvidia.com/), together with instructions on how to pull and run them. Podman would usually run Docker containers without changes to the command line parameters.

---

## External links
---

 * [Singularity/Sylabs homepage](https://sylabs.io)
 * [Apptainer homepage](https://apptainer.org/)
 * [Podman homepage](https://podman.io/)
 * [Singularity documentation on the Alliance Wiki](https://docs.alliancecan.ca/wiki/Singularity) 
 * [Apptainer documentation on the Alliance Wiki](https://docs.alliancecan.ca/wiki/Apptainer)
 * [Docker Hub](https://hub.docker.com)
 * [RedHat Quay.io Hub](https://quay.io/search)
 * [Sylabs Cloud](https://cloud.sylabs.io/builder)
 * [NVIDIA NGC Cloud](https://ngc.nvidia.com/)

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last revision: Jan 16, 2024. 
-->
