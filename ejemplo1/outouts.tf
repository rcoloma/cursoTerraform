output "direccion_ip" {
    value = docker_container.contenedor-ubuntu.ip_address
}

output "id" {
    value = docker_container.contenedor-ubuntu.id
}

output "labels" {
    value = docker_container.contenedor-ubuntu.labels
}


//después del apply puede pedirle información así:
//terraform output direccion_ip
//terraform output -json direccion_ip