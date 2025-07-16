resource "aws_launch_template" "Project_web-frontend-LT"{
name    = "frontend-LT"
image_id = var.ami_id
instance_type = var.instance_type
key_name = var.key_name
vpc_security_group_ids = [aws_security_group.Project_pub_SG.id]
user_data = base64encode(file("Frontend.sh"))
tag_specifications {
  resource_type = "instance"
  tags = {
    Name = "Rhel-Proj1"
  }
}
}
 
 resource "aws_autoscaling_group" "Frontend-asg" {
  name                      = "autoscaling-project"
  max_size                  = 3
  min_size                  = 1
  desired_capacity          = 2
  force_delete              = true
  health_check_type         = "EC2"
  vpc_zone_identifier       = aws_subnet.Project_public_subnet[*].id

  launch_template {
    id = aws_launch_template.Project_web-frontend-LT.id
    version = "$Latest"
  }
 }