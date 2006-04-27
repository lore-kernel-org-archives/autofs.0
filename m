From: W1657801@Queens-Belfast.AC.UK
Subject: auto.smb (null) and other issues
Date: 27 Apr 2006 03:38:17 +0000
Message-ID: <Prayer.1.0.12.0604270338170.1663@amos>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; format="flowed"; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hi,

I have come across some issues when try automount samba shares using 
auto.smb on fedora core 5.

I had to
1)Uncomment the smb section in auto.master
2)Add hostnames to /etc/hosts to do hostname to ip translation

Then to solve some problems I had to 3)change the opts line in auto.smb to 
read opts="-fstype=cifs" 4)apply one line patch to auto.smb to allow the 
system to read shares with spaces - /Disk/ { if (first) { print opts; 
first=0 }; print " \\\n\t /" $2, "://" key "/" $2 } + /Disk/ { if (first) { 
print opts; first=0 }; sub(/ /, "\\ ", $2); print " \\\n\t /" $2, "://" key 
"/" $2 }

Now the real problem is this, when I cd /smb/sigma the shares mount fine (i 
check ed the logfile).

However WHEN I do an ls -l i get a (null) entry in the listing. Why is this 
here?


$ ll
total 0
drwxrwxrwx 1 root root 0 Apr  3 16:48 music
dr-xr-xr-x 8 root root 0 Apr 26 18:13 (null)
drwxrwxrwx 1 root root 0 Mar 29  2005 XLNX
..etc

AND now taking a look in the debug log file I have this entry...for some 
reason it is trying to mount everthing in /smb/sigma into 
/smb/sigma/(null)/ which of course fails, with lots of error messages.

automount[1661]: handle_packet_missing: token 2, name sigma/(null) 
automount[1661]: attempting to mount entry /smb/sigma/(null) 
automount[2279]: lookup(program): looking up sigma/(null) automount[2279]: 
lookup(program): sigma/(null) -> -fstype=cifs /XLNX ://sigma/(null)/XLNX 
/My\ Videos ://sigma/(null)/My\ Videos /music ://sigma/(null)/music 
/Incoming ://sigma/(null)/Incoming automount[2279]: parse(sun): expanded 
entry: -fstype=cifs /XLNX ://sigma/(null)/XLNX /My\ Videos 
://sigma/(null)/My\ Videos /music ://sigma/(null)/music /Incoming 
://sigma/(null)/Incoming aopen automount[2279]: parse(sun): 
dequote("fstype=cifs") -> fstype=cifs aopen automount[2279]: parse(sun): 
gathered options: fstype=cifs [lots of inevitable error messages not shown]



THEN it tries to do everthing in /smb/sigma into /smb/sigma/(null)/mls/!!! 
The mls would most likely have something to do with the ls command that I 
used to get a directory listing


automount[1661]: handle_packet_missing: token 3, name sigma/(null)/mls 
automount[1661]: attempting to mount entry /smb/sigma/(null)/mls 
automount[2291]: lookup(program): looking up sigma/(null)/mls 
automount[2291]: lookup(program): sigma/(null)/mls -> -fstype=cifs /XLNX 
://sigma/(null)/mls/XLNX /My\ Videos ://sigma/(null)/mls/My\ Videos /music 
://sigma/(null)/mls/music /Incoming ://sigma/(null)/mls/Incoming 
automount[2291]: parse(sun): expanded entry: -fstype=cifs /XLNX 
://sigma/(null)/mls/XLNX /My\ Videos ://sigma/(null)/mls/My\ Videos /music 
://sigma/(null)/mls/music /Incoming ://sigma/(null)/mls/Incoming 
automount[2291]: parse(sun): dequote("fstype=cifs") -> fstype=cifs

Why does the automounter create a (null) folder, and then why does it try 
and mount stuff inside the (null)/ and (null)/mls/ folder after doing a 
directory listing on the hostname

Also, can points 3 and 4 above be fixed in the default auto.smb script 
distributed.

cheers,
Neil



[me@aopen ~]$ cat /etc/auto.smb
#!/bin/bash

# $Id: auto.smb,v 1.3 2005/04/05 13:02:09 raven Exp $

# This file must be executable to work! chmod 755!

key="$1"
opts="-fstype=cifs"

for P in /bin /sbin /usr/bin /usr/sbin
do
        if [ -x $P/smbclient ]
        then
                SMBCLIENT=$P/smbclient
                break
        fi
done

[ -x $SMBCLIENT ] || exit 1

$SMBCLIENT -gNL $key 2>/dev/null| awk -v key="$key" -v opts="$opts" -F'|' 
-- '
        BEGIN   { ORS=""; first=1 }
        /Disk/ { if (first) { print opts; first=0 }; sub(/ /, "\\ ", $2); 
print " \\\n\t /" $2, "://" key "/" $2 }
        END     { if (!first) print "\n"; else exit 1 }
        '
