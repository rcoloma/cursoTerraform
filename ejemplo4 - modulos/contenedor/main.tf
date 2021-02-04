# Modulo

terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "docker" {}

resource "docker_image" "imagen" {
  name = "${var.nombre_imagen}:${var.version_imagen}"
}

resource "docker_container" "contenedor" {
  name  = var.nombre_contenedor
  image = docker_image.imagen.latest
  
  dynamic "ports" {
    for_each = var.puertos_contenedor
    content{
      internal = ports.value["interno"]
      external = ports.value["externo"]
      protocol = ports.value["protocolo"]
    }
  }
}
