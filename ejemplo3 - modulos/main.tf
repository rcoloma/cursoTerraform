terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            #Le estoy diciendo que se traiga el plugin de docker
        }
    }
}

provider "docker" { }

resource "docker_image" "imagen" {
  name = "${var.nombre_imagen}:${var.version_imagen}"
}


resource "docker_container" "contenedor" {
  name  = "mi_contenedor"
  image = docker_image.imagen.latest
  
  //Ejecutor
  //Tipos: local-exec. remote-exec. file
  provisioner "local-exec" {
    command = "echo ${self.ip_address}"
    #command = "ansible-playbook -f XXX ${self.ip_address}"
    
    //command = "ansible-playbook" para aprovisionar una máquina remota
    /* Ansible
    Tomar ese servidor y:
      Crear usuarios
      Crear grupos de usuarios
      Configurar politicas SELinux
      Reglar firewall
      INstalar software
    */
  }
  
  connection {
    //type = "ssh | winrm"
    type      = "ssh"
    host      = self.ip_address
    user      = "root"
    password  = "root"
    port      = 22
  }
  provisioner "remote-exec" {
    inline = ["echo ${self.ip_address}"]
    //script = "./miscript.sh"
    //scripts
    //on_failure  = continue
    //when        = destroy
  }
}
