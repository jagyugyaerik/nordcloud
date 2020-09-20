# Set the resource group name and location for your server
PREFIX=jagyugyaerik

RESOURCEGROUPNAME=$PREFIX-rg
LOCATION=westeurope

# Set Vnet and Subnet parameters
VNETNAME=$PREFIX-vnet
SUBNETNAME=$PREFIX-subnet

AKSNAME=$PREFIX-k8s-cluster
AKSNODECOUNT=1
ACRNAME="$PREFIX"acr

IMAGE_NAME=notejam-flask
IMAGE_TAG=dev

# Set an admin login and password for your database
ROOTUSER=azureroot
ROOTPASSWORD=Almafa123456!

# Set a server name that is unique to Azure DNS (<server_name>.database.windows.net)
SERVERNAME=$PREFIX-mysql-server
DATABASENAME=notejam

# Set the ip address range that can access your database
STARTIP=0.0.0.0
ENDIP=0.0.0.0