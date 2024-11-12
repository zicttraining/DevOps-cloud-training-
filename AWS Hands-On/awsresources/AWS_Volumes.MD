##### AWS Volume

- Launch an instance from aws console in "us-east-1a" AZ.
- check volumes which volumes attached to instance. 
- only root volume should be listed

Create new Volume 

- Create a new volume in the same AZ "us-east-1" with the instance from AWS console "5 GB" for this demo.

- Attach the new volume from aws console, then list block storages again.

- Root volume and secondary volume should be listed
  ```
   lsblk : Code check the storage

  ```
- Check if the attached volume is already formatted or not.
  ```
   sudo file -s /dev/xvdf
  ```
-Format the new volume
```
  sudo mkfs -t ext4 /dev/xvdf
```
-Create a mounting point path for new volume (volume-1)
```
  sudo mkdir /mnt/mp1
```
- Mount the new volume to the mounting point path
 ```  
  sudo mount /dev/xvdf /mnt/mp1/
```
- Show the available space, on the mounting point path
 ``` 
   df -h
```
- Check if there is data on it or not.
```
  ls  /mnt/mp1/
```
-if there is no data on it, create a new file to show persistence in later steps
 ```
  cd /mnt/mp1
  sudo touch hello.txt
  ls
```
#### Enlarge the new volume (volume-1) in AWS console and modify from terminal
- modify the new volume in aws console, enlarge capacity from 5GB to 6GB .
- check if the attached volume is showing the new capacity
```
lsblk
```
 show the real capacity used currently at mounting path, old capacity should be shown.
 ```
 df -h
```
- resize the file system on the new volume to cover all available space.
```
 sudo resize2fs /dev/xvdf
```
- show the real capacity used currently at mounting path, new capacity should reflect the modified volume size.
``` 
 df -h
```
 show that the data still persists on the newly enlarged volume.
 ```
 ls/mnt/mp1/
```