variable "project_name"{}
variable "ami" {
    default = "ami-0522ab6e1ddcc7055" 
}
variable "cpu" {
    default = "t3.small"
}
variable "key_name" {}
variable "client_sg_id" {}
variable "max_size" {
    default = 4
}
variable "min_size" {
    default = 1
}
variable "desired_cap" {
    default = 2
}
variable "asg_health_check_type" {
    default = "ELB"
}
variable "pri_sub_3a_id" {}
variable "pri_sub_4b_id" {}
variable "tg_arn" {}

variable "db_host" {}
variable "db_port" {
    default = 3306
}
variable "db_user" {}
variable "db_password" {}
variable "db_name" {}
variable "db_file" {
    default = "./modules/rds/setup.sql"
}
variable "domain" {}
variable "server_port" {
    default = 3000
}