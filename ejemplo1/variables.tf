variable "nombre_imagen" {
    description = "Nombre de la imagen que voy a descargar"
    type        = string
    default     = "ubuntu"
}

variable "version_imagen" {
    description = "Versión de la imagen que voy a descargar"
    type        = string
    default     = "xenial"
}

variable "volumenes" {
    description = "Volúmenes que vamos a montar en el contenedor"
    type        = list(map(string))
    default     = [
        {
            host_path       = "/home/ubuntu/environment/cursoTerraform"
            container_path  = "/cursoTerraform"
            read_only       = true
        },
        {
            host_path       = "/home/ubuntu/environment/ivan"
            container_path  = "/ivan"
            read_only       = true
        }
    ]
}