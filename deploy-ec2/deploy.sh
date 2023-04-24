# deploy.sh
#!/bin/bash

# Build Docker image
docker-compose build

# Push Docker image to ECR
$(aws ecr get-login --no-include-email)
docker tag deploy-ssh 698773564316.dkr.ecr.us-east-1.amazonaws.com/deploy-ssh
docker push 698773564316.dkr.ecr.us-east-1.amazonaws.com/deploy-ssh

# SSH into EC2 instance and deploy Docker container
ssh -i "tech-test.pem" ec2-user@52.203.187.238 <<EOF
sudo yum update -y
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -aG docker ec2-user
sudo docker stop my-app || true
sudo docker rm my-app || true
sudo docker pull 698773564316.dkr.ecr.us-east-1.amazonaws.com/deploy-ssh
sudo docker run -d --name deploy-ssh -p 3000:3000 698773564316.dkr.ecr.us-east-1.amazonaws.com/deploy-ssh
EOF
