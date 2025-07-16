output "eks_nodes_sg_id" {
  value = aws_security_group.eks_nodes_sg.id
}

output "efs_sg_id" {
  value = aws_security_group.efs_sg.id
}

