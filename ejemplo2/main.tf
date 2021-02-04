terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            #Le estoy diciendo que se traiga el plugin de docker
        }
    }
}

provider "docker" { }

resource "docker_image" "imagen-nginx" {
    //Nombre de la imagen de docker con el tag
    name = "${var.nombre_imagen}:${var.version_imagen}" 
}

/*
resource "docker_container" "contenedor-nginx-solo" {
  name      = "mi_contenedor_nginx"
  image     = docker_image.imagen-nginx.latest
  logs      = true
  ports {
      internal  = 80
      external  = 8080
  }
}
*/

/*
resource "docker_container" "contenedor-nginx-bloque" {
  count     = 3
  name      = "mi_contenedor_nginx-${count.index}"
  image     = docker_image.imagen-nginx.latest
  logs      = true
  ports {
      internal  = 80
      external  = 8080 + count.index
  }
}
*/

/*resource "docker_container" "contenedores-nginx-diferentes" {
  for_each = var.contenedores
  # La variable each me da: each.key y un each.value
  name  = each.key
  image = docker_image.imagen-nginx.latest
  ports {
    internal = 80
    external = each.value 
  }
}*/

/*
resource "docker_container" "contenedores-nginx-diferentes-2" {
  for_each = toset (var.nombre_contenedores)
  # La variable each me da: each.key y un each.value
  name  = each.key
  image = docker_image.imagen-nginx.latest
}
*/

resource "docker_container" "contenedores-nginx-diferentes-2" {
  count = length(var.lista_contenedores)
  # La variable each me da: each.key y un each.value
  name  = var.lista_contenedores[count.index].nombre
  image = docker_image.imagen-nginx.latest
  ports {
    internal = 80
    external = var.lista_contenedores[count.index]["puerto"]
  }
}