#create an s3 trigger to do something when a file comes to your s3 bucket
#####using lambda, creating a trigger configuration
# lambda triggered by uploading to an s3 bucket: https://www.youtube.com/watch?v=OJrxbr9ebDE
#     this guy uses the aws console
#event is where you will pass in important metadata that we need to call back into s3 with
#event type when setting up lambda will be PUT for aws console and sdk, not POST
#the event is a json file, we're interested in s3 bucket name (s3,bucket/name) and file name (s3/object/key)
import json
import boto3
import csv
import io
s3Client = boto3.client('s3')

def lambda_handler(event, context):
   bucket = event['Records'][0]['s3']['bucket']['name']
   key = event['Records'][0]['s3']['object']['key']
   print(bucket)
   print(key)

   response = s3Client.get_object(Bucket=bucket, Key=key)

   data = response['Body'].read().decode('utf-8')
   reader = csv.reader(io.StringIO(data))
   next(reader)
   for row in reader:
      print(str.format("Year - {}, Mileage - {}, Price - {}", row[0], row[1], row[2]))

    
