#!/bin/bash
 
 ## Capturing the start time with default format
 begin=`date`
 ## going to home directory for the current user
 cd ~
 ## Creating TrueLayer folder, in case it doesn't exist
 mkdir -p TrueLayer
 ## Checking if file exists, if not creates the file
 if [ -f TrueLayer/TLTest.txt ]; then
 touch TrueLayer/TLTest.txt
 fi
 
 ## Printing Script name and start time to the file
 echo "$0 : Script Run Time : $begin" >> TrueLayer/TLTest.txt
 echo "PID : $$ and Run By $USER" >> TrueLayer/TLTest.txt
 
 function print_details
 {
 ## Full list (user:name) of folders in the current directory (which is user's home directory)
 echo "The directories available:" >>TrueLayer/TLTest.txt
 echo " " >>TrueLayer/TLTest.txt
 ls -l | grep '^d' | awk '{print $4,$9}' >> TrueLayer/TLTest.txt
 echo " " >>TrueLayer/TLTest.txt
 
 ## Full list (user:name) of files in the current directory
 echo "The files available:" >>TrueLayer/TLTest.txt
 ls -l | grep -v '^d' | awk '{print $4,$9}' >> TrueLayer/TLTest.txt
 echo " " >>TrueLayer/TLTest.txt
 }
 
 function print_pub_ip
 {
 ##Fetch the public IP
 pub_ip=`curl -s ifconfig.co`
 echo "Public IP : $pub_ip" >> TrueLayer/TLTest.txt
 }
 
 function print_mem
 {
 ## Get Free Memory
 if [ -f /bin/free ]; then
 m_kb=`free -m | tail -2 | head -1 | awk '{print $4}'`
 echo "Free Memory : $m_kb MB" >>TrueLayer/TLTest.txt
 elif [ -f /proc/meminfo ]; then
 m_kb=`grep -w 'MemFree:' /proc/meminfo |  awk '{$2/=1024;printf "%.2fMB\n",$2}'`
 echo "Free Memory : $m_kb" >>TrueLayer/TLTest.txt
 elif [ -f /bin/vmstat ]; then
 m_kb=`vmstat -s | grep -w 'free memory' |  awk '{$1/=1024;printf "%.2fMB\n",$1}'`
 echo "Free Memory : $m_kb" >>TrueLayer/TLTest.txt
 elif [ -f /bin/top ]; then
 m_kb=`top -b -n 1 | grep -w 'KiB Mem :' | awk '{$5/=1024;printf "%.2fMB\n",$5}'`
 echo "Free Memory : $m_kb" >> TrueLayer/TLTest.txt
 else
 echo "Could not track Free Memory" >> TrueLayer/TLTest.txt
 fi
 }
 
 function main
 {
 print_details
 print_pub_ip
 print_mem
 }
 
 main
 echo "End of Script run **" >> TrueLayer/TLTest.txt