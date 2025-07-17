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
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  force_delete              = true
  health_check_type         = "EC2"
  vpc_zone_identifier       = aws_subnet.Project_public_subnet[*].id
  health_check_grace_period = 300
    launch_template {
    id = aws_launch_template.Project_web-frontend-LT.id
    version = "$Latest"
  }
 }

resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.Frontend-asg.name

}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.Frontend-asg.name
}

# resource "aws_cl" "name" {
  
# }

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 50

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.Frontend-asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_out.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "cpu-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 50

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.Frontend-asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_in.arn]
}