## Create scenario 1
1. Create secret.tfvars file has three parameter 
```
aws_access_key="YOUR_ACCESS_KEY"
aws_secret_key="YOUR_SECRET_KEY"
my_account_id="YOUR_ACCOUNT_ID"

```

2. Create s3 bucket as backend with default parameter in backend.tf file
```
You can fully change all paramters 
```

3. Terraform init 
```
terraform init 
```

4. Add K8s auth to remote state 

```
terraform import kubernetes_config_map.aws-auth kube-system/aws-auth

```

5. Terraform plan
```
terraform plan -var-file="secret.tfvars"
```

6. Terraform apply 
```
terraform apply -var-file="secret.tfvars" --auto-approve
```

7. Get secret key of interviewee user 
```
terraform output -raw secret
```

8. Add interviewee user to EKS cluster 
```
 rm ~/.kube/config  
 aws eks update-kubeconfig --region  ap-southeast-1 --name pbl-04-2022-cluster
 kubectl edit configmap/aws-auth -n kube-system

Add  
  mapUsers: |
    - userarn: arn:aws:iam::{YOUR_ACCOUNT_ID}:user/sre-interviewee
      username: sre-interviewee
      groups:
        - system:masters
after mapRoles section
```

9. Get some informations from output and send them to interviewee

10. Terraform destroy 
Remove mapUser section added above and run: 
```
terraform destroy -var-file="secret.tfvars" --auto-approve
```