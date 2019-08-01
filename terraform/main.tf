### AWS AMIs ###
# Red Hat Enterprise Linux 8 (HVM), SSD Volume Type - ami-05220ffa0e7fce3d1
# RHEL-7.6_HVM-20190515-x86_64-0-Hourly2-GP2 - ami-01a834fd83ae239ff
# CentOS 7 Official - ami-0f2b4fc905b0bd1f1
# Ubuntu Server 18.04 LTS (HVM), SSD Volume Type - ami-0c55b159cbfafe1f0
# Ubuntu Server 16.04 LTS (HVM), SSD Volume Type - ami-0653e888ec96eab9b
# Windows_Server-2008-R2_SP1-English-64Bit-Base-2019.06.12 - ami-03fe0a48fa4931d42
# Windows_Server-2012-RTM-English-64Bit-Base-2019.06.12 - ami-02d2604b729c6082a
# Windows_Server-2012-R2_RTM-English-64Bit-Base-2019.06.12 - ami-0373777a9c7d3596b
# Windows_Server-2016-English-Full-Base-2019.06.12 - ami-096b2c9dc9336e7c4

### AWS GOVCLOUD-EAST AMIS ###
# Red Hat Enterprise Linux 8 (HVM), SSD Volume Type    -  ami-8c56b0fd
# Red Hat Enterprise Linux 7.6 (HVM), SSD Volume Type  -  ami-43d63732
# Ubuntu Server 18.04 LTS (HVM), SSD Volume Type       -  ami-cd35d4bc
# Ubuntu Server 16.04 LTS (HVM), SSD Volume Type       -  ami-0933d278
# Microsoft Windows Server 2008 R2 Base                -  ami-0563a5c30fc5f9d4e
# Microsoft Windows Server 2012 Base                   -  ami-01952e561546c353c
# Microsoft Windows Server 2016 Base                   -  ami-04240e21ee16e76cc


### Links ###
# Subnets - https://hackernoon.com/manage-aws-vpc-as-infrastructure-as-code-with-terraform-55f2bdb3de2a
# Terraform & Ansible - https://medium.com/@mitesh_shamra/deploying-website-on-aws-using-terraform-and-ansible-f0251ae71f42

### Variables ###
variable "node_size" {
  description = "Default Node Size"
  default = "t3.micro"
}

variable "aws_region" {
  description = "Region for the VPC"
  default = "us-gov-east-1"
}

variable "aws_profile" {
  description = "AWS Profile"
  default = "govcloud"
}

variable "aws_subregion" {
  description = "Region for the VPC"
  default = "us-gov-east-1a"
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
  default = "ami-cd35d4bc"
}

variable "cyber-eip" {
  description = "Cyber Elastic IP"
  default = "eipalloc-02b02ac69d4022af4"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "../../keys/cyber.pub"
}
###############


provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.aws_profile}"
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

  tags = {
    Name = "cyber-vpc"
  }
}


##### Subnets #####
resource "aws_subnet" "cyber-public-subnet" {
  vpc_id = "${aws_vpc.cyber-vpc.id}"
  cidr_block ="${var.public_subnet_cidr}"
  availability_zone = "${var.aws_subregion}"

  tags = {
    Name = "Cyber Public Subnet"
  }
}

resource "aws_subnet" "cyber-private-subnet" {
  vpc_id = "${aws_vpc.cyber-vpc.id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "${var.aws_subregion}"

  tags = {
    Name = "Cyber Private Subnet"
  }
}



##### Internet Gateway #####
resource "aws_internet_gateway" "cyber-gw" {
  vpc_id = "${aws_vpc.cyber-vpc.id}"

  tags = {
    Name = "Cyber VPC IGW"
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
    Name = "Cyber NAT GW"
  }
}

