terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws" {
    profile = "default"
    region = "eu-west-1"
}

resource "aws_instance" "RamonMachine" {
    ami             = "ami-0176d5cc50152c509"
    instance_type   = "t2.micro"
    tags            = {
                    Name = "RamonMachine"
    }
    key_name        = aws_key_pair.mis_claves_ssh.key_name   //Se genera la relación de dependencia porque en el plan resuelve la variable
    #key_name        =  "claves_instancia_ramon" //No se establece dependencia porque no hay variable
    
    provisioner "remote-exec" {
        inline      = [
                        "sleep 20",
                        "sudo apt update",
                        //"sudo apt install nginx -y"
                        "docker run -p 8080:80 -d nginx"
        ]
        
        connection {
            host            = aws_instance.RamonMachine.public_ip
            type            = "ssh"
            user            = "ubuntu"
            private_key     = tls_private_key.mi_clave_privada.private_key_pem
            timeout         = "1m"
        }
    }
    
    security_groups = [
        aws_security_group.reglas_de_redes.name
    ]
}

/*
Conexión con ssh
    # usuario / contraseña (clave ssh o cavle pública-privada)
*/

resource "aws_key_pair" "mis_claves_ssh" {
    key_name   = "claves_instancia_ramon"
    public_key = tls_private_key.mi_clave_privada.public_key_openssh
}

resource "tls_private_key" "mi_clave_privada" {
    algorithm   = "RSA"
    rsa_bits    = 4096
}

output "clave_privada" {
    value = tls_private_key.mi_clave_privada.private_key_pem
}

output "clave_publica" {
    value = tls_private_key.mi_clave_privada.public_key_pem
}

resource "aws_security_group" "reglas_de_redes" {
    name    = "reglas_de_redes"
    description    = "Permitir acceso a la maquinas"
    
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        from_port = 8080
        to_port   = 8080
        protocol  = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}