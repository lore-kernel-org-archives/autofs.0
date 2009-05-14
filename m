From: Ian Kent <raven@themaw.net>
Subject: Re: unable to automount windows C$
Date: Thu, 14 May 2009 10:23:08 +0800
Message-ID: <4A0B808C.2030705@themaw.net>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz> <4A08FEE6.7000604@themaw.net>
	<4A0A533A.3060203@edcint.co.nz> <4A0A5527.2060207@themaw.net>
	<4A0A59F5.1090308@edcint.co.nz> <4A0A5B80.4040303@themaw.net>
	<4A0A5EE7.3020806@edcint.co.nz> <4A0A7ECB.2060604@themaw.net>
	<4A0B5DED.1090900@edcint.co.nz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050309000907040100000006"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A0B5DED.1090900@edcint.co.nz>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Matthew Jurgens <autofs@edcint.co.nz>
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------050309000907040100000006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Matthew Jurgens wrote:
> 
>> I bet that:
>> mount -t cifs -o username=USER,password=PASS \
>>     '//xp0/C\$' /mnt/C\$
>> fails.
>>
>>   
> Good bet.
> It certainly does fail. The output of mount for that is now:
> 
> //xp0/C/$ on /mnt/C$ type cifs (rw,mand)
> 
> Reading ahead in the thread Jeff says "'\' is a valid character in posix
> path components" which does explain this behaviour
> 
> Do you really need the \ in front of the $ when it is already quoted?
> 
> Reading ahead again I comment out the gsub in /etc/auto.smb which
> changes the output from
> -fstype=cifs,username=USER,password=PASS \
>         /C "://xp0/C" \
>         /ADMIN\$ "://xp0/ADMIN\$" \
>         /C\$ "://xp0/C\$"
> 
> to
> 
> -fstype=cifs,username=USER,password=PASS \
>         /C "://xp0/C" \
>         /ADMIN$ "://xp0/ADMIN$" \
>         /C$ "://xp0/C$"

Of course, it then doesn't escape $ in the offsets.
But, it looks like your script isn't up to date.
I'm fairly sure the current script should output:
 -fstype=cifs,username=USER,password=PASS \
         "/C" "://xp0/C" \
         "/ADMIN$" "://xp0/ADMIN$" \
         "/C$" "://xp0/C$"

which is why I thought we shouldn't need the "\" escapes.
Can you check your auto.smb against the one attached please, in
particular the last line at the bottom of the "/Disk/" block should be:

print " \\\n\t \"/" dir "\"", "\"://" key "/" loc "\""

Ian


--------------050309000907040100000006
Content-Type: text/plain;
 name="auto.smb"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="auto.smb"

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

$SMBCLIENT -gNL $key 2>/dev/null| awk -v key="$key" -v opts="$opts" -F'|' -- '
	BEGIN	{ ORS=""; first=1 }
	/Disk/	{
		  if (first)
			print opts; first=0
		  dir = $2
		  loc = $2
		  # Enclose mount dir and location in quotes
		  # Double quote "$" in location as it is special
		  gsub(/\$$/, "\\$", loc);
		  print " \\\n\t \"/" dir "\"", "\"://" key "/" loc "\""
		}
	END 	{ if (!first) print "\n"; else exit 1 }
	'


--------------050309000907040100000006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------050309000907040100000006--

