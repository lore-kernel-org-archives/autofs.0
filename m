From: Ian Kent <raven@themaw.net>
Subject: Re: Not correctly mount SMB shares ending in $
Date: Sat, 13 Sep 2008 11:09:20 +0800
Message-ID: <1221275360.2965.3.camel@raven.themaw.net>
References: <48C5F518.9010800@edcint.co.nz>
	<1221018586.3030.63.camel@raven.themaw.net>
	<48C8D7FE.9000501@edcint.co.nz>
	<1221142584.28271.15.camel@raven.themaw.net>
	<48CB1F71.50407@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48CB1F71.50407@edcint.co.nz>
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
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Sat, 2008-09-13 at 12:03 +1000, Matthew Jurgens wrote:
> Ok, so I updated the script to the RPM version and added the
> authentication parts:

Right, the reason the script changed was because of the "$" shares.
I thought it was working ok but maybe a subsequent change to the daemon
has broken it.

I'll try to duplicate the problem here but a debug log would also be
useful. See http://people.redhat.com/jmoyer for details.

> 
> #!/bin/bash
> 
> # This file must be executable to work! chmod 755!
> key="$1" # key comes is as something like a hostname eg matthew
> opts="-fstype=cifs,username=$SMB_USER,password=$SMB_PASSWORD"
> 
> smbauthfile=/tmp/smbauth.tmp
> cat << EOT > $smbauthfile
> username=$SMB_USER
> password=$SMB_PASSWORD
> EOT
> 
> for P in /bin /sbin /usr/bin /usr/sbin
> do
>         if [ -x $P/smbclient ]
>         then
>                 SMBCLIENT=$P/smbclient
>                 break
>         fi
> done
> 
> [ -x $SMBCLIENT ] || exit 1
> 
> $SMBCLIENT -A $smbauthfile -gL $key 2>/dev/null| awk -v key="$key" -v
> opts="$opts" -F'|' -- '
>         BEGIN   { ORS=""; first=1 }
>         /Disk/  {
>                   if (first)
>                         print opts; first=0
>                   dir = $2
>                   loc = $2
>                   # Enclose mount dir and location in quotes
>                   # Double quote "$" in location as it is special
>                   gsub(/\$$/, "\\$", loc);
>                   print " \\\n\t \"/" dir "\"", "\"://" key "/" loc
> "\""
>                 }
>         END     { if (!first) print "\n"; else exit 1 }
>         '
> 
> 
> 
> Now its output is slightly different but the result is still the same
> -fstype=cifs,username=USER,password=PASSWORD \
>          "/C" "://xp0/C" \
>          "/ADMIN$" "://xp0/ADMIN\$" \
>          "/C$" "://xp0/C\$"
> 
> vs the older output
> -fstype=cifs,username=USER,password=PASSWORD \
>          /C "://xp0/C" \
>          /ADMIN\$ "://xp0/ADMIN\$" \
>          /C\$ "://xp0/C\$"
> mount:
> //xp0/C/$ on /smb/xp0/C$ type cifs (rw,mand)
> 
> 
> > 
> > That doesn't look quite right.
> > It might be an out of date script, how about posting the script as well
> >   
> > 
