data "aws_ami" "latest-amzn-linux-image" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}




resource "aws_instance" "bastion-host" {
  ami           = data.aws_ami.latest-amzn-linux-image.id
  subnet_id     = var.dev-pub-sub-id
  instance_type = var.instance_type
  tags = {
    Name      = "dev-bastion"
    Terraform = "true"
    Cost      = "dev-env"
  }
}

resource "aws_security_group" "dev-bastion-sg" {
  name        = "dev-bastion-sg"
  description = "Allow SSH access to bastion host"
  vpc_id      = var.vpc-id
  ingress {
    description = "SSH from allowed IPs"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name      = "dev-bastion-sg"
    Terraform = "true"
    Cost      = "dev-env"
  }
}
