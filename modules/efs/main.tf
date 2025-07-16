resource "aws_efs_file_system" "this" {
  creation_token = "eks-shared-efs"
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  tags = {
    Name = var.name
  }
}

#resource "aws_security_group" "efs_sg" {
#  name        = "${var.name}-sg"
#  description = "Allow NFS access for EFS"
#  vpc_id      = var.vpc_id
#
#  ingress {
#    from_port   = 2049
#    to_port     = 2049
#    protocol    = "tcp"
#    cidr_blocks = var.allowed_cidrs
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  tags = {
#    Name = "${var.name}-sg"
#  }
#}

resource "aws_efs_mount_target" "mount_targets" {
  #for_each = toset(var.subnet_ids)
  for_each  = var.subnet_ids

  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = each.value
  # security_groups = [aws_security_group.efs_sg.id]
  security_groups = [var.efs_sg_id]
}

