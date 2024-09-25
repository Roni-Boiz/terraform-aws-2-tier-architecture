# 🚀 Terraform AWS 2-Tier Architecture

✨ This repository is created to learn and deploy a 2-tier application on aws cloud through Terraform. 

### 🏠 Let's set up the variable for our Infrastructure

Create one file with the name `terraform.tfvars`

```sh
vim terraform.tfvars
```

#### 🔐 ACM certificate

Go to AWS console --> AWS Certificate Manager (ACM) and make sure you have a valid certificate in Issued status, if not, feel free to create one and use the domain name on which you are planning to host your application.

#### 👨‍💻 Route 53 Hosted Zone

Go to AWS Console --> Route53 --> Hosted Zones and ensure you have a public hosted zone available, if not create one.

Add the below content into the `terraform.tfvars` file and add the values of each variable.

```javascript
region                  = ""
project_name            = ""
vpc_cidr                = ""
pub_sub_1a_cidr         = ""
pub_sub_2b_cidr         = ""
pri_sub_3a_cidr         = ""
pri_sub_4b_cidr         = ""
pri_sub_5a_cidr         = ""
pri_sub_6b_cidr         = ""
db_username             = ""
db_password             = ""
certificate_domain_name = ""
additional_domain_name  = ""
```

#### ⚙️ Verify the resources

After completing above steps make sure you have enable route53 resource `./modules/route53/main.tf`, cloudfront acm certificate and aliases `./modules/cloudfront/main.tf`. Finally, make changes to auto scaling group `./modules/asg/config.sh` to deploy your application on following aws 2 tier architecture.

### ✈️ Now we are ready to deploy our application on the cloud 

👉 let install dependency to deploy the application 

```sh
terraform init 
```

Type the below command to see the plan of the execution 

```sh
terraform plan
```

✨ Finally, HIT the below command to deploy the application

```sh
terraform apply 
```

Type `yes`, and it will prompt you for approval.
