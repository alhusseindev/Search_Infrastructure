terraform{

    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "~>3.0"
        }



    }       
}




provider "aws"{
    region = var.region
}




#create VPC
resource "aws_vpc" "my_vpc"{
    cidr_block= "10.0.0.0/16"
}

#create subnet
resource "aws_subnet" "my_subnet"{
    vpc_id= aws_vpc.my_vpc.id
    cidr_block= "10.0.0.0/20"
}



resource "aws_elasticsearch_domain" "my_os_domain"{
    domain_name = "${var.my_domain_name}"
    elasticsearch_version= var.opensearch_version

    cluster_config{
        instance_count = 1
        instance_type = var.instance_size
        
    }

    snapshot_options{
        automated_snapshot_start_hour= 23
    }




    ebs_options{
        ebs_enabled = var.ebs_volume_size > 0 ? true : false
        volume_size = var.ebs_volume_size
    
    }




    tags = {
        Domain = "${var.my_domain_name}"
    }

}






# Creating an AWS ElasticSearch Domain Policy
resource "aws_elasticsearch_domain_policy" "my_domain_policy"{
    domain_name= var.my_domain_name
    access_policies= <<POLICY
    {
        "Version": "2012-10-17",
        "Statement": [
                {
                "Action": "es:*",
                "Principal": "*",
                "Effect": "Allow",
                "Resource": "${aws_elasticsearch_domain.my_os_domain.arn}",
                "Condition": {
                    "IpAddress": {"aws:SourceIp": ["66.193.100.22/32"]}
                }
            }
        ]
    }
    POLICY
}