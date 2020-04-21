# CDP IAC

Create a full-stack CDP-DC pseudo distributed cluster


## Prerequistes

`terraform 0.12+`


## Instructions for CentOS 7 on EC2(AWS) using Terraform

```
$ brew install terraform
```


### Create VPC
```
$ git clone https://github.com/amolthacker/cdp-iac.git

$ cd cdp-iac/terraform/aws
$ cd vpc

# Update terraform.tfvars

$ terraform init
$ terraform apply
```

### Create Cluster
```
$ cd ../cluster

# Update terraform.tfvars (use vpc id from above)

$ terraform init
$ terraform apply
```

### Log into the cluster
```
$ ssh -i <sshkey> centos@<cluster_public_ip>

$ sudo -i
$ yum install -y git
$ git clone https://github.com/amolthacker/pseudo-distributed-cdp.git
$ cd pseudo-distributed-cdp
$ ./setup.sh aws templates/e2ai_w_o3.json /dev/nvme1n1
```

### Destroy Cluster
```
$ cd cdp-iac/terraform/aws/cluster
$ terraform destroy
```

### Destroy VPC
```
$ cd cdp-iac/terraform/aws/vpc
$ terraform destroy
```

