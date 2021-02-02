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
  logs      = true
  /*
2 volumenes dentro del contenedor:
HOST
/home/ubuntu/environment/cursoTerraform > /cursoTerraform
/home/ubuntu/environment/ivan > /ivan
*/ 
  volumes = {
    from_container  = "mi_contenedor_ubuntu"
    host_path       = "/home/ubuntu/environment/cursoTerraform"
    volume_name     = "cursoTerraform"
    container_path  = "/cursoTerraform"
    read_only       = true
    }
    volumes = {
    from_container  = "mi_contenedor_ubuntu"
    host_path       = "/home/ubuntu/environment/ivan"
    volume_name     = "ivan"
    container_path  = "/ivan"
    read_only       = true
    }
}