variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "prefix" {
  description = "Prefix used for resource names"
  type        = string
  default     = "tetris-demo"
}

variable "admin_username" {
  description = "Linux VM admin username"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key contents"
  type        = string
  sensitive   = true
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B1s"
}
