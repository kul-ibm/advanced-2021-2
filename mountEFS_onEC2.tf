resource "null_resource" "mountEFS" {
  depends_on = [ aws_efs_mount_target.mountTargets ]
  provisioner "remote-exec" {  # Provisioner types: remote-exec, local-exec, file
  
    connection {
        type = "ssh"
        user = "ubuntu"
        host = aws_instance.server.public_ip
        private_key = file("c:/training/kul-labs.pem")
    }
    inline = [
        "sudo apt-get update -y && sudo apt-get install -y nfs-common",
        "mkdir -p ~/efs",
        "sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/ efs"
    ]

  }
}