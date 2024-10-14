**Scenario: Backup and Restore of System Configuration Files**
You are an IT administrator managing a Linux-based production server. You need to make changes to some critical configuration files, but before doing so, you want to create a backup of the current configuration. After making the changes, you’ll also need to restore the configuration if anything goes wrong.
The files to back up include:
1. Apache configuration file (/etc/apache2/apache2.conf).
2. MySQL configuration file (/etc/mysql/my.cnf).
3. Network interface settings (/etc/network/interfaces).
You will:
    • Create a backup directory.
    • Copy the files to the backup directory.
    • Simulate making changes.
    • Restore the files from the backup if needed.

Solution: Step-by-Step Commands
1. Log in as Root
        ◦ Switch to the root user to gain appropriate permissions:
       
       ```sudo -i```
2. Create a Backup Directory
        ◦ Navigate to the /root directory (or any directory reserved for the root user) and create a backup directory with today’s date:
    ```   
       cd /root
       mkdir backup_$(date +%F)
    ```
       This command creates a backup directory with the current date (e.g., backup_2024-10-14).
3. Backup Configuration Files
        ◦ Copy the Apache, MySQL, and network configuration files into the new backup directory:
       
    ```   cp /etc/apache2/apache2.conf /root/backup_$(date +%F)/
       cp /etc/mysql/my.cnf /root/backup_$(date +%F)/
       cp /etc/network/interfaces /root/backup_$(date +%F)/
    ```
4. Verify the Backup
        ◦ List the files in the backup directory to verify that the copies were successful:
    ```   
       ls -l /root/backup_$(date +%F)
    ```
5. Simulate a Configuration Change
        ◦ Open and edit one of the configuration files, for example, the Apache configuration file:
    ```   
       code /etc/apache2/apache2.conf
    ```
        ◦ Make some changes, for example, modifying a directive or adding a new virtual host. Save and exit (CTRL + X, Y, then Enter).
    6. Restart the Service to Apply Changes
        ◦ Restart the Apache service to apply the changes:
       
       systemctl restart apache2
    7. Simulate an Issue and Restore from Backup
        ◦ After restarting, you realize that the new changes have broken the Apache service. To restore the original configuration from the backup:
    ```   
       cp /root/backup_$(date +%F)/apache2.conf /etc/apache2/apache2.conf
    ```
    8. Verify the Restore
        ◦ Verify that the backup has been restored by checking the contents of the restored file:
    ```   
       cat /etc/apache2/apache2.conf
    ```
    9. Restart Apache to Apply the Restored Configuration
        ◦ Restart the Apache service again to apply the restored configuration:
       
       systemctl restart apache2
    10. Automating the Backup Process (Optional)
        ◦ You can create a script to automate the backup process. Here’s an example of a simple bash script to back up these configuration files:
    ```   
       #!/bin/bash
       
       BACKUP_DIR="/root/backup_$(date +%F)"
       mkdir -p $BACKUP_DIR
       
       cp /etc/apache2/apache2.conf $BACKUP_DIR
       cp /etc/mysql/my.cnf $BACKUP_DIR
       cp /etc/network/interfaces $BACKUP_DIR
       
       echo "Backup completed at $BACKUP_DIR"
    ```
        ◦ Save the script as backup_config.sh, make it executable, and run it:
    ```   
       chmod +x backup_config.sh
    ```
       ./backup_config.sh
