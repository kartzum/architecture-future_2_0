variable "yc_token" {
  description = "OAuth-токен для доступа к Yandex Cloud"
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "Идентификатор облака"
  type        = string
}

variable "yc_folder_id" {
  description = "Идентификатор каталога"
  type        = string
}

variable "zone" {
  description = "Зона доступности"
  type        = string
  default     = "ru-central1-a"
}

variable "instance_name" {
  description = "Имя виртуальной машины"
  type        = string
  default     = "my-vm"
}

variable "instance_cores" {
  description = "Количество ядер CPU"
  type        = number
  default     = 2
}

variable "instance_memory" {
  description = "Объём RAM в ГБ"
  type        = number
  default     = 2
}

variable "disk_size" {
  description = "Размер дополнительного диска в ГБ"
  type        = number
  default     = 8
}

variable "subnet_cidr" {
  description = "CIDR подсети"
  type        = string
  default     = "10.0.1.0/24"
}
