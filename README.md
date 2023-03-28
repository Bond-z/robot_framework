# Creed Project

## Step clone and install project
- Clone project
- Install project
- Run test case

## Required Package
- Robotframework
- Robotframework-seleniumlibrary
- Robotframework-requests
- robotframework-databaselibrary
- PyYAML
- pymysql
- psycopg2

  
## Command to Install package
- Pip install robotframework robotframework-seleniumlibrary robotframework-requests robotframework-requests robotframework-databaselibrary PyYAML pymysql psycopg2
- pip install -r requirements.txt

## Required Argument
-v ar_BROWSER: chrome
-v ar_HEADLESS: False | True
-v ar_ENVIRONMENT: PRODUCTION | STAGING
-v ar_DOMAIN: LOCAL | PRODUCTION | STAGING | STAGING_CHIMERA | STAGING_SEAL | STAGING_KRAKEN
-v ar_DEVICE: DESKTOP | MOBILE | TABLET

## To run script
robot --nostatusrc  -v ar_ENVIRONMENT:STAGING -v ar_DOMAIN:STAGING -v ar_USER_SET:agent1 -v ar_product:CL -v ar_HEADLESS:False -v ar_DEVICE:MOBILE -d test_result -i dqp-021  TestCase/CL/CL_Quest.robot
