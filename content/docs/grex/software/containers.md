---
title: Containers for Software
weight: 40
---

# Introduction

Linux Containers are means to isolate software dependencies from the base Linux operation system. On Grex, we support the [Singularity](https://sylabs.io/guides/3.5/user-guide/) container system, now developed by a company called SyLabs. Several other Linux containers engines exist, most notably [Docker](https://www.docker.com) which is a very popular tool in DevOps community. Presently Docker containers cannot be directly supported on shared HPC systems like Grex. However, with help of Singularity, it is possible to run Docker images from the [DockerHub](https://hub.docker.com/), as well as native Singularity images from other repositories, such as [SingularityHub](https://singularity-hub.org/) and [SyLabsCloud](https://cloud.sylabs.io/home).

## Using Singularity on Grex

Start with __module spider singularity__; it will list the current version. Due to the nature of container runtime environments, we update Singularity regularly, so the installed version is usually the latest one. Load the module (in the default Grex environment) by the following command:

{{< hint info >}}
```module load singularity```
{{< /hint >}}

With **singularuty** command, one can list singularity commands and their options:

{{< hint info >}}
```module load singularity```

```singularity help```
{{< /hint >}}

A brief introduction on [getting started with Singularity](https://sylabs.io/guides/3.5/user-guide/quick_start.html) can be useful to get started. You will not need to install Singularity on Grex since it is already provided as module.

To execute an application within the container, do it in the usual way for that application, but prefix the command with ''singularity exec image_name.sif". For example, to run R on an R script, using a container named R-INLA.sif:

{{< hint info >}}
 ```singularity exec ./R-INLA.sif R --vanilla < myscript.R```
{{< /hint >}}
 
Quite often, it is useful to provide the containerized application with data residing on a shared HPC filesystem such as __/home__ or __/global/scratch__. This is done via [bind mounts](https://sylabs.io/guides/3.5/user-guide/bind_paths_and_mounts.html). Normally, the container **bind-mounts** $HOME, /tmp and the current working directory. On Grex to bind the global Lustre filesystem the following __-B__ option should be used:

{{< hint info >}}
```singularity exec -B /sbb/scratch:/global/scratch ./R-INLA.sif R --vanilla < myscript.R ```
{{< /hint >}}

In case you do not want to mount anything to preserve the containers' environment from any overalapping data/code from say $HOME, use the __-\-containall__ flag.

Some attention has to be paid to Singularity's local cache and temporary directories. Singularity caches the container images it pulls and Docker layers under __$HOME/.singularity__. Containers can be large, in tens of gigabytes, and thus they can easily accumulate and exhaust the users storage space quota on $HOME. Thus users might want to set the __SINGULARITY_CACHEDIR__ and __SINGULARITY_TMPDIR__ variables to some place under their __/global/scratch__ space.

For example, to change the location of __SINGULARITY_CACHEDIR__ and __SINGULARITY_TMPDIR__, ome might run:

{{< hint info >}}
```mkdir -p /global/scratch/$USER/singularity/{cache,tmp}```

```export SINGULARITY_CACHEDIR="/global/scratch/$USER/singularity/cache"```

```export SINGULARITY_TMPDIR="/global/scratch/$USER/singularity/tmp"```
{{< /hint >}}

before building the singularity image.

## Getting and building Singularity images

The commands **singularty build** and **singularity pull** would get Singularity images from DockerHub, SingularityHub or SyLabsCloud. Images can also be built from other images, and from recipes. A recipe is a text file that specifies the base image and post-install commands to be performed on it.

## Singularity with GPUs

Use the __-\-nv__ flag to singularity run/exec/shell commands. Naturally, you should be on a node that has a GPU, in an interactive job. NVIDIA provides many pre-built Docker and Singularity container images on their ["GPU cloud"](https://ngc.nvidia.com/), together with instructions on how to pull them and to run them. These should work on Grex without much changes.

## OpenScienceGrid CVMFS

We can run Singularity containers distributed with OSG CVMFS which is currenlly mounted on Grex's CVMFS. The containers are distributed via CVMFS as unpacked directory images. So the way to access them is to find a directory of interest and point singularity runtime to it. The directories will then be mounted and fetched automatically. The repository starts with __/cvmfs/singularity.opensciencegrid.org/__. Then you'd need an idea from somewhere what you are looking for in the subdirectories of the above mentioned path. An example (accessing, that is, exploring via __singularity shell__ command, Remoll software distributed trough OSG CVMFS by __jeffersonlab__):

{{< hint info >}}
```module load singularity```

```singularity shell /cvmfs/singularity.opensciencegrid.org/jeffersonlab/remoll\:develop ```
{{< /hint >}}

A partial description of what is present on OSG CVMFS is available [here](https://support.opensciencegrid.org/support/solutions/articles/12000024676-docker-and-singularity-containers).

## More information

 * [Singularity/Sylabs homepage](https://sylabs.io)
 * [Compute Canada Singularity documentation](https://docs.computecanada.ca/wiki/Singularity)
 * [Westgrid Singularity tutorial](https://westgrid.github.io/trainingMaterials/materials/singularity20210526.pdf), a recording can be found [here](https://westgrid.github.io/trainingMaterials/tools/virtual/)
 * [Docker Hub](https://hub.docker.com)
 * [Singularity Hub](https://ngc.nvidia.com/)
 * [Sylabs Cloud](https://cloud.sylabs.io/home)
 * [NVIDIA NGC cloud](https://ngc.nvidia.com/)
 * [OSG Helpdesk for Singularity](https://support.opensciencegrid.org/support/solutions/articles/12000024676-docker-and-singularity-containers)

