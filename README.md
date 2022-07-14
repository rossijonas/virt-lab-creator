<h1 align="center">virt-lab-creator</h1>

*<p align="center">Build a home lab by using Terraform's `dmacvicar/libvirt` provider to create multiple VMs of a chosen Linux OS all at once.</p>*

## About

This repository helps to quickly create and destroy a home lab of virtual machines that may be used to study, play, and testing purposes.

Let's say you need to create 4 RHEL VMs to practice for the RHCSA exam, or you need to create 3 Rocky Linux VMs to learn Ansible and test playbooks, create it with `terraform apply` and quickly destroy all resources when finished `terraform destroy`.

For each home lab created:

- A default network interface is created and started in each VM.

- A default `admin` user with `sudo` privileges is created in each VM.

- The Pool, Volumes, and `cloud-init` disks created will be stored in the `/home/<user>/libvirt_storage/` directory.

## Requirements

- The hardware must support virtualization and must have enough memory, cpu, and storage to hold desired VMs pretended.

- A Linux OS with [Virtual Machine Manager](https://virt-manager.org) and [Terraform](https://www.terraform.io/) installed.

- A generic cloud `qcow2` image of the desired OS for the VM. This repository was tested and proven to work with the following images:

  - `Rocky-8-GenericCloud.latest.x86_64.qcow2` - [Rocky Linux 8 "Geneneric Cloud / Open Stack"](https://rockylinux.org/alternative-images)
  - `Fedora-Cloud-Base-36-1.5.x86_64.qcow2` - [Fedora 36 Cloud Base images "Cloud Base qcow2 image"](https://alt.fedoraproject.org/cloud/)
  - `rhel-8.6-x86_64-kvm.qcow2` - [Red Hat Enterprise Linux for x86_64 "Red Hat Enterprise Linux 8.6 KVM Guest Image"](https://access.redhat.com/downloads/content/479/ver=/rhel---8/8.6/x86_64/product-software) *(login with free subscription)*

  *Look for an image named "Cloud Based", "Generic Cloud / Open Stack", "KVM Guest Image", or something similar on the chosen OS's downloads page.*

## How To Use

1.  Clone or download this repository.

2.  Create a directory named `images/` inside the repository directory, download the chosen Linux OS image, and save it inside the `images/` directory.

3.  Edit the `variables.tf` file providing the specifications desired for your home lab.

4.  Set up the home lab as you wish. Inside the repository directory, run:

    - `terraform init` - to initiate and download required providers.

    - `terraform validate` - to double check for any unintentional edit.

    - `terraform plan` - to inspect what will be created.

5.  Run `terraform apply -auto-approve` to create the home lab.

6.  Open Virtual Machine Manager, start manually start any newly created VM, and log in with the default credentials:

    user: `admin` / password: `adminpwd`

7.  Destroy the lab with: `terraform destroy -auto-approve`

**To create a second home lab just download or clone the repository again into another directory, and repeat the steps above.** 
