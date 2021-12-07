provider "aws" {
  region = "us-east-1"
  access_key = "key-03772de6c76c3023c"
  secret_key = "<YOUR SECRET KEY HERE>"
}
resource "aws_instance" "tfvm" {
  ami           = "ami-0725ad21629404a7c5"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.websg.id ]
  user_data = <<-EOF
                #!/bin/bash
                echo "I LOVE TERRAFORM" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF
    tags = {
      Name = "WEB-demo"
    }
	ami           = "ami-0725ad21629404a7c5"
	instance_type = "t2.micro"
	subnet_id = aws_subnet.private.id
	vpc_security_group_ids = [aws_security_group.mywebsecurity.id]
	key_name = "mynewkey"
	availability_zone = "ap-south-1b"
	tags = {
		Name = "mysql"
	}
}

resource "aws_security_group" "websg" {
  name = "web-sg01"
  ingress {
    protocol = "tcp"
    from_port = 8080
    to_port = 8080
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

output "instance_ips" {
  value = aws_instance.tfvm.public_ip
}

