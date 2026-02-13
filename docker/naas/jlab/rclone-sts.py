#!/usr/bin/env python

import boto3
import json
import os

def main():
    creds = {}
    os.environ["AWS_CONFIG_FILE"] = ""
    sts_client = boto3.client('sts',
            endpoint_url="https://rgw.cloud.infn.it/",
            region_name='default'
    )
    assume_response = sts_client.assume_role_with_web_identity(
                RoleArn="arn:aws:iam:::role/IAMaccess",
                RoleSessionName="bob",
                DurationSeconds=3600,
                WebIdentityToken=os.environ["ACCESS_TOKEN"]
    )
    creds = assume_response['Credentials']
    creds['Expiration'] = creds.get('Expiration').isoformat()
    creds['Version'] = 1
    return json.dumps(creds, indent=2, default=str)

if __name__ == "__main__":
    print(main())
