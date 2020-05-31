provider "aws" {
  region = "eu-west-2"
}

resource "aws_security_group" "instance" {
  name = "terraform_test_instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "terraform_test" {
  ami           = "ami-0eb89db7593b5d434"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name = "tf-task-key"
  user_data = file("run_hello.sh")

  tags = {
    Name = "terraform_test"
  }
}

output "public_ip" {
  value       = aws_instance.terraform_test.public_ip
  description = "The public IP of the web server"
}
