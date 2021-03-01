provider "aws" {
	region = "us-east-2"
	# shared_credentials_file = (use to pass the file location for the AWS credentials
}

#prequisite to manage remote backend, bucket should exist before
terraform {
	backend "s3" {
		bucket = "thinknyx"
		key = "kmayer.tfstate"
		region = "us-east-2"
	}
}

resource "aws_instance" "server" {
	instance_type = var.instance_type
	ami = "ami-0996d3051b72b5b2c"
	tags = {
		Name = var.name
		Client = var.client
	}
	vpc_security_group_ids = [ aws_security_group.securityGroup.id ]
	key_name = "kul-labs"
}

output "server-public_ip" {
	value = aws_instance.server.public_ip
}