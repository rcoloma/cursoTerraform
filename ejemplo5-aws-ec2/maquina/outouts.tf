output "ip_publica" {
    value = aws_instance.RamonMachine.public_ip
}

output "tamano_disco" {
    //value = aws_instance.RamonMachine.root_block_device.0.volume_size
    value = aws_instance.RamonMachine.root_block_device[0].volume_size
    
    /*
    
    value = [for disco in aws_instance.RamonMachine.root_block_device : disco.volume_size]
    
    */
}

/*

*/

//después del apply puede pedirle información así:
//terraform output direccion_ip
//terraform output -json direccion_ip