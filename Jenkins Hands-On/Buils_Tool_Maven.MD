# To install Maven on a Windows machine, follow these steps:

1. Download the latest Maven binary zip archive from the Apache Maven website: **https://maven.apache.org/download.cgi**

2. Extract the contents of the zip archive to a directory of your choice. For example, you can extract it to **C:\Program Files\Apache\maven.**

3. Set the MAVEN_HOME environment variable to the directory where you extracted Maven. To do this, follow these steps:
 
      a. Open the Start menu and search for **"Environment Variables".**

      b. Click on **"Edit the system environment variables".**

      c. Click on the **"Environment Variables"** button.

      d. Under **"System Variables"**, click the **"New"** button.

      e. Enter **MAVEN_HOME** as the variable name and the path to the Maven directory as the variable value. For example, **C:\Program Files\Apache\maven.**

      f. Click **"OK"** to save the new system variable.

4. Add the **MAVEN_HOME\bin** directory to your **PATH environment variable.** To do this, follow these steps:
  
      a. Under **"System Variables",** find the Path variable and click **"Edit".**

      b. Click **"New"** and enter **%MAVEN_HOME%\bin.**

     c. Click **"OK"** to save the changes.

5. Verify that Maven is installed by opening a new command prompt and running the following command:
   ```  
   mvn -version
   ```

#### This should display the Maven version, the Java version, and the operating system information.
