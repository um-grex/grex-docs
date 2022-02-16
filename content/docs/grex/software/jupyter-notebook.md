---
title: Using JuPyTer Notebooks
weight: 71
---

# Jupyter on Grex

[Jupyter](https://jupyter.org/) is a Web-interface aimed to support interactive data science and scientific computing. Jupyter supports several dynamic languages, most notably Python, R and Julia. Jupyter offers a metaphor of "computational document" that combines code, data and visualizations, and can be published or shared with collaborators.

Jupyter can be used either as a simple, individual notebook or as a multi-user Webserver/Interactive Development Environment (IDE), such as JupyterHub/JupyterLab. The JupyterHub servers can use a variety of computational back-end configurations: from free-for-all shared workstation to job spawning interfaces to HPC schedulers like SLURM or container workflow systems like Kubernetes.

This page lists examples of several ways of accessing Jupyter.

## Using Notebooks via SSH tunnel and interactive jobs

Any Python installation that has Jupyter notebooks installed can be used for the simple notebook interface. 
Most often, activity on login nodes of HPC systems is limited, so first an interactive batch job should be started.
Then, in the interactive job, users would start jupyter notebook server and use SSH tunnel to connect to it from a local Web browser.

{{< expand "Details and Example for Grex" >}}

After loggin on to Grex as usual, issue the following __salloc__ command to start an interactive job:

{{< hint slurm >}}
  ``salloc --partition=compute --nodes=1 --ntasks-per-node=2 --time=0-3:00:00``
{{< /hint >}}

It should give you a command prompt on a compute node. (change parameters like __partition__, __time__, ... etc. to your needs). Then, make sure that a Python module is loaded and Jupyter is installed, either in the Python or in a virtualenv, lets start a Notebook server, using an arbitrary port 8765. If the port is already in use, pick another number.

{{< hint info >}}
 ``jupyter-notebook --ip 0.0.0.0 --no-browser --port 8765``
{{< /hint >}}

If succesfull, there should be _http://g333:8675/?token=ae348acfa68edec1001bcef58c9abb402e5c7dd2d8c0a0c9_ or similar, where g333 is a compute node it runs, 8675 is a local TCP port and token is an access token. Now we have Jupyter notebook server running on the node, but how do we access it from our own browser? To that end, we will need an SSH tunnel.

Assuming a command line SSH client (OpenSSH or MobaXterm command line window), in a new tab or terminal issue the following:

{{< hint info >}}
  ``ssh -fNL 8765:g333:8765  youruser@bison.westgrid.ca``
{{< /hint >}}
  
Agan, g333, port 8765 and your user name in the example above should be changed to reflect the actual node and user!
When succesfull, the SSH command above returns nothing. Keep the terminal window open for as long as you need the tunnel.
Now, the final step is to point your browser (Firefox is the best as Chrome might refuse to do plain http://) to the
specified port on _localhost_ or 127.0.0.1, as in _http://localhost:8765_ or _http://127.0.0.1:8765_ . Use the token as per above to authenticate into the Jupyter notebook session, either copying it into the prompt or providing in the browser address line.
{{< /expand >}}

The notebook session will be usable for as long as the interactive (__salloc__) job is valid and both salloc session and the SSH tunnel connections stay alive. This usually is a limitation on for how long Jupyter notebook calculations can be, in practice.

The above mentioned method will work not only on Grex, but on Compute Canada systems as well.

## Using Notebooks via Grex OOD Web Portal

Grex provides Jupyter server as OnDemand Dashboard application. This is much more convenient than handling SSH tunnels manually. The servers will run as a batch job on Grex compute nodes, so as usual, a choice of SLURM partition will be needed. 

Presently, Jupyter for these apps uses an installation of Grex's Python 3.7 module. There are two versions of the app, one for the GCC 7.4 toolchain , another for Intel the 2019.5 toolchain. 

Find out more on how to use OOD on the [Grex OOD pages](../../ood)

To use R, Julia, and different instances or versions of Pyton, a Jupyter Notebook kernel needs to be installed by each user
in their home directories. Check out the corresponding ComputeCanada documentation [here](https://docs.computecanada.ca/wiki/JupyterNotebook#Adding_kernels) .

## Other Jupyter instances around

There is SyZyGy instance [umanitoba.syzygy.ca](https://umanitoba.syzygy.ca) that gives a free-for-all shared JupyterHub for UManitoba users.

Most of the Compute Canada HPC machines deployed JupyterHub as a job (Cedar, Beluga, Narval) or as a free-for-all shared server (Niagara).

