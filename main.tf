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
  path = "/home/${var.user_name}/libvirt_storage"
}

# Create Volume
resource "libvirt_volume" "qcow2" {
  for_each = local.vm_ids

  name   = "${each.value}.qcow2"
  pool   = libvirt_pool.virt_lab.name
  source = "assets/${var.source_image}"
  format = "qcow2"
}

resource "libvirt_cloudinit_disk" "commoninit" {
  for_each = local.vm_ids

  name      = "${each.value}_commoninit.iso"
  pool      = libvirt_pool.virt_lab.name
  user_data = data.template_file.user_data.rendered
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

# Create VM
resource "libvirt_domain" "vm" {
  for_each = local.vm_ids

  name       = each.value
  memory     = var.vm_memory
  vcpu       = var.vm_vcpu
  running    = var.vm_running
  qemu_agent = true
  cloudinit  = libvirt_cloudinit_disk.commoninit[each.key].id

  disk {
    volume_id = libvirt_volume.qcow2[each.key].id
  }

  network_interface {
    network_name   = "default"
    wait_for_lease = true
  }
}
