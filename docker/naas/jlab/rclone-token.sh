#!/bin/bash

IAM_TOKEN_ENDPOINT=https://iam.cloud.infn.it/token

curl -s -X POST \
  -u ${IAM_CLIENT_ID}:${IAM_CLIENT_SECRET} \
  -d 'scopes="iam offline_access profile group"' \
  -d grant_type=refresh_token \
  -d refresh_token=${REFRESH_TOKEN} \
  -d audience=object \
  ${IAM_TOKEN_ENDPOINT} | jq -r .access_token
