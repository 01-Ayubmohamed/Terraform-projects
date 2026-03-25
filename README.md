# Wordpress deployed on a scalable multi AZ infrastructure on AWS 

### This project will deploy a complete end to end Wordpress environment on AWS using Terraform. The infrastructure is modular and incorporates terraform practices; networking, loadbalancing, compute and databse.  



## Objectives 

- Deploy a multi Az infrastructure using Terraform 
- Modularise project into reusable components 
- Design Security groups to achieve least privilege
- Automate WordPress Bootstrapping via cloud-init 
- Store terraform project in S3 backend state 

## Architecture 

Project will consist of: 

- Front/end layer - Application Load Balancer (ALB)
- Application/compute layer - EC2 instance running WordPress 
- Database layer - RDS MySQL inside private subnet

Traffic flow 
Internet -> ALB -> EC2 -> RDS 

### Networking 

- Custom VPC  (10.0.0.0/16) 
- public and private subnets 
- Internet Gateway for public access 
- Route tables controlling traffic flow
- DNS hostname and DNS support enabled 

ALB should be placed inside public subnets. 
RDS should be placed inside private subnets. 

### Application 

The application layer consist of an EC2 running on WordPress 
- EC2 instance deployed inside a private subnet 
- Security group allows HTTP (80) access only from ALB security group 
- WordPress bootstrapped configured using '''bash cloud-init '''

This creates a secure EC2 instance with automated WordPress installation.  


### Database 

- The database layer uses Amazon RDS (MySQL).
- Deployed inside private subnets (not public access)
- Security group allows MySQL (3306) access from EC2 security group only
- Database credentials managed securely (via variables or Secrets Manager in future improvements)

This ensures database isolation and secure communication between compute and storage layers.

## Deployment

To deploy the infrastructure:
### Deploy infrastructure 

```bash
terraform init
terraform plan
terraform apply
```

### Access Application

```bash
terraform output wordpress_public_ip
```

Use the ALB DNS name output to access the WordPress application in your browser
```bash
http://<alb_dns_name> 
```

if you have configured a domain via Route 53 and have 

Destroy infrastructure

```bash
terraform destroy
```


## Project Structure 

```bash

├── main.tf                # Root module orchestrating all infrastructure modules
├── variables.tf           # Root input variables passed into modules
├── outputs.tf             # Root outputs (ALB DNS, RDS endpoint, etc)
├── provider.tf            # AWS provider configuration
├── terraform.tfvars       # Environment specific variable values
├── .gitignore             # Prevents state files and sensitive files from being committed
│
└── modules/
    ├── VPC/
    │   ├── main.tf        # VPC, subnets, route tables, internet gateway
    │   ├── variables.tf   # VPC module input variables
    │   └── outputs.tf     # VPC outputs (vpc_id, subnet_ids)
    │
    ├── ALB/
    │   ├── main.tf        # Application Load Balancer, target groups, listeners
    │   ├── variables.tf   # ALB module input variables
    │   └── outputs.tf     # ALB outputs (alb_dns_name, alb_sg_id)
    │
    ├── EC2/
    │   ├── main.tf        # WordPress EC2 instance and security group
    │   ├── variables.tf   # EC2 module input variables
    │   └── outputs.tf     # EC2 outputs (instance_id, security_group_id)
    │
    └── RDS/
        ├── main.tf        # MySQL RDS instance and security group
        ├── variables.tf   # RDS module input variables
        └── outputs.tf     # RDS outputs (db_endpoint)

```
## Security Design 
### ALB Security Group
- Allows:
- HTTP (80) from 0.0.0.0/0
- HTTPS (443) from 0.0.0.0/0
- Egress: Allow all outbound traffic

Purpose:
Public entry point to the application.



- EC2 Security Group
    •    Allows:
    •    SSH (22) only from personal IP (/32)
    •    HTTP (80) only from ALB Security Group (No public HTTP access)
    •    Egress: Allow outbound traffic for package updates and DB communication

Purpose:
Ensures application is not directly exposed to the internet.



- RDS Security Group
    •    Allows:
    •    MySQL (3306) only from EC2 Security Group
    •    No public access
    •    secured inside the private subnet

Purpose:
Database is fully isolated from public.

## Lessons Learned 

1. Terraform follows a strict flow of information. 
2. Backend state should be stable before deployment. 
3. For repeated resources and scalable design , terraform handles maps and objects better than simple lists. 
4. Modules do not interact with each other, use ouputs.tf and root to input variables into other modules.
5. Ensure security by effectivly using terraform.tfvars and implementing Sensitive = true arguments. 

## Problems Faced 

1. Circular module depediencies, when creating modules I made VPC dependent on EC2 outputs, which did not follow a top down dependency flow. Causing ifrastructure errors 
VPC -> subnets -> security -> ALB -> EC2 -> RDS 
2. Backend state migration. Any changes to the configuration will make Terraform assume state location has been changed. 
3. Variable naming. Any Mismatch between variables and tfvars defiitions will cause errors and break execution. 
4. for_each misuse. I implemented list(string) rather than structured list(objects), causing invalid input errors. 

## Future improvments  
### Infrastructure 
- Implement Auto scaling groups for high availibilty. 
- Deploy NAT gateway in front of EC2 for better scalability, availibilty and security. 

### Security 
- AWS Secret Manager for IAM controlleed access and smoother CI/CD integration. 
- AWS Session for smoother and secure access to EC2 instances. 
- Attach WAF to ALB.  

### Monitoring 
- Add Cloudwatch for monitoring and alarms. 






