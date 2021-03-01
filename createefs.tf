resource "aws_efs_file_system" "efs"{
    creation_token = "kmayer"
    tags = {
        Name = var.name
		Client = var.client
    }
}

data "aws_subnet_ids" "subnetIds" {
  vpc_id = data.aws_vpc.defaultVPC.id
}

output "subnetIds" {
  value = data.aws_subnet_ids.subnetIds.ids
}

resource "aws_efs_mount_target" "mountTargets" {
  for_each = data.aws_subnet_ids.subnetIds.ids
  file_system_id = aws_efs_file_system.efs.id
  security_groups = [ aws_security_group.securityGroup.id ]
  subnet_id = each.value
}

output "efs_dns_name" {
  value = aws_efs_file_system.efs.dns_name
}