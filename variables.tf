variable "proxmox_api_url" {}
variable "token_id" {}
variable "token_secret" {}

variable "node" {
  default = "prox"
}

variable "image_file_id" {
  description = "Proxmox file ID of the PA-VM disk image. Format: datastore-id:import/filename.qcow2"
  type        = string
  default     = "local:import/PA-VM-KVM-11.0.0.qcow2"
}