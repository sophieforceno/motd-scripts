# MOTD-scripts
My dynamic MOTD Bash scripts

Inspired by (https://github.com/RIKRUS/MOTD)

Dependencies vary by script, but include: `figlet`, `curl`, `lm-sensors` (`sensors` command), `vmstat`, `transmission-remote`, `pihole`, `screen`, and `fail2ban-server`. 
See the individual scripts for more info. A limitation: some colors display incorrectly in tmux and screen sessions.

## Installation:
	git clone https://github.com/sophieforceno/motd-scripts.git
	cd motd-scripts && cp motd.conf $HOME/.config/
	Don't forget to edit motd.conf!
	My personal preference is to run the scripts under my user only, so I modify .profile to include:

	motd() { for f in /path/to/motd-scripts/*.sh; do bash $f -H; done; }
	motd

## Configuration options:
`$HOME/.config/motd.conf` accepts the following options:
```SERVICES - array of process names
MOUNTPOINTS - Array of disk mountpoints
DOMAINS - Array of domain names
cf - SSL certificate expiration date cache file
f2blog - Fail2ban-server log path
iface - Networking interface to use to calculate bandwidth
location - Used to return current weather conditions via wttr.in
maxCpuTemp - Maximum CPU temp (used to change color based on temps)
maxGpuTemp - Maximum GPU temp
transmissionAddr - IP address of transmission torrent server
transmissionPort - Port number of transmission torrent server
transmissionDir - Subdirectory location of transmission torrent server, e.g. 192.168.1.2/subdirectory
```

### Screenshot:
![alt text][logo]

[logo]: https://github.com/sophieforceno/motd-scripts/blob/9879a13eab555903faa112696407dcd5081dd51b/Screenshot.png "MOTD Scripts"


### The UnLicense

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
