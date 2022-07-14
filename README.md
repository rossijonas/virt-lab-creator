<h1 align="center">virt-lab-creator</h1>

*<p align="center">Build a home lab by using Terraform's `dmacvicar/libvirt` provider to create multiple VMs of a choosen Linux OS all at once.</p>*

## About

This repository help to quickly create and destroy a home lab of virtual machines that may be used to study, play and testing purposes.

Let's say you need to create 4 RHEL VMs to practice for the RHCSA exam, or you need to create 3 Rocky Linux VMs to learn Ansible and test playbooks, create it with `terraform apply` and quickly destroy all resources when finished `terraform destroy`.

For each virtual machine created:

- A default network interface is created and started.
- A default `admin` user with `sudo` privileges is created.

## Requirements

- The hardware must support virtualization and must have enough memory, cpu and storage to hold desired VMs pretended.

- A Linux OS with [Virtual Machine Manager](https://virt-manager.org) and [Terraform](https://www.terraform.io/) installed.

- A generic cloud `qcow2` image of the desired OS for the VM. This repository was tested and proven to work with the following images:

  - `Rocky-8-GenericCloud.latest.x86_64.qcow2` - [Rocky Linux 8 "Geneneric Cloud / Open Stack"](https://rockylinux.org/alternative-images)
  - `Fedora-Cloud-Base-36-1.5.x86_64.qcow2` - [Fedora 36 Cloud Base images "Cloud Base qcow2 image"](https://alt.fedoraproject.org/cloud/)
  - `rhel-8.6-x86_64-kvm.qcow2` - [Red Hat Enterprise Linux for x86_64 "Red Hat Enterprise Linux 8.6 KVM Guest Image"](https://access.redhat.com/downloads/content/479/ver=/rhel---8/8.6/x86_64/product-software) *(login with free subscription)*

  *The image could be named "Cloud Based", "Generic Cloud / Open Stack", "KVM Guest Image", or something similar at the choosen OS's downloads page.*

## How To Use

1.  clone od download

2.  define the variables

3.  init terraform and review config (validate/fmt/plan)

4.  apply (machines are created to offline state to prevent using RAM)

5.  open virt manager / start / login with default user

6.  destroy
