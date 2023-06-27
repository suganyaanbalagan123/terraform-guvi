provider "aws" {
  region = "ap-south-1"
  profile = "default"
}

resource "aws_instance" "my-ec2" {
    ami = "ami-0f5ee92e2d63afc18"
    instance_type = "t2.micro"
    key_name = "key1"
   // security_groups = ["my-sg"]
   vpc_security_group_ids = ["${aws_security_group.my-sg.id}"]
   subnet_id = aws_subnet.mysubnet-public-01.id
}
resource "aws_instance" "my-ec2-1" {
    ami = "ami-057752b3f1d6c4d6c"
    instance_type = "t2.micro"
    key_name = "key2"
   // security_groups = ["my-sg"]
   vpc_security_group_ids = ["${aws_security_group.my-sg.id}"]
   subnet_id = aws_subnet.mysubnet-public-03.id
}

resource "aws_security_group" "my-sg" {
    name = "my-sg"
    vpc_id = "${aws_vpc.my-vpc.id}"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "ssh-sg"

    }}
//creating a VPC

resource "aws_vpc" "my-vpc" {
    cidr_block = "10.1.0.0/16"
    tags = {
      Name = "my-vpc"
    }

}

// Creatomg a Subnet
resource "aws_subnet" "mysubnet-public-01" {
    vpc_id = "${aws_vpc.my-vpc.id}"
    cidr_block = "10.1.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone= "ap-south-1a"
    tags = {
      Name = "mysubnet-public-01"
    }

}

resource "aws_subnet" "mysubnet-public-02" {
    vpc_id = "${aws_vpc.my-vpc.id}"
    cidr_block = "10.1.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone= "ap-south-1b"
    tags = {
      Name = "mysu  }

}

resource "aws_subnet" "mysubnet-public-03" {
    vpc_id = "${aws_vpc.my-vpc.id}"
    cidr_block = "10.1.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone= "ap-south-1c"
    tags = {
      Name = "mysubnet-public-03"
    }

}

//Creating a Internet Gateway
resource "aws_internet_gateway" "my-igw" {
    vpc_id = "${aws_vpc.my-vpc.id}"
    tags = {
      Name = "my-igw"
    }
}

// Create a route table
resource "aws_route_table" "my-public-rt1" {
    vpc_id = "${aws_vpc.my-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.my-igw.id}"
        }
    tags = {
      Name = "my-public-rt2"
    }
}

resource "aws_route_table" "my-public-rt3" {
    vpc_id = "${aws_vpc.my-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.my-igw.id}"
    }
    tags = {
      Name = "my-public-rt3"
    }
}

// Associate subnet with routetable

resource "aws_route_table_association" "my-public-rt1" { 
  subnet_id = "${aws_subnet.mysubnet-public-01.id}"
  route_table_id = "${aws_route_table.my-public-rt1.id}"
  
                                                                                                                                    136,1         90%
                   
}
resource "aws_route_table_association" "my-public-rt2" { 
  subnet_id = "${aws_subnet.mysubnet-public-02.id}"
  route_table_id = "${aws_route_table.my-public-rt2.id}"

}
resource "aws_route_table_association" "my-public-rt3" { 
  subnet_id = "${aws_subnet.mysubnet-public-03.id}"
  route_table_id = "${aws_route_table.my-public-rt3.id}"

}
                                                                                                                                    162,1         Bot                                        
      
  
