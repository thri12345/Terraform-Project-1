variable "region" {
  type = string
  default = "ap-south-1"
}
variable "vpc_cidr" {
type = string  
default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
type = list(string)
default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}
variable "pvt_subnet_cidr" {
type = string
default =  "10.0.3.0/24"
}
variable "availability_zone" {
    type = list(string)
    default = [ "ap-south-1a", "ap-south-1b"] 
}
variable "availability_zone-pvt" {
    type = string
    default = "ap-south-1a"  
}
variable "ami_id" {
  type = string
  default = "ami-0521bc4c70257a054" 
}
variable "instance_type" {
  type = string
  default = "t2.medium"
}
variable "key_name" {
  type = string
  default = "rhel-proj-pem"
}
variable "max_size" {
  type = string
  default = "4"
  
}
variable "min_size" {
  type = string
  default = "1"
}
variable "desired_capacity" {
  type = string
  default = "2"
  
}