variable "pool_name" {
  # Changing pool_name triggers the destruction and re creation of the 
  # volumes and the vms.
  description = "Name of the pool that is going to store the volumes."
  type        = string
  default     = "virt_lab_pool" # change here
}

variable "user_name" {
  description = "Name of the local user applying the terraform configuration."
  type        = string
  default     = "rossijonas" # change here
}

variable "lab_size" {
  description = "Amount of VMs to build."
  type        = number
  default     = 3 # change here
}

variable "source_image" {
  description = "Filename of the downloaded system image"
  type        = string
  default     = "Rocky-8-GenericCloud.latest.x86_64.qcow2" # change here
}

variable "vm_memory" {
  description = "Amount of memory in each VM."
  type        = string
  default     = 2048 # change here
}

variable "vm_vcpu" {
  description = "Amount of vcpu in each VM."
  type        = number
  default     = 2 # change here
}

variable "vm_running" {
  description = "Specify if each VM powers on after terraform apply."
  type        = bool
  default     = false # change here
}
