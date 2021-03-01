data "aws_vpc" "defaultVPC"{
	filter {
		name = "tag:Name"
		values = ["default"]
	}
}

output "defaultVPC_ID"{
	value = data.aws_vpc.defaultVPC.id
}

resource "aws_security_group" "securityGroup"{
	name = "kmayer-sg"
	description = "Managed by Terraform for Kul"
	vpc_id = data.aws_vpc.defaultVPC.id
	tags = {
		Name = var.name
		Client = var.client
	}
	ingress {
		protocol = "tcp"
		from_port = 22
		to_port = 22
		cidr_blocks = ["0.0.0.0/0"]
		description = "SSH Access"
	}
	ingress {
		protocol = "tcp"
		from_port = 2049
		to_port = 2049
		cidr_blocks = ["0.0.0.0/0"]
		description = "NFS Access"
	}
	egress {
		protocol = "-1"
		from_port = 0
		to_port = 0
		cidr_blocks = ["0.0.0.0/0"]
	}
}