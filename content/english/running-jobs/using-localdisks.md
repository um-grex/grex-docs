---
weight: 1750
linkTitle: "Using local disks"
title: "Using local disks: $TMPDIR"
description: "Everything you need to know about using local disks."
categories: ["Scheduler"]
banner: true
bannerContent: "__Work in progress.__"
#tags: ["Configuration"]
---

## Introduction
---

High-Performance Computing (HPC) systems, such as Grex, typically provide a shared, scalable, POSIX-compliant filesystem that is accessible by all compute nodes. 
For Grex and the current generation of Alliance HPC machines, this shared filesystem is powered by [Lustre FS](https://www.lustre.org/), which enables data sharing for compute jobs running on the cluster's nodes. Due to its scalable design, Lustre FS can offer significant bandwidth for large parallel jobs through its parallelized Object Storage Targets (OSTs).

However, there are situations where parallel filesystems like Lustre can experience performance issues. For instance, when handling a very large number (tens of thousands) of small files, such workloads can be taxing on "metadata operations" (e.g., opening and closing files), even though they don’t require high data bandwidth.

In some extreme cases, it may be beneficial to avoid using the shared parallel filesystem and instead utilize local disk storage. Local disks, particularly SSDs, are directly attached to the node and do not strain the Metadata Servers of the shared filesystem. This approach may improve the performance of jobs that involve large numbers of small files.

However, there are some limitations:

> * The node-local storage is temporary and will be deleted at the end of the SLURM job.
> * The node-local storage is limited by what is available at the node (usually about 100-200GB). Large datasets would still have to use the __/project__ filesystem.
> * The node-local storage is local to the node, and is not available for multi-node parallel computing jobs. Generally, it is not worth the trouble to try using local disks manually, across several nodes.

### Using temporarily directory for SLURM jobs

SLURM automatically creates a local temporary directory for each job. On Grex, the path to this directory is accessible to the job via the __TMPDIR__ environment variable.

On Alliance/Compute Canada systems, another environment variable, __SLURM_TMPDIR__, is set. Certain scripts within the CCEnv environment may expect this variable to be defined. If needed, it can be set as follows:

```export SLURM_TMPDIR=$TMPDIR ```

To use local storage for job's data, you should stage the data into the local storage at the start of the SLURM job and stage it out at the end. Assuming the data is stored in a subdirectory relative to the submission path, here’s an example workflow:

{{< highlight bash >}}
# Copy data to the local temporary directory:
cp -r ./my-data-directory $TMPDIR
pushd $TMPDIR

# Run software that uses the data:
# ...

popd

# Copy the data back from the local temporary directory
cp -rf $TMPDIR/my-data-directory .

{{< /highlight >}}

{{< alert type="warning" >}}
__Note:__ If possible, for a given software, it is advisable to direct output and checkpoint files to the parallel filesystem (e.g., /project). In case of job interruption (due to hardware failure or walltime expiration), data on the local disk will be lost.
{{< /alert >}}

## Using local scratch for particular software

Many codes provide a configuration option or an environment variable that determines, where to direct the temporary files.
In such cases, when the application software handles temporary files, it is sufficient to set the location to __$TMPDIR__.

Examples are Gaussian (```export GAU_SCRDIR=$TMPDIR```) , Quantum Espresso (```export ESPRESSO_TMPDIR=$TMPDIR```). 

## External links

* Alliance user documentation on [Using node local storage](https://docs.alliancecan.ca/wiki/Using_node-local_storage)

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Nov 6, 2024.
-->
