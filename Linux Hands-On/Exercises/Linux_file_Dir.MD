**Scenario: Creating a Daily Report File**
You are managing a Linux server and want to create a simple daily log report to track system status. Each day, you will:
    1. Create a new report file.
    2. Add some basic system information to the file (like date, time, and disk usage).
    3. View the report.

**Solution: Step-by-Step**
    
1. Log in as Root
        ◦ First, gain root privileges:
    1. 
    ```
       sudo -i
    ```
2. Create an Archive Directory
        ◦ Create a directory where archived log files will be stored:
    ```   
       mkdir /root/log-archive
    ```
3. Find and Move Log Files Older Than 7 Days
        ◦ Use the find command to locate log files older than 7 days in /var/log/ and move them to the archive directory:
    ```   
       find /var/log/ -type f -mtime +7 -exec mv {} /root/log-archive/ \;
    ```
4. Compress the Archived Log Files
        ◦ Navigate to the archive directory and compress all the log files:
    ```   
       cd /root/log-archive
       tar -czvf logs_backup_$(date +%F).tar.gz *.log
    ```
5. Remove the Original Log Files After Archiving
        ◦ Once compressed, remove the original (uncompressed) log files to save space:
    ```   
       rm *.log
    ```
6. Verify the Archive
        ◦ List the contents of the archive directory to ensure the logs were successfully archived and compressed:
    ```  
       ls -l /root/log-archive
    ```