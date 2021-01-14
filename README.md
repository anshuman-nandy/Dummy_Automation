### Additional Questions : Task 1
If the script runs as expected when run manually but fails when run from Crontab (assuming the script has execute permission):
1. Is /usr/local/mytool added to the PATH ?
If not, either add the same or use full path of mytool to run.
2. If this is not an issue - check which user/group has the execute permission and which user is trying to run the script via cron.

### Additional Questions : Task 2
Debian & Fedora.

### Additional Questions : Task 3
EOF is a heredoc. In bash the cat <<EOF syntax is useful if working with multi-line text for example when assigning multi-line string to a shell variable or writing multi lines to a file. 

### Additional Questions : Task 5
ssh-copy-id -i ~/.ssh/_mykey_ _user@remote-host_
