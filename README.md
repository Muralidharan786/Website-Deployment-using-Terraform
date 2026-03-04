**Infrastructure as Code: Website Deployment using Terraform**
**📌 Project Title**
Host a Website using Terraform (AWS EC2 + Apache + GitHub)

**🎯 Project Objective**

This project demonstrates how to use Terraform to automatically:

Create AWS infrastructure

Launch an EC2 instance

Install Apache Web Server

Pull website code from GitHub

Host the website publicly

**🛠 Tools & Technologies Used**
Tool	Purpose
Terraform	Infrastructure as Code
AWS EC2	Virtual Server
Apache	Web Server
GitHub	Website Source Code
Ubuntu	Operating System
AWS CLI	Authentication

**🏗 Architecture

Terraform → AWS EC2 → Apache → GitHub Website → Public URL**

**📂 Project Structure**

terraform-website/
│
├── provider.tf
├── main.tf
├── outputs.tf
├── terraform.tfstate
└── .terraform/

🔹 Step 1: Prepare Website Repository

Upload a static website to GitHub.

Example:

https://github.com/Muralidharan786/Website-Deployment-using-Terraform.git

**🔹 Step 2: Install Terraform**
Windows
choco install terraform
Linux
sudo apt update
sudo apt install terraform

Verify installation:

terraform -version
**🔹 Step 3: Create Project Folder**
mkdir terraform-website
cd terraform-website
**🔹 Step 4: AWS Pre-Configuration**

Before running Terraform:

Go to AWS Console

Ensure Default VPC exists

Go to EC2 → Key Pairs

Create key pair named:

my-key

Download the .pem file safely.

**🔹 Step 5: Configure AWS Credentials**

Run:

aws configure

Provide:

Access Key

Secret Key

Region (example: ap-south-1)

Output format (json)

**🔹 Step 6: Configure Provider (provider.tf)**
provider "aws" {
  region = "ap-south-1"
}

**🔹 Step 7: Create EC2 Instance (main.tf)**
resource "aws_instance" "web" {
  ami           = "ami-08d59269edddde222"
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
**🔹 Step 8: Create Security Group**
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
**🔹 Step 9: Output Public IP (outputs.tf)**
output "website_url" {
  value = aws_instance.web.public_ip
}
**🔹 Step 10: Initialize Terraform**
terraform init
**🔹 Step 11: Validate & Apply**
terraform validate
terraform plan
terraform apply

Type:

yes
**🌍 Step 12: Access the Website**

After apply completes:

Terraform will output:

website_url = <EC2_PUBLIC_IP>

Open browser:

http://<EC2_PUBLIC_IP>/

Your website will be live 🎉

🔎 View Infrastructure Details
terraform show

**💰 Step 13: Destroy Infrastructure (Cost Saving)**

Always destroy resources after use:

terraform destroy

Type:

yes

**🎓 Learning Outcomes**

After completing this project, you will understand:

Infrastructure as Code (IaC)

AWS EC2 provisioning

Security Groups configuration

Automated server setup using user_data

Hosting static websites on cloud

Terraform lifecycle commands
