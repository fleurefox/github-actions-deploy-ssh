# deploy.sh
#!/bin/bash

# Build Docker image
docker-compose build

# Push Docker image to ECR
$(aws ecr get-login --no-include-email)
docker tag my-app:latest <AWS_ACCOUNT_ID>.dkr.ecr.<AWS_REGION>.amazonaws.com/my-app:latest
docker push <AWS_ACCOUNT_ID>.dkr.ecr.<AWS_REGION>.amazonaws.com/my-app:latest

# SSH into EC2 instance and deploy Docker container
ssh -i <AWS_KEY_PAIR>.pem ec2-user@<EC2_INSTANCE_IP> <<EOF
sudo yum update -y
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -aG docker ec2-user
sudo docker stop my-app || true
sudo docker rm my-app || true
sudo docker pull <AWS_ACCOUNT_ID>.dkr.ecr.<AWS_REGION>.amazonaws.com/my-app:latest
sudo docker run -d --name my-app -p 3000:3000 <AWS_ACCOUNT_ID>.dkr.ecr.<AWS_REGION>.amazonaws.com/my-app:latest 
EOF
