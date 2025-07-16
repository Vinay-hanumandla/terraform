# Security Group for EKS Worker Nodes
resource "aws_security_group" "eks_nodes_sg" {
  name        = "${var.name_prefix}-nodes-sg"
  description = "EKS worker nodes SG"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow pods to communicate with each other"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "Allow worker nodes to receive traffic from control plane"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-nodes-sg"
  }
}

# Security Group for EFS (allows NFS access from nodes)
resource "aws_security_group" "efs_sg" {
  name        = "${var.name_prefix}-efs-sg"
  description = "Allow NFS from EKS worker nodes"
  vpc_id      = var.vpc_id


  ingress {
    description     = "Allow NFS (port 2049) from worker nodes"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_nodes_sg.id]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-efs-sg"
  }
}

