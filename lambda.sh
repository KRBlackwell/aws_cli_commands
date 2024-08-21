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
