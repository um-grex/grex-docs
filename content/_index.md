---
title: Introduction
type: docs
bookTOC: true
---

# Grex

Grex is a UManitoba High Performance Computing (HPC) system, first put in production in early 2011 as part of [Westgrid](https://www.westgrid.ca/) consortium.  "Grex" is a Latin name for "herd" (or may be "flock"?). The names of the Grex login nodes (bison, tatanka, aurochs, yak) also refer to various kinds of bovine animals.

![](grex-room-2020.png)

Since being defunded by Westgrid (on April 2, 2018), Grex is now available only to the users affiliated with University of Manitoba and their collaborators. The old Westgrid documentation, hosted on the [Westgrid website](https://www.westgrid.ca) became irrelevant after the Grex upgrade, so please visit [Grex's New Documentation](/doc/docs/grex). Thus, if you are an experienced user in the previous "version" of Grex, you might benefit from reading this document: [Description of Grex changes](/doc/docs/longread/). If you are a new Grex user, proceed to the quick start guide and documentation right away.

## Hardware 

The orihginal Grex was an SGI Altrix machine, with 312 compute nodes (Xeon 5560, 12 CPU cores and 48 GB of RAM per node) and QDR 40 Gb/s Infiniband network. In 2017, a new Seagate **Storage Building Blocks** based Lustre filesystem of **418 TB** of useful space was added to Grex. In 2020 and 2021, the University added several modern Intel CascadeLake CPU nodes, a few GPU nodes, a new NVME storage for home directories, and EDR Infiniband interconnect. So, the current computing hardware available for general use is as follows:

- 12 40 core Intel CPU nodes, 384 GB RAM, EDR 100GB/s IB interconnect
- 43 52 core Intel 6230R nodes, 96 GB RAM, EDR 100GB/s IB interconnect
- 2 4xV100 NVLINK, 32 core Intel 5218 CPUs, 192 GB RAM, FDR 56GB/s IB interconnect
- Original Grex (slated for decommission in Spring 2022) Xeon 5560, 12 CPU cores , 48 GB of RAM, QDR 40GB/s IB interconnect

There are also  several researcher-contributed nodes (CPU and GPU) to Grex which make it a "community cluster". The researcher-contributed nodes are available for others on opportunistic basis; the owner groups will preempt the others' workloads.

Grex's compute nodes have access to two filesystems: 

- /home filesystem, NFSv4/RDMA, **15 TB** total usable, 100GB/user quota
- /global/scratch filesystem, Lustre, **418 TB** total usable, 4TB/user quota

There is a 10GB/s Ethernet connection between Grex and Westgrid's network.

## Software

Grex is a traditional HPC machine, running CentOS Linux under SLURM resource management system.

## Useful links

{{< columns >}}
{{< button href="https://docs.computecanada.ca/wiki/Compute_Canada_Documentation" >}}ComputeCanada{{< /button >}}
<--->
{{< button href="https://grex-status.netlify.app" >}}Grex Status Page{{< /button >}}
<--->
{{< button relref="/docs/grex"  >}}Grex Documentation{{< /button >}}
<--->
{{< button relref="/docs/localit"  >}}Local Resources at UManitoba{{< /button >}}
{{< /columns >}}
