# Configure Jenkins Pipeline from the repo

1. Login to Jenkins with your admin user and pass
2. Create below credentials: Go to Manage jenkins --> Manage Credentials -- > click on global
   - dockerhubCredentials
   - aws-credentials
   ![manage_credentials](./images/manage_credentials.png)
   ![dockerhub_credentials](./images/dockerhub_credentials.png)
   ![aws_credentials](./images/aws_credentials.png)

3. Create Pipeline integrate with github
   Click on Open Blue Ocean
   ![select_blue_ocean](./images/select-blue-ocean.png)
   Select Github --> Click on Create an access token here -- > authenticate github --> give some name for token ---> Copy Token and paste in jenkins -- > select which organization does the repository belong to
   ![select_github_create_token](./images/select_github_create_token.png)
   Select Repository and create pipeline.
   ![select_repo](./images/select_repo.png)
4. Enjoy !!!
