variable "REGION" {
    type = string
    description = "The AWS region where resources will be created."
    default = "eu-central-2"
}

variable "COMMON_NAMING_PREFIX" {
    type = string
    description = "Naming prefix for all resources."
    default = "Challenge-App"
    sensitive = false
  
}

variable "COMPANY" {
    type = string
    description = "Name of the company."
    default = "SWC"
}

variable "PROJECT" {
    type = string
    description = "Name of the project."
    default = "Kubernetes-Cluster"
  
}

variable "VPC_CIDR_BLOCK" {
    type = string
    description = "The VPC CIDR block."
    default = "10.0.0.0/16"
  
}

variable "VPC_SUBNET_COUNT" {
    type = number
    description = "The number of subnets that will be created."
    default = 2
  
}