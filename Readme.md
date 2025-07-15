We’ll provision:

    VPC with public + private subnets across 2 AZs

    Internet Gateway, Route Tables

    ALB in public subnets

    Auto Scaling Group (ASG) of EC2 web servers in public subnets

    RDS (MySQL) in private subnets

    Security groups

    S3 bucket for static content

    Route53 record for ALB


    Terraformproject-ha-webapp/
├── main.tf
├── variables.tf
├── outputs.tf
├── vpc.tf
├── alb.tf
├── asg.tf
├── rds.tf
├── s3.tf
├── route53.tf
├── terraform.tfvars
project structure