System will need to install kubectl, docker, mysql-server, k9s
# Install Docker Desktop on the Windows machine then when 'wsl' is activated, docker will be active

# Install kubectl
$ curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
$ chmod +x kubectl
$ sudo mv kubectl /usr/local/bin/

# Install and start minikube
$ curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
$ sudo install minikube-linux-amd64 /usr/local/bin/minikube
$ sudo usermod -aG docker $USER
$ minikube start --driver=docker

# Install k9s
$ wget https://github.com/derailed/k9s/releases/download/v0.50.9/k9s_Linux_amd64.tar.gz
$ tar -xvzf k9s_Linux_amd64.tar.gz
$ sudo mv k9s /usr/local/bin

# Install mysql-server
$ sudo apt install mysql-server -y
$ sudo service mysql start

$ sudo apt install -y python3-dev default-libmysqlclient-dev build-essential
$ sudo apt install python3.12-venv

# Create virtualenv
python -m venv media-service
source ./media-service/bin/activate
pip install pylint, jedi, flask, flask_mysqldb, pyjwt

# Initialize the database
sudo mysql -uroot < media-service>/python/src/auth/init.sql


# Build auth image
cd media-service/python/src/auth
docker build .
docker tag <image_id> transt059/projects:auth-latest
docker push transt059/projects:auth-latest
minikube delete
minikube start

# Deploy services to minikube
kubectl apply -f ./media-service/python/src/auth/manifest

# Enable ingress to allow access to services
minikube addons enable ingress
minikube tunnel
