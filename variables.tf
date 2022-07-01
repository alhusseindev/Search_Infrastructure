
variable "region"{
    type= string
    default= "us-east-1"
}

variable "opensearch_version"{
    type= string
    default= "Opensearch_1.0"
}

#2 GB
variable "ebs_volume_size"{
    type= number
    description = "EBS volume size"
    default = 2
}


variable "instance_size"{
    type= string
    description = "instance size for Elastic search"
    default= "t2.small.elasticsearch"
}


variable "my_domain_name"{
    type= string
    description= "Domain Name"
    default = "Posts"
}