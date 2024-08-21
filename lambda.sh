#these aren't from work, they're from https://www.youtube.com/watch?v=VaKBH8H4DNQ
#aws cli interacts with the lambda api
aws --version
aws iam create-role --role-name lambda-ex --assume-role-policy-document '{"Version": "2012-10-17","Statement":[{"Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}'

#example has nodejs code in index.js
#    exports.handler = async function ... {
#      ... console.log ...
#     }
# make a deployable package, include any dependencies if they exist
#    Compress-Archive index.js function.zip

#create the lambda function
aws lambda create-function --function-name my-function --zip-file fileb://function.zip --handler index.handler --runtime nodejs18.x --role arn:aws:iam::978558897928:role/lambda-ex

#can invoke the function from the command line too
#base64 utility decodes the log
aws lambda invoke --function-name my-function out --log-type Tail --query 'LogResult' --output text | .\base64 -d

#can update the configuration too, e.g. add more memory
aws lambda update-function-configuration --function-name my-function --memory-size 256

#can delete the function
aws lambda delete-function --function-name my-function

# #####using lambda, creating a trigger configuration
# # lambda triggered by uploading to an s3 bucket: https://www.youtube.com/watch?v=OJrxbr9ebDE
# #     this guy uses the aws console
# #event is where you will pass in important metadata that we need to call back into s3 with
# #the event is a json file, we're interested in s3 bucket name (s3,bucket/name) and file name (s3/object/key)
# import json
# import boto3
# import csv
# import io
# s3Client = boto3.client('s3')

# def lambda_handler(event, context):
#    bucket = event['Records'][0]['s3']['bucket']['name']
#    key = event['Records'][0]['s3']['object']['key']
#    print(bucket)
#    print(key)
#     return{
#         'statusCode': 200,
#         'body': json.dumps('Hello from Lambda!')
#     }
    ##event type will be PUT for aws console and sdk, not POST
    
