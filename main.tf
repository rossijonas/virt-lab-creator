# -----------------------------------------------------------------------------
# generate inputs
# -----------------------------------------------------------------------------

locals {
  pool_name = "${var.pool_name}_${random_string.lab_id.id}"
  vm_ids    = { for i in range(var.lab_size) : "vm_${i}" => "vm_${i}_${random_string.lab_id.id}" }
}

resource "random_string" "lab_id" {
  length  = 8
  special = false
  keepers = {
    # Generate new lab_id only when a new pool is created
    pool_name = "${var.pool_name}"
  }
}

# -----------------------------------------------------------------------------
# livbirt resources
# -----------------------------------------------------------------------------

# Create Pool
resource "libvirt_pool" "virt_lab" {
  name = local.pool_name
  type = "dir"
  path = "/home/${var.user_name}/virt_lab/storage"
}

# Create Volume
resource "libvirt_volume" "rocky_linux_qcow2" {
  for_each = local.vm_ids

  name = "rocky_linux_${each.value}.qcow2"
  pool = libvirt_pool.virt_lab.name
  # Download file from https://rockylinux.org/alternative-images
  # "Generic Cloud/Openstack" into ./assets/ directory (manually created).
  source = "./assets/Rocky-8-GenericCloud.latest.x86_64.qcow2"
  format = "qcow2"
}

# Create VM
resource "libvirt_domain" "rocky_linux" {
  for_each = libvirt_volume.rocky_linux_qcow2

  name    = trimsuffix(each.value.name, ".qcow2")
  memory  = var.vm_memory
  vcpu    = var.vm_vcpu
  running = var.vm_running

  disk {
    volume_id = each.value.id
  }
}
