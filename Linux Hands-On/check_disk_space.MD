# Checking disk space is an essential task for system administrators. Here are some Linux commands to check disk space:

1. df: The df command stands for "disk-free" and shows available and used disk space on the Linux system. It displays the amount of disk space available on the filesystem with each file name's argument.


To display disk space in human-readable format, use the '-h' option. 

For example:
```
df -h
```
2. du: The du command shows the disk usage of files, folders, etc. in the default kilobyte size. To display disk usage in human-readable format for all directories and subdirectories, use the '-h' option. 

For example:
```
du -h
```
3. ncdu: The 'ncdu' command is a disk usage analyzer with an interactive interface. It allows you to navigate through directories and view disk usage in real-time. To install 'ncdu', use the following command:
```
sudo apt-get install ncdu
```
To use 'ncdu', navigate to the directory you want to analyze and run the following command:
```
ncdu
```
4. File Managers: Many file managers, such as Nautilus, Dolphin, and Thunar, have built-in disk usage analyzers. These tools provide a graphical representation of disk usage and allow you to navigate through directories and view disk usage in real-time.


#### These commands provide essential functionalities for checking disk space in Linux, allowing users to monitor disk usage and optimize storage efficiently