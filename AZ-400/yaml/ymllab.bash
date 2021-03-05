# Get Login Name
a=$(az ad signed-in-user show --query userPrincipalName)
# Get change Login Name to lower-case
A=$(echo "$a" | sed -e 's/\(.*\)/\L\1/')
B=${A:$(echo `expr index "$A" @`)}
# Create Variables
C=${B:: -24}
D=$(echo "$C"ydb01)
E=$(echo "$C"ywa01)
RG=YAML
L=EastUS
HP=YML-SVC01
user=sysadmin
pass=1q2w3e4r5t6y*
startip=0.0.0.0
endip=255.255.255.255

Y=$(echo "'Data Source=tcp:"$D".database.windows.net,1433;Initial Catalog=partsunlimited;User Id=sysadmin@"$D".database.windows.net;Password="$pass";'")

az provider register --namespace Microsoft.insights

# Create Resource Group
az group create --name $RG --location $L

# Create DB Server
az sql server create -l $L -g $RG -n $D -u $user -p $pass

# Create DB 
az sql db create -g $RG -s $D -n partsunlimited --service-objective S0

az sql server firewall-rule create \
    --resource-group $RG \
    --server $D \
    --name AllowYourIp \
    --start-ip-address $startip \
    --end-ip-address $endip

# Create Service Plan for webapp
az appservice plan create -n $HP --sku S1 -g $RG -l $L

# Create WebApp
az webapp create -g $RG -p $HP -n $E


#Add DB Connection string to webapp
az webapp config connection-string set --connection-string-type SQLAzure --name $E --resource-group $RG --settings DefaultConnectionString="$Y"

echo -e "\nPlease take a note of these \nHosting Plan Name is $HP \nResource Group Name is $RG\nServer Name is $E\nWebsite Name is $E \n"

