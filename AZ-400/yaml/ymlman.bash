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
P=$(az account show --query id)
R=${P:$(echo `expr index "$P" '"'`)}
L=${R:: -1}

clear

echo -e "\nPlease take a note of these \nHosting Plan Name is $HP \nResource Group Name is $RG\nWebsite Name is $E\nServer Name is $E \nSubscription id is $L"


#