##### Route Table #####
resource "aws_route_table" "cyber-public-rt" {
  vpc_id = "${aws_vpc.cyber-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.cyber-gw.id}"
  }

  tags = {
    Name = "Cyber Public Subnet RT"
  }
}
resource "aws_route_table" "cyber-private-rt" {
  vpc_id = "${aws_vpc.cyber-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.cyber-nat-gw.id}"
  }

  tags = {
    Name = "Cyber Private Subnet RT"
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

  tags = {
    Name = "Cyber Public SG"
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

  tags = {
    Name = "Cyber Private SG"
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
    volume_size = 100
  }
  tags = {
    Name = "Cyber Master"
  }

}
resource "aws_eip_association" "cyber-eipa" {
  instance_id   = "${aws_instance.cyber-master.id}"
  allocation_id = "${var.cyber-eip}"
}

# RHEL-7.6_HVM-20190515-x86_64-0-Hourly2-GP2 - ami-01a834fd83ae239ff
# ec2-user
resource "aws_instance" "cyber-node1" {
  ami           = "ami-43d63732"
  instance_type = "${var.node_size}"
  key_name = "${aws_key_pair.cyber-key.id}"
  subnet_id = "${aws_subnet.cyber-private-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.cyber-private-sg.id}"]
  source_dest_check = false
  private_ip = "10.0.1.10"
  root_block_device {
    delete_on_termination = true
    volume_size = 100
  }
  tags = {
    Name = "Cyber Node 1 - RHEL 7.6"
  }
}

# Ubuntu Server 16.04 LTS (HVM), SSD Volume Type - ami-0653e888ec96eab9b
# ubuntu
resource "aws_instance" "cyber-node2" {
  ami           = "ami-0933d278"
  instance_type = "${var.node_size}"
  key_name = "${aws_key_pair.cyber-key.id}"
  subnet_id = "${aws_subnet.cyber-private-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.cyber-private-sg.id}"]
  source_dest_check = false
  private_ip = "10.0.1.11"
  root_block_device {
    delete_on_termination = true
    volume_size = 100
  }
  tags = {
    Name = "Cyber Node 2 - Ubuntu 16.04"
  }
}

# Windows_Server-2008-R2_SP1-English-64Bit-Base-2019.06.12 - ami-03fe0a48fa4931d42
resource "aws_instance" "cyber-node3" {
  ami           = "ami-0563a5c30fc5f9d4e"
  instance_type = "${var.node_size}"
  key_name = "${aws_key_pair.cyber-key.id}"
  subnet_id = "${aws_subnet.cyber-private-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.cyber-private-sg.id}"]
  source_dest_check = false
  private_ip = "10.0.1.12"
  root_block_device {
    delete_on_termination = true
    volume_size = 100
  }
  tags = {
    Name = "Cyber Node 3 - Win Server 2008 R2"
  }
}


# Windows_Server-2012-R2_RTM-English-64Bit-Base-2019.06.12 - ami-0373777a9c7d3596b
resource "aws_instance" "cyber-node4" {
  ami           = "ami-01952e561546c353c"
  instance_type = "${var.node_size}"
  key_name = "${aws_key_pair.cyber-key.id}"
  subnet_id = "${aws_subnet.cyber-private-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.cyber-private-sg.id}"]
  source_dest_check = false
  private_ip = "10.0.1.13"
  root_block_device {
    delete_on_termination = true
    volume_size = 100
  }
  tags = {
    Name = "Cyber Node 4 - Win Server 2012 R2"
  }
}

# Windows_Server-2016-English-Full-Base-2019.06.12 - ami-096b2c9dc9336e7c4
resource "aws_instance" "cyber-node5" {
  ami           = "ami-04240e21ee16e76cc"
  instance_type = "${var.node_size}"
  key_name = "${aws_key_pair.cyber-key.id}"
  subnet_id = "${aws_subnet.cyber-private-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.cyber-private-sg.id}"]
  source_dest_check = false
  private_ip = "10.0.1.14"
  root_block_device {
    delete_on_termination = true
    volume_size = 100
  }
  tags = {
    Name = "Cyber Node 5 - Win Server 2016"
  }
}

### Give time for environment to stabilize
resource "null_resource" "ansible-cyber" {
  provisioner "local-exec" {
    command = "sleep 120"
  }
  depends_on = [
    "aws_instance.cyber-master"
  ]
}
