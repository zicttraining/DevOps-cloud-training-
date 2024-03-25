# To check network interfaces in Linux, you can use various commands. Here are some common methods based on the provided search results. 

1. Using ifconfig Command (Deprecated but Commonly Used):
  
   Run ifconfig without any options to list available network interfaces.
```
   ifconfig
```
2. Using ip Command (Modern Replacement for ifconfig):
  
   Display detailed information about network interfaces.
```
   ip addr
```
3. Using lshw Utility:

   Utilize 'lshw' with the '-class network -short' options to list network interfaces.
```
  sudo lshw -class network -short
```
4. Using iwconfig Command:
   
   Check available wireless network interfaces.
```
  iwconfig
```
5. Viewing /proc/net/dev File:
   
   Access statistics about network interfaces.
```
   cat /proc/net/dev
```
6. Using nmcli Command:

   Display summary information about network interfaces.
```
   nmcli device status
```
7. Using netstat Command:
   
  Show a list of available network interfaces.
```
  netstat -i
```
8. Additional Commands for Network Interface Information:
 ```
    ethtool: Display and control Ethernet device settings.
    tcpdump: Capture and analyze network traffic.
    ss: Replacement for netstat, providing socket-related information.
```

#### These commands provide various ways to check and manage network interfaces on a Linux system. Choose the appropriate command based on your specific requirements and the level of detail you need about the network configuration.























































