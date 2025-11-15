output "Public_ip" {
  value = aws_instance.name.public_ip
}
output "az" {
    value = aws_instance.name.availability_zone
  
}
output "private_ip" {
    value = aws_instance.name.private_ip
  
}