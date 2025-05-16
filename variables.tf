variable "image_name" {
  description = "Nom de l'image Docker à construire"
  type        = string
  default     = "bigagi-custom"
}

variable "container_name" {
  description = "Nom du container de l'application"
  type        = string
  default     = "terraforme-agent"
}

variable "app_name" {
  description = "Nom de l'application à injecter comme variable"
  type        = string
  default     = "Terraforme Agent"
}