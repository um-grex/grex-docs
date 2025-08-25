---
weight: 1800
linkTitle: "Servers"
title: "Servers"
description: "Everything you need to know about Servers: Jupyter, RStudio."
categories: []
tags: ["Interactive", "Visualization"]
---

## OpenOnDemand Servers
---

Using OOD, users can use RStudio, Jupyter, Code server ... etc.

All these applications work in the same way as for [Desktops](ood/desktops) in the previous section. In other terms, before launching these application, a user has to set some parameters or resources to use (like the accounting group, slurm partition, number of cpus, ...etc.) before launching the application. Once the job is granted, click on the link with name __Connect to ..._ to start the server. At the time of writing this documentation, Code server, Matlab Server, RStudio Server and JupeyterLab server are available.

### Code server

For development purposes, users can run code server using OOD. It runs as a job on compute node. After setting all the resources, use the link __Connect to Code Server__ to connect the server:

{{< collapsible title="Code Server: Connect" >}}
![Code Server Connect](/ood/code-server-connect.png)
{{< /collapsible >}}

Here is an example of snapshot that shows the xode server interface:

{{< collapsible title="Code Server: View" >}}
![Code Server View](/ood/code-server-view.png)
{{< /collapsible >}}

### Matlab Server

{{< collapsible title="Matlab Server: Connect" >}}
![Matlab Server Connect](/ood/matlab-server-connect.png)
{{< /collapsible >}}

{{< collapsible title="Matlab Server: View" >}}
![Matlab Server View](/ood/matlab-server-view.png)
{{< /collapsible >}}

### RStudio Server

{{< collapsible title="RStudio Server: Connect" >}}
![RStudio Server Connect](/ood/rstudio-server-connect.png)
{{< /collapsible >}}

{{< collapsible title="RStudio Server: View" >}}
![RStudio Server View](/ood/rstudio-server-view.png)
{{< /collapsible >}}

### JupeyterLab server

{{< collapsible title="JupyterLab Server: Connect" >}}
![JupyterLab Server Connect](/ood/jupyter-server-connect.png)
{{< /collapsible >}}

{{< collapsible title="JupyterLab Server: View" >}}
![JupyterLab Server View](/ood/jupyter-server-view.png)
{{< /collapsible >}}
   
<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Jul 04, 2025.
-->
