#!/bin/bash

#
# Author: Haisam Ido
# A bash script to describe ones own AWS infrastructure and the results a redirected to S3
#

AWS_PROFILE="myprofile" # Make sure this profile does have restricted access to the bucket
BUCKET="mybucket"   # Make sure that this S3 bucket has the appropriate level of security policy for your needs.

describes=(
  describe-addresses
  describe-volumes
  describe-subnets
  describe-vpcs 
  describe-instances 
  describe-network-interfaces 
  describe-security-groups
  describe-key-pairs
  describe-route-tables
)

for describe in "${describes[@]}"
do
  echo "[$describe]"
#  aws ec2 "$describe" --profile $AWS_PROFILE  > "${describe}".json # uncomment this line if you want to store them locally
  aws ec2 "$describe" --profile $AWS_PROFILE | aws s3 cp - "s3://${BUCKET}/${describe}.json" --profile $AWS_PROFILE
done
