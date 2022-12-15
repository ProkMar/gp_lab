terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.13"
    }
  }

}

provider "yandex" {
  token     = var.yandex_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

variable "yandex_token" {
  description = "yandex token"
  type        = string
}

variable "cloud_id" {
  description = "yandex cloud id"
  type        = string
}

variable "folder_id" {
  description = "yandex folder id"
  type        = string
}

variable "zone" {
  description = "yandex zone name"
  type        = string
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-main.network_interface.0.ip_address
}
output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-main.network_interface.0.nat_ip_address
}

# main
resource "yandex_compute_instance" "vm-main" {
  name = "mdv"
  resources {
    cores  = 4
    memory = 4
  }
  boot_disk {
    initialize_params {
      image_id = "fd8tu6o3jf12drrfnob4"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    user-data = "${file("C:/Users/prokm/GP/gp_lab/terraform/meta.txt")}"
  }
}

# host1
resource "yandex_compute_instance" "vm-host1" {
  name = "sdw1"
  resources {
    cores  = 4
    memory = 4
  }
  boot_disk {
    initialize_params {
      image_id = "fd8tu6o3jf12drrfnob4"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    user-data = "${file("C:/Users/prokm/GP/gp_lab/terraform/meta.txt")}"
  }
}

# host2
resource "yandex_compute_instance" "vm-host2" {
  name = "sdw2"
  resources {
    cores  = 4
    memory = 4
  }
  boot_disk {
    initialize_params {
      image_id = "fd8tu6o3jf12drrfnob4"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    user-data = "${file("C:/Users/prokm/GP/gp_lab/terraform/meta.txt")}"
  }
}


resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}