output "vms" {
  value = { for k, vm in libvirt_domain.vm : k => vm.name }
}
