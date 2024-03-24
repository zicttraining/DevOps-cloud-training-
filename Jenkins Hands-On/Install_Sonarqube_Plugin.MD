# To install the SonarQube plugin in Jenkins, follow these steps:

1. Open Jenkins and navigate to the **Manage Jenkins** page.

2. Click on the **Manage Plugins** option.

3. Click on the **Available** tab and search for the **SonarQube plugin.**

4. Check the box next to the **SonarQube plugin** and click on the **Install** without restart button.

5. Wait for the plugin to install and then restart Jenkins.

6. Navigate back to the Manage Jenkins page and click on the **Configure System** option.

7. Scroll down to the **SonarQube section** and enter the following information:

8. Name: A name for the SonarQube server.

9. Server URL: **The URL of the SonarQube server.**

10. Server authentication token: The authentication token for the **SonarQube server.**

11. Click on the **Save** button to save the configuration.

12. Navigate to the **Jenkins project** that you want to analyze with SonarQube.

13. Click on the **Configure** option for the project.

14. Scroll down to the **Build section** and click on the **Add build step** button.

15. Select the option to Invoke **Standalone SonarQube Analysis.**

16. Enter the following information:

17. Path to project properties: The path to the SonarQube project properties file.

18. Additional parameters: Any additional parameters that you want to pass to the SonarQube analysis.

19. Click on the Save button to save the project configuration.


#### That's it! You have successfully installed the SonarQube plugin in Jenkins and configured a project to be analyzed with SonarQube