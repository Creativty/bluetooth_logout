# Description
A simple autostart script for clearing all bluetooth pairings in an x11 session on logout (Useful for shared computer clusters with personal sessions)

# Why
I am a 1337 student and I use a bluetooth headphones, I often find out that it gets connected to other computers in the cluster because the pairings are not per-session but per-computer.
Therefore I thought that if I use this script I will always guarantee that each time I log onto a computer I can guarantee it won't connect else where.

# How
The concept is really simple; You just `trap` onto the logout signal (a.k.a `SIGHUP`; this information only works on modern systems AFAIK ).
So the trap is to call a command that utilizes `bluetoothctl` subcommands to list and remove all paired devices.
If you want more details you can always check the source code.
