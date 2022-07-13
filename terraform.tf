terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = ">=0.6.14"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.3.2"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

