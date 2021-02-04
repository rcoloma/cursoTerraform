variable "nombre_imagen" {
    description = "Nombre de la imagen que voy a descargar"
    type        = string
}

variable "version_imagen" {
    description = "Versión de la imagen que voy a descargar"
    type        = string
    default     = "latest"
}

variable "nombre_contenedor" {
    description = "Nombre del contenedor que voy a generar"
    type        = string
    validation {
        condition       = length(var.nombre_contenedor) > 4 #&& ||
        error_message   = "Debe suministrar un nombre de contenedor con al menos 5 caracteres."
    }
}

variable "puertos_contenedor" {
    description = "Puertos contendor"
    type        = list(map(string))
}