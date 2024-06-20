#!/bin/bash
# Needed Env: BUCKET_NAME


# Create a S3 bucket
# bucket name: $BUCKET_NAME
# bucket region: ap-northeast-2 (Seoul)
aws s3api create-bucket \
--bucket $BUCKET_NAME \
--create-bucket-configuration LocationConstraint="ap-northeast-2"

# Enable static web hosting
# Default page: index.html
# Default error: error.html
aws s3 website s3://$BUCKET_NAME/ \
    --index-document index.html \
    --error-document error.html


# Configure lock public access
aws s3api put-public-access-block \
    --bucket $BUCKET_NAME \
    --public-access-block-configuration \
    "BlockPublicAcls=false,
    IgnorePublicAcls=false,
    BlockPublicPolicy=false,
    RestrictPublicBuckets=false"


# Create a policy json file
POLICY=$(cat << EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "WebBucketPolicy",
            "Action": "s3:GetObject",
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::$BUCKET_NAME/*",
            "Principal": "*"
        }
    ]
}
EOF
)

echo "$POLICY" > ./web_bucket_policy.json

# Configure bucket policy 
aws s3api put-bucket-policy \
    --bucket $BUCKET_NAME \
    --policy ./web_bucket_policy.json

# Create a production build from the given React application 
cd ./frontend
npm install
npm run build

# Copy the production build to the bucket
aws s3 cp ./dist s3://$BUCKET_NAME/ --recursive 