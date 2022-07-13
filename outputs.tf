output "vms" {
  value = { for k, vm in libvirt_domain.rocky_linux : k => vm.name }
}
