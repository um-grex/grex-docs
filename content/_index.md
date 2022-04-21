---
title: Introduction
type: docs
bookTOC: true
---

**Spring Workshop: UManitoba HPC resources, and jobs optimization workshop**

Please join us at the Research Computing online Workshop dedicated to news, updates and effective use of UManitoba’s local HPC supercomputer, Grex. The workshop will be held in two sessions May 4, 5 at 10:30 AM- 1:00 PM, Winnipeg time. It is open for all UManitoba users.

{{< hint info >}}
* May 4, 2022: Updates on Grex HPC machine status, new hardware and services. Updates on local RAC. Introductory how-to using HPC machines, Using GPUs / contributed systems on Grex.    
* May 5, 2022: HPC software overview and best practices, Using OOD Web portal on Grex, Roundtable, Q/A    
{{< /hint >}}

Register [here](https://www.eventbrite.ca/e/umanitoba-hpc-resources-and-jobs-optimization-workshop-tickets-325012801037)

# Grex

Grex is a UManitoba High Performance Computing (HPC) system, first put in production in early 2011 as part of [WestGrid](https://www.westgrid.ca/ "WestGrid") consortium. "Grex" is a _Latin_ name for "herd" (or maybe "flock"?). The names of the Grex login nodes ([bison](https://en.wikipedia.org/wiki/Bison "Bison"), tatanka, [aurochs](https://en.wikipedia.org/wiki/Aurochs "Aurochs"), [yak](https://en.wikipedia.org/wiki/Yak "Yak")) also refer to various kinds of bovine animals.

![HPCC](grex-room-2020.png)

Since being defunded by WestGrid (on April 2, 2018), Grex is now available only to the users affiliated with University of Manitoba and their collaborators. The old WestGrid documentation, hosted on the [WestGrid website](https://www.westgrid.ca "WestGrid") became irrelevant after the Grex upgrade, so please visit [Grex's New Documentation](./docs/grex). Thus, if you are an experienced user in the previous "version" of Grex, you might benefit from reading this document: [Description of Grex changes](./docs/longread/). If you are a new Grex user, proceed to the quick start guide and documentation right away.

## Hardware 

The orihginal Grex was an SGI Altrix machine, with 312 compute nodes (Xeon 5560, 12 CPU cores and 48 GB of RAM per node) and QDR 40 Gb/s Infiniband network. In 2017, a new Seagate **Storage Building Blocks** based Lustre filesystem of **418 TB** of useful space was added to Grex. In 2020 and 2021, the University added several modern Intel CascadeLake CPU nodes, a few GPU nodes, a new NVME storage for home directories, and EDR Infiniband interconnect. So, the current computing hardware available for general use is as follows:

{{< hint info >}}
- 12 [ __40 core Intel CPU__ ] nodes, 384 GB RAM, EDR 100GB/s IB interconnect
- 43 [ __52 core Intel 6230R__ ] nodes, 96 GB RAM, EDR 100GB/s IB interconnect
- 2 [ __4xV100 NVLINK, 32 core Intel 5218 CPUs__ ] GPU nodes, 192 GB RAM, FDR 56GB/s IB interconnect
- Original Grex (**slated for decommission in Spring 2022**) Xeon 5560, 12 CPU cores, 48 GB of RAM, QDR 40GB/s IB interconnect
{{< /hint >}}

There are also  several researcher-contributed nodes (CPU and GPU) to Grex which make it a "community cluster". The researcher-contributed nodes are available for others on opportunistic basis; the owner groups will preempt the others' workloads.

Grex's compute nodes have access to two filesystems: 

{{< hint info >}}
- __/home__ filesystem, NFSv4/RDMA, **15 TB** total usable, 100 GB / user quota.
- __/global/scratch__ filesystem, Lustre, **418 TB** total usable, 4 TB / user quota.
{{< /hint >}}

There is a **10 GB/s** Ethernet connection between Grex and WestGrid's network.

## Software

Grex is a traditional HPC machine, running CentOS Linux under SLURM resource management system.

## Useful links

{{< columns >}}
{{< button href="https://docs.computecanada.ca/wiki/Compute_Canada_Documentation" >}}Compute Canada{{< /button >}}
<--->
{{< button href="https://grex-status.netlify.app" >}}Grex Status Page{{< /button >}}
<--->
{{< button relref="/docs/grex"  >}}Grex Documentation{{< /button >}}
<--->
{{< button relref="/docs/localit"  >}}Local Resources at UManitoba{{< /button >}}
{{< /columns >}}
