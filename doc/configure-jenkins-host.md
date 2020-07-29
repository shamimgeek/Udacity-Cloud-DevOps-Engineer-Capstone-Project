## Configure Jenkins Host

1. Grab the url from capstone-project-jenkins stack
   ![jenkins_host_url](./images/jenkins_host_url.png)
2. Grab the passsword from jenkins host and paste here
   ```
   sudo cat /var/lib/jenkins/secrets/initialAdminPassword
   ```
   ![jenkins_first_page](./images/jenkins_first_page.png)
3. Install Suggested plugin
   ![install_sugg_plugin](./images/install_sugg_plugin.png)
4. Create First Admin User
5. Home page of jenkins
   ![jenkins_home_page](./images/jenkins_home_page.png)
6. Install plugins: 
   Go to Manage Jenkins -->> Click on Manage plugins -->> Click Available tabs search below plugins and selct and install.
      - CloudBees AWS Credentials Plugin
      - BlueOcean Aggregator
      - Pipeline: AWS Steps
7. Enjoy !!
