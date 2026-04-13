# Получаем образ Ubuntu
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

# Сеть
resource "yandex_vpc_network" "network" {
  name = "${var.instance_name}-network"
}

# Подсеть в указанной зоне
resource "yandex_vpc_subnet" "subnet" {
  name           = "${var.instance_name}-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.subnet_cidr]
}

# Дополнительный диск для данных
resource "yandex_compute_disk" "additional" {
  name     = "${var.instance_name}-disk"
  type     = "network-hdd"
  zone     = var.zone
  size     = var.disk_size
  image_id = ""
}

# Виртуальная машина
resource "yandex_compute_instance" "vm" {
  name        = var.instance_name
  zone        = var.zone

  resources {
    cores  = var.instance_cores
    memory = var.instance_memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 8
      type     = "network-hdd"
    }
  }

  # Подключаем дополнительный диск
  secondary_disk {
    disk_id = yandex_compute_disk.additional.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  labels = {
    project     = "future_2_0"
    environment = "dev"
  }
}
