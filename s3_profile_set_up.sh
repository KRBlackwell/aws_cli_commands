#this creates a $HOME/.aws folder with credentials for accessing the S3 bucket
#store credentials in .env 
export S3KEY= access key
export S3KEYID = access key id
export LDAP_GROUP=my ldap group for the data lake
aws configure set profile.${LDAP_GROUP}.aws_access_key_id $S3KEYID
aws configure set profile.${LDAP_GROUP}.aws_secret_access_key $S3KEY
aws configure set profile.${LDAP_GROUP}.region us-gov-west-1
aws configure set profile.${LDAP_GROUP}.output json

#test like this, remember the slash after the endpoint path or else you get "access denied"
#echo "roberto clemente" > test1.txt
#aws --region us-gov-west-1 --profile $LDAP_GROUP s3 cp test1.txt s3://endpoint/

