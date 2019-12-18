echo "installing terraform"

sudo yum install unzip

wget https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip

unzip terraform_0.12.18_linux_amd64.zip

sudo mv terraform /usr/local/bin/

terraform --version

echo "terraform succesfully installed"

echo "installing aws-iam-authenticator"

curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator

chmod +x ./aws-iam-authenticator

mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH

echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc

echo "aws- iam-authenticator succesfully installed"

echo "installing kubectl"

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin/kubectl

kubectl version

echo " kubectl succesfully installed"

echo "installing eksctl"

curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv /tmp/eksctl /usr/local/bin

eksctl version

echo " eksctl succesfully installed"


cd infra

terraform init 

terraform apply --auto-approve

cd ..

eksctl create cluster -f cluster.yaml



kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.4/docs/examples/rbac-role.yaml
kubectl apply -f ./ingress-controller/alb-ingress-controller.yaml

kubectl apply -f ./accesscontrol

kubectl apply -f./Frontend
kubectl apply -f./Backend
kubectl apply -f ./ingress-controller/ingress.yaml

aws cloudformation create-stack --stack-name simplr-nlb-alb --region us-east-2 --template-body file://nlb.json --parameters file://parameters.json --capabilities  CAPABILITY_IAM  CAPABILITY_NAMED_IAM  CAPABILITY_AUTO_EXPAND

