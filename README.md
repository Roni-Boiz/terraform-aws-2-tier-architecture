# 🚀 Terraform AWS 2-Tier Architecture

✨ This repository is created to learn and deploy a 2-tier application on aws cloud through Terraform. 

<img src="https://raw.githubusercontent.com/Roni-Boiz/terraform-aws-2-tier-architecture/refs/heads/main/two-tier%20architecture.svg">

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

However, I have automate all these steps using GitHub workflows.

## Steps to setup CICD Pipeline

### Step 1: Steup EC2 Instance

1. #### Create EC2 Instance

    To launch an AWS EC2 instance with Ubuntu latest (24.04) using the AWS Management Console, sign in to your AWS account, access the EC2 dashboard, and click “Launch Instances.” In “Step 1,” select “Ubuntu 24.04” as the AMI, and in “Step 2,” choose “t3.small” as the instance type. Configure the instance details, storage (20 GB), tags , and security group settings according to your requirements. Review the settings, create or select a key pair for secure access, and launch the instance. Once launched, you can connect to it via SSH using the associated key pair or through management console.

    ![ec2-instance](https://github.com/user-attachments/assets/f7bd446c-7972-4e07-a451-ad63ab0a81f6)

2. #### Create IAM Role

    To create a new role for manage AWS resource through EC2 Instance in AWS, start by navigating to the AWS Console and typing “IAM” to access the Identity and Access Management service. Click on “Roles,” then select “Create role.” Choose “AWS service” as the trusted entity and select “EC2” from the available services. Proceed to the next step and use the “Search” field to add the necessary permissions policies, such as "Administrator Access" or "EC2 Full Access", "AmazonS3FullAccess" and "EKS Full Access". After adding these permissions, click "Next." In the “Role name” field, enter “EC2 Instance Role” and complete the process by clicking “Create role”.

    ![ec2-role-1](https://github.com/user-attachments/assets/781618f5-dce2-483d-a3d5-68df92d8367d)
   
    ![ec2-role-2](https://github.com/user-attachments/assets/6ee90b60-09c6-49d1-acda-5eb0befc9164)
   
    ![ec2-role-3](https://github.com/user-attachments/assets/b314bade-f007-4fe0-a144-1677bc36b4f2)


3. #### Attach IAM Role

    To assign the newly created IAM role to an EC2 instance, start by navigating to the EC2 dashboard in the AWS Console. Locate the specific instance where you want to add the role, then select the instance and choose "Actions." From the dropdown menu, go to "Security" and click on "Modify IAM role." In the next window, select the newly created role from the list and click on "Update IAM role" to apply the changes.

    ![attach-role-1](https://github.com/user-attachments/assets/41e5ece4-6543-4cf6-8ba7-84ce05652179)

    ![attach-role-2](https://github.com/user-attachments/assets/1119c1eb-3bb0-4d1a-b43b-20a14dd28ee8)


### Step 2: Setup Self-Hosted Runner on EC2

1. #### In GitHub

   To set up a self-hosted GitHub Actions runner, start by navigating to your GitHub repository and clicking on Settings. Go to the Actions tab and select Runners. Click on New self-hosted runner and choose Linux as the operating system with X64 as the architecture. Follow the provided instructions to copy the commands required for installing the runner (Settings --> Actions --> Runners --> New self-hosted runner).

   ![runner-1](https://github.com/user-attachments/assets/276217dd-f9fc-485f-929b-5841d1587f4d)

   ![runner-2](https://github.com/user-attachments/assets/0a9d0081-6786-4eb5-bb78-192976ff1dba)

   
   **Download Code**
   ```bash
    # Create a folder
    $ mkdir actions-runner && cd actions-runner

    # Download the latest runner package
    $ curl -o actions-runner-linux-x64-2.320.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.320.0/actions-runner-linux-x64-2.320.0.tar.gz

    # Optional: Validate the hash
    $ echo "93ac1b7ce743ee85b5d386f5c1787385ef07b3d7c728ff66ce0d3813d5f46900  actions-runner-linux-x64-2.320.0.tar.gz" | shasum -a 256 -c

    # Extract the installer
    $ tar xzf ./actions-runner-linux-x64-2.320.0.tar.gz
   ```

   **Configure Code**
   ```bash
    # Create the runner and start the configuration experience
    $ ./config.sh --url https://github.com/Roni-Boiz/terraform-aws-2-tier-architecture --token <your-token>

    # Last step, run it!
    $ ./run.sh
   ``` 

2. #### In EC2 Instance

   Next, connect to your EC2 instance via SSH or management console (wait till all checks passed in EC2 Instance), and paste the commands in the terminal to complete the setup and register the runner. When you enter `./config.sh` enter follwoing details:

   - runner group --> keep as default
   - name of runner --> git-workflow
   - runner labels --> git-workflow
   - work folder --> keep default

   ![runner-3](https://github.com/user-attachments/assets/fe36a16e-7f21-462e-94aa-0fbf7358c6a2)


> [!TIP]
> At the end you should see **Connected to GitHub** message upon successful connection

### Step 3: Setup Slack

1. #### Create Channel

   To set up Slack notifications for your GitHub Actions workflow, start by creating a Slack channel `github-actions` if you don't have one. Go to your Slack workspace, create a channel specifically for notifications, and then click on Home.

   ![slack-1](https://github.com/user-attachments/assets/ed0d7a42-81aa-4ab8-a832-b3e4a442dd88)

2. #### Create App

   From the Home click on Add apps than click App Directory. This opens a new tab; click on Manage then click on Build and then Create New App.

   ![slack-2](https://github.com/user-attachments/assets/aa6fbecc-994b-438c-85d7-a16e2f3f8157)

   ![slack-3](https://github.com/user-attachments/assets/a73b7f0f-770c-44b0-bd4f-dc63573f9258)

   ![slack-4](https://github.com/user-attachments/assets/f5b01404-7258-4987-be95-69c46d5f2575)

   ![slack-5](https://github.com/user-attachments/assets/54ca8cbc-978b-4d13-92cb-7a3a70909a8d)

   Choose From scratch, provide a name for your app, select your workspace, and click Create. Next, enable Incoming Webhooks by setting it to "on," and click Add New Webhook to Workspace. Select the newly created channel for notifications and grant the necessary permissions.

   ![slack-6](https://github.com/user-attachments/assets/7a8b0122-463d-4fbb-8533-d518eaccd930)
   
   ![slack-7](https://github.com/user-attachments/assets/36b8e488-b641-4dde-99f0-7d1ab46e40e7)
   
   ![slack-8](https://github.com/user-attachments/assets/c41984d3-4dc2-407c-8e28-c5e472f9e14e)
   
   ![slack-9](https://github.com/user-attachments/assets/3237e7d0-5620-4d7c-97cd-2de12da0ed5b)

3. #### Create Repository Secret

    This generates a webhook URL—copy it and go to your GitHub repository settings. Navigate to Secrets > Actions > New repository secret and add the webhook URL as a `SLACK_WEBHOOK_URL` secret.

    ![slack-10](https://github.com/user-attachments/assets/5274ea11-6ee9-4390-966c-5421138ebc92)


This setup ensures that Slack notifications are sent using the act10ns/slack action, configured to run "always"—regardless of job status—sending messages to the specified Slack channel via the webhook URL stored in the secrets.

> [!NOTE]
> Don't forget to update the **channel name** (not the app name) you have created in all the places `.github/workflows/terrafrom.yml`, `.github/workflows/cicd.yml`, `.github/workflows/destroy.yml`.


### Step 6: Pipeline

If you go to repository actions tab, following workflows will execute in background `Script --> Deploy`. Wait till the pipeline finishes to build and deploy the application to AWS.

**Script Pipeline**

![script-pipeline](https://github.com/user-attachments/assets/d6f78774-db63-4e6f-a1a2-239c329d4000)

**Deploy Pipeline**

![deploy-pipeline](https://github.com/user-attachments/assets/06522f72-0352-4ed5-9496-4981b19fea50)

After ppipeline finished you can access the application. Following images showcase the output results.

**Slack Channel Output**

![slack-channel-1](https://github.com/user-attachments/assets/fb77905f-35e6-449e-8701-488220d22115)

> [!NOTE]
> Under deploy message you will get the Application URL copy and paste on browser to access the application.

**Application**

![app-1](https://github.com/user-attachments/assets/e96aeda8-2286-4e16-8503-425ae56b3b5d)

![app-2](https://github.com/user-attachments/assets/b67f3705-8f37-4426-93a3-3d5c1228c755)

![app-3](https://github.com/user-attachments/assets/2b67d848-de4b-4e96-acca-fe388dc93ae4)

![app-4](https://github.com/user-attachments/assets/ef0fbc4c-2ea5-4315-a491-c27756e80bb9)

![app-5](https://github.com/user-attachments/assets/a92e51d1-0d57-42a6-a8f7-525bb6ee25e4)


**Booking Form**

![1](https://github.com/user-attachments/assets/f6728e24-c481-4152-b62c-0bd0e5d2a7ed)

![3](https://github.com/user-attachments/assets/941954da-0495-45f1-97a2-a2992e781ef8)


**Contact Form**

![1](https://github.com/user-attachments/assets/86232e6d-0583-4b04-819c-2d238ca8a799)

![2](https://github.com/user-attachments/assets/c867efd3-918e-4642-85ce-2cb2364b29eb)

![3](https://github.com/user-attachments/assets/41a6bb45-7213-433b-b7dc-9e8112bc97dd)


**Comment Form**

![1](https://github.com/user-attachments/assets/ec5e36b5-e1b6-44c5-82d3-783cf785811b)

![2](https://github.com/user-attachments/assets/31c1e0cf-b81b-4899-acc1-5120f388ca1d)

![3](https://github.com/user-attachments/assets/4fc5a3c1-aabf-4f0e-9d0f-8925383d5716)


**Subscribe Form**

![1](https://github.com/user-attachments/assets/9a4da51e-ef45-456d-ba69-72bd678572a0)

![2](https://github.com/user-attachments/assets/ddd32aa5-c661-459f-ba49-e71b504d51c4)

![3](https://github.com/user-attachments/assets/dff1d4b6-837a-4fa7-8cac-45bb70e014a8)


### Step 7: Destroy Resources

Finally if you need to destroy all the resources. For that run the `destroy pipeline` manually in github actions.

**Destroy Pipeline**

![destroy-pipeline](https://github.com/user-attachments/assets/884e1054-edda-4e51-acae-ee5b7778d80c)


**Slack Channel Output**

![slack-channel-2](https://github.com/user-attachments/assets/a5e0d176-8e61-4697-b779-d977cd4c2b49)


### Step 8: Remove Self-Hosted Runner

Finally, you need remove the self-hosted runner and terminate the instance.

1. #### Open your repository 

   Go to Settings --> Actions --> Runners --> Select your runner (git-workflow) --> Remove Runner. Then you will see steps safely remove runner from EC2 instance.

   ```bash
   # Remove the runner
   $ ./config.sh remove --token <your-token>
   ```

2. #### Remove runner 
    
   Go to your EC2 instance and execute the command

   ![runner-remove](https://github.com/user-attachments/assets/84373603-eff3-44b9-ab1c-008cf6a20d44)

> [!WARNING]
> Make sure you are in the right folder `~/actions-runner`

3. **Terminate Instance**

    Go to your AWS Management console --> EC2 terminate the created instance (git-workflow) and then remove any additional resources (vpc, security groups, s3 buckets, dynamodb tables, load balancers, volumes, auto scaling groups, etc)

    **Verify that every resource is removed or terminated**
