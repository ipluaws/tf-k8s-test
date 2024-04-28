This project is entirely built within the AWS environment, utilizing an AWS EKS Kubernetes cluster. Infrastructure provisioning is automated using Terraform code.

**Step 1: Set Up AWS Environment with Terraform**

1.1. Configure your local machine with AWS credentials using the aws configure command. Provide your access key, secret access key, and preferred region.

1.2. Clone the GitHub repository containing the Terraform code.

1.3. Update the values in the variables.tf file to match your environment setup. This includes configurations such as VPC name, CIDR blocks, subnet configurations, availability zones, and cluster name.

1.4. Provision the infrastructure by running the following Terraform commands:

$terraform init
$terraform validate
$terraform plan
$terraform apply

Finally the 'apply' command will provision the basic infrastructure components like VPC, ECR repository, EKS cluster, and necessary policies and security groups.

**Step 2: Configure Kubernetes Cluster**

2.1. Navigate to the /k8s directory within the cloned repository ($cd k8s/).

2.2. Execute the prep.sh script ($./prep.sh). This script updates the .kube/config file and deploys the cluster autoscaler and metrics-server in the kube-system namespace.

**Step 3: Build and Push Docker Image to ECR**

3.1. Build the Docker image using the following command:

$docker build -t {account-id}.dkr.ecr.{region}.amazonaws.com/{repo-name} .

3.2. Authenticate Docker with ECR:

$aws ecr get-login-password --region {region} | docker login --username AWS --password-stdin {account-id}.dkr.{region}.amazonaws.com

3.3. Push the Docker image to ECR:

$docker push {account-id}.dkr.ecr.{region}.amazonaws.com/{repo-name}

Replace '{region}', '{account-id}', and '{repo-name}' with your specific values.

**Step 4: Deploy Application to Kubernetes**

4.1. After pushing the Docker image to the Docker registry, apply the Kubernetes configuration file (nodejs-app.yaml) using the command:

$kubectl apply -f nodejs-app.yaml

**Step 5: Access the Application**

5.1. A Type: LoadBalancer ingress service has been declared, which creates an AWS NLB providing external access to the application.

5.2. Retrieve the public address to access the application using the command:

$kubectl get svc nodejs-app -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

5.3. Copy the output and paste it into your browser's address bar along with the specified endpoints (/healthz, /ready, and /).

Example:
http://xxxxxxx-dbe9035230c86932.elb.<region>.amazonaws.com/
http://xxxxxxx-dbe9035230c86932.elb.<region>.amazonaws.com/healthz
http://xxxxxxx-dbe9035230c86932.elb.<region>.amazonaws.com/ready

**Step 6: Auto-Scaling**

6.1. HorizontalPodAutoscaler (HPA) has been configured to scale based on maximum CPU utilization of 50%.

6.2. To test auto-scaling, increase the replica number from 3 to 6 in nodejs-app.yaml. This will trigger the Kubernetes cluster to increase the number of nodes to accommodate the application's load.

By following these steps, you can set up, deploy, and access your Node.js application on Kubernetes in an AWS environment, while also configuring auto-scaling to handle varying workloads.
