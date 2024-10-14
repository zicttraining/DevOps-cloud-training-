**Scenario: Setting Up a Project Workspace**
You are setting up a workspace for a project on your Linux server. You'll:
    1. Create directories and files for the project.
    2. Copy some files to a backup directory.
    3. Find specific files.
    4. Set permissions for users to access these files.
    5. Change the ownership of files and directories.

Solution: Step-by-Step Commands
1. Creating Files and Directories
    • Create a main project directory called project in the /home/user/ directory:
    ``` 
      mkdir /home/user/project
    ``
    • Create subdirectories inside project for organization:
    ```  
      mkdir /home/user/project/docs
      mkdir /home/user/project/code
    ```
    • Create a new file in the docs directory:
    ```  
      touch /home/user/project/docs/readme.txt
    ```
    • Create a script file in the code directory:
    ```  
      touch /home/user/project/code/start.sh
    ```
2. Copying Directories and Files
    • Copy the entire project directory to a backup directory called /home/user/backup_project:
    ```  
      cp -r /home/user/project /home/user/backup_project
    ```
    • Copy the readme.txt file to a different location, such as /tmp:
    ```  
      cp /home/user/project/docs/readme.txt /tmp/
    ```
3. Finding Files and Directories
    • Find all .txt files in the project directory:
    ```  
      find /home/user/project -name "*.txt"
    ```
    • Find all directories within /home/user/project:
    ```  
      find /home/user/project -type d
    ```
4. File and Directory Permissions
    • Set read, write, and execute permissions for the owner on the start.sh script:
    ```  
      chmod 700 /home/user/project/code/start.sh
    ```
    • Set read and write permissions for the owner, and read permissions for the group and others on the readme.txt file:
    ```  
      chmod 644 /home/user/project/docs/readme.txt
    ```
    • Allow everyone to read, write, and execute files in the project directory:
    ```  
      chmod -R 777 /home/user/project
    ```
5. File Ownership Commands (chown and chgrp)
    • Change the ownership of the entire project directory to the user john:
    ```  
      chown -R john /home/user/project
    ```
    • Change the group ownership of the code directory to developers group:
    ```  
      chgrp -R developers /home/user/project/code
    ```
