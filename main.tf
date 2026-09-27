terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.77"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = "${var.token_id}=${var.token_secret}"

  insecure = true
}

resource "proxmox_virtual_environment_vm" "paloalto" {
  node_name = var.node
  vm_id     = 101
  name      = "PA-VM-KVM"

  started = true

  bios      = "ovmf"
  machine   = "q35"
  scsi_hardware = "virtio-scsi-single"

  cpu {
    cores = 2
    type  = "host"
  }

  memory {
    dedicated = 5632
  }

  agent {
    enabled = false
  }

  disk {
    datastore_id = "local"
    interface    = "scsi0"

    import_from = var.image_file_id

    iothread = true
    discard  = "on"
    size     = 60
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  serial_device {}

  operating_system {
    type = "l26"
  }
}