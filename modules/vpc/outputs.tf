output "vpc-id" {
  value = aws_vpc.dev-vpc.id
}


output "dev-pub-sub-id" {
  value = aws_subnet.dev-pub-sub.id
}


output "dev-pvt-sub-1-id" {
  value = aws_subnet.dev-pvt-sub-1.id
}

output "dev-pvt-sub-2-id" {
  value = aws_subnet.dev-pvt-sub-2.id
}


output "dev-igw-id" {
  value = aws_internet_gateway.dev-igw.id
}
