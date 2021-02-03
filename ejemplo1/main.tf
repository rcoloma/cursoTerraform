terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            #Le estoy diciendo que se traiga el plugin de docker
        }
    }
}

provider "docker" { }

resource "docker_image" "imagen-ubuntu" {
    //Nombre de la imagen de docker con el tag
    name = "${var.nombre_imagen}:${var.version_imagen}" 
} 

/*
    Creacción de un contenedor
*/
resource "docker_container" "contenedor-ubuntu" {
  name      = "mi_contenedor_ubuntu"
  image     = docker_image.imagen-ubuntu.latest
  /*
    2 volumenes dentro del contenedor:
    HOST
    /home/ubuntu/environment/cursoTerraform > /cursoTerraform
    /home/ubuntu/environment/ivan > /ivan
  */
  dynamic "volumes" {
    for_each = var.volumenes
    content {
        host_path       = volumes.value["host_path"]
        container_path  = volumes.value["container_path"]
        read_only       = volumes.value["read_only"]
        //volume_name     = contains( keys(volumes.value), "volume_name") ? volumes.value["volume_name"] : null
        volume_name     = lookup(volumes.value, "volume_name", null)
    }
  }
  command   = ["bash" , "-c", "sleep 1m"]
  logs      = true
}