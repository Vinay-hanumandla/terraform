output "aws_ami_id" {
  value = data.aws_ami.latest-amzn-linux-image.id
}


output "instance_ip" {
  value = aws_instance.bastion-host.public_ip
}



