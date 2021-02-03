output "direccion_ip" {
    value = docker_container.contenedor.ip_address
}

//después del apply puede pedirle información así:
//terraform output direccion_ip
//terraform output -json direccion_ip