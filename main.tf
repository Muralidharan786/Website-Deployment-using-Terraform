resource "aws_instance" "web" {
  ami           = "ami-08d59269edddde222" # Ubuntu
  instance_type = "t3.micro"
  key_name      = "my-key"

vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 git -y
              systemctl start apache2
              systemctl enable apache2

              rm -rf /var/www/html/*
              git clone https://github.com/Muralidharan786/Website-Deployment-using-Terraform.git /var/www/html/
              EOF

  tags = {
    Name = "Terraform-Web-Server"
  }
}

resource "aws_security_group" "web_sg" {
  name = "web-sg"
  

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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