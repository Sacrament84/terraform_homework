provider "aws" {
        region = "eu-west-1"
}
# define ami
data "aws_ami" "linux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
# nginx
resource "aws_instance" "nginx" {
 ami = data.aws_ami.linux2.id
 instance_type   = "t2.micro"
 security_groups = [ aws_security_group.web.name ] 
 user_data       = data.template_file.user_data_nginx.rendered
 tags = {
  Owner = "voloshin_nikolai@epam.com"
  }
}
data "template_file" "user_data_nginx" {
 template           = file ("./user_data_nginx.tpl")
 }
#RDS
resource "aws_db_instance" "rds" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
#  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_name                = "test"
  username               = "test"
  password               = "testtesttest"
  skip_final_snapshot    = true
}
