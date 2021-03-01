variable "name"{
	description = "Use to create tag Name for the resource created, e.g. kul, thinknyx"
	type = string
}

variable "client"{
	description = "Use to create tag with the Name (Client) for the resource created, e.g. IBM, Syenchron"
	type = string
}

variable "instance_type"{
	default = "t2.micro"
}