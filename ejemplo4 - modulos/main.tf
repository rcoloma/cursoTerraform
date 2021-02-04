terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            #Le estoy diciendo que se traiga el plugin de docker
        }
    }
}


module "nginx" {
  source              = "./contenedor"
  nombre_imagen       = "nginx"
  nombre_contenedor   = "mi-nginx"
  puertos_contenedor  = [
    {
      interno   = 80
      externo   = 8080
      protocolo = "tcp"
    },
    {
      interno   = 443
      externo   = 8443
      protocolo = "tcp"
    }
  ]
}


module "apache" {
  source              = "./contenedor"
  nombre_imagen       = "httpd"
  nombre_contenedor   = "mi-apache"
  puertos_contenedor  = [
    {
      interno   = 80
      externo   = 8090
      protocolo = "tcp"
    },
    {
      interno   = 443
      externo   = 8493
      protocolo = "tcp"
    }
  ]
}