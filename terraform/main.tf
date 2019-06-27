### AWS AMIs ###
# Red Hat Enterprise Linux 8 (HVM), SSD Volume Type - ami-05220ffa0e7fce3d1
# RHEL-7.6_HVM-20190515-x86_64-0-Hourly2-GP2 - ami-01a834fd83ae239ff
# CentOS 7 Official - ami-0f2b4fc905b0bd1f1
# Ubuntu Server 18.04 LTS (HVM), SSD Volume Type - ami-0c55b159cbfafe1f0
# Ubuntu Server 16.04 LTS (HVM), SSD Volume Type - ami-0653e888ec96eab9b

### Links ###
# Subnets - https://hackernoon.com/manage-aws-vpc-as-infrastructure-as-code-with-terraform-55f2bdb3de2a
# Terraform & Ansible - https://medium.com/@mitesh_shamra/deploying-website-on-aws-using-terraform-and-ansible-f0251ae71f42

### Variables ###
variable "node_size" {
  description = "Default Node Size"
  default = "t3.nano"
}

variable "aws_region" {
  description = "Region for the VPC"
  default = "us-east-2"
}

variable "aws_subregion" {
  description = "Region for the VPC"
  default = "us-east-2a"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default = "10.0.1.0/24"
}

variable "ami" {
  description = "Ubuntu Server 18.04 LTS (HVM), SSD Volume Type"
  default = "ami-0c55b159cbfafe1f0"
}

variable "cyber-eip" {
  description = "Cyber Elastic IP"
  default = "eipalloc-059497ae0dfb1b2fa"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "../../keys/cyber.pub"
}
###############


provider "aws" {
  region = "${var.aws_region}"
}


##### Keypair #####
resource "aws_key_pair" "cyber-key" {
  key_name = "cyber"
  public_key = "${file("../keys/cyber.pub")}"
}


##### VPC #####
resource "aws_vpc" "cyber-vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "cyber-vpc"
  }
}


##### Subnets #####
resource "aws_subnet" "cyber-public-subnet" {
  vpc_id = "${aws_vpc.cyber-vpc.id}"
  cidr_block ="${var.public_subnet_cidr}"
  availability_zone = "${var.aws_subregion}"

  tags {
    Name = "Prod Public Subnet"
  }
}

resource "aws_subnet" "cyber-private-subnet" {
  vpc_id = "${aws_vpc.cyber-vpc.id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "${var.aws_subregion}"

  tags {
    Name = "Prod Private Subnet"
  }
}



##### Internet Gateway #####
resource "aws_internet_gateway" "cyber-gw" {
  vpc_id = "${aws_vpc.cyber-vpc.id}"

  tags {
    Name = "Prod VPC IGW"
  }
}
resource "aws_eip" "cyber-nat-eip" {
  vpc      = true
}
resource "aws_nat_gateway" "cyber-nat-gw" {
  allocation_id = "${aws_eip.cyber-nat-eip.id}"
  subnet_id = "${aws_subnet.cyber-public-subnet.id}"
  depends_on = ["aws_internet_gateway.cyber-gw"]

  tags = {
    Name = "Prod NAT GW"
  }
}

##### Route Table #####
resource "aws_route_table" "cyber-public-rt" {
  vpc_id = "${aws_vpc.cyber-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.cyber-gw.id}"
  }

  tags {
    Name = "Prod Public Subnet RT"
  }
}
resource "aws_route_table" "cyber-private-rt" {
  vpc_id = "${aws_vpc.cyber-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.cyber-nat-gw.id}"
  }

  tags {
    Name = "Prod Private Subnet RT"
  }
}

resource "aws_route_table_association" "cyber-public-rta" {
  subnet_id = "${aws_subnet.cyber-public-subnet.id}"
  route_table_id = "${aws_route_table.cyber-public-rt.id}"
}
resource "aws_route_table_association" "cyber-private-rta" {
  subnet_id = "${aws_subnet.cyber-private-subnet.id}"
  route_table_id = "${aws_route_table.cyber-private-rt.id}"
}


##### Security Groups #####
resource "aws_security_group" "cyber-public-sg" {
  name = "cyber-public-sg"
  description = "Allow incoming HTTP connections & SSH access"
  vpc_id="${aws_vpc.cyber-vpc.id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Prod Public SG"
  }
}

resource "aws_security_group" "cyber-private-sg"{
  name = "cyber-private-sg"
  description = "Allow SSH traffic from public subnet"
  vpc_id = "${aws_vpc.cyber-vpc.id}"

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Prod Private SG"
  }
}

##### Cyber Instances #####
resource "aws_instance" "cyber-master" {
  ami           = "${var.ami}"
  instance_type = "${var.node_size}"
  key_name      = "${aws_key_pair.cyber-key.id}"
  subnet_id     = "${aws_subnet.cyber-public-subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.cyber-public-sg.id}"]
  associate_public_ip_address = true
  source_dest_check           = false
  private_ip                  = "10.0.0.10"
  root_block_device {
    delete_on_termination = true
  }
  tags {
    Name = "Prod Master"
  }

}

resource "aws_eip_association" "cyber-eipa" {
  instance_id   = "${aws_instance.cyber-master.id}"
  allocation_id = "${var.cyber-eip}"
}

resource "aws_instance" "cyber-node1" {
  ami           = "${var.ami}"
  instance_type = "${var.node_size}"
  key_name = "${aws_key_pair.cyber-key.id}"
  subnet_id = "${aws_subnet.cyber-private-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.cyber-private-sg.id}"]
  source_dest_check = false
  private_ip = "10.0.1.10"
  root_block_device {
    delete_on_termination = true
  }
  tags {
    Name = "Cyber Node 1"
  }
}
resource "aws_instance" "cyber-node2" {
  ami           = "${var.ami}"
  instance_type = "${var.node_size}"
  key_name = "${aws_key_pair.cyber-key.id}"
  subnet_id = "${aws_subnet.cyber-private-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.cyber-private-sg.id}"]
  source_dest_check = false
  private_ip = "10.0.1.11"
  root_block_device {
    delete_on_termination = true
  }
  tags {
    Name = "Cyber Node 2"
  }
}
resource "aws_instance" "cyber-node3" {
  ami           = "${var.ami}"
  instance_type = "${var.node_size}"
  key_name = "${aws_key_pair.cyber-key.id}"
  subnet_id = "${aws_subnet.cyber-private-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.cyber-private-sg.id}"]
  source_dest_check = false
  private_ip = "10.0.1.12"
  root_block_device {
    delete_on_termination = true
  }
  tags {
    Name = "Cyber Node 3"
  }
}

### Give time for environment to stabilize
resource "null_resource" "ansible-prod" {
  provisioner "local-exec" {
    command = "sleep 120"
  }
  depends_on = [
    "aws_instance.cyber-master"
  ]
}
