From: Ian Kent <raven@themaw.net>
Subject: Re: Windows administrative shares broken by v5
Date: Mon, 22 Jan 2007 15:02:26 +0900
Message-ID: <1169445746.4430.16.camel@raven.themaw.net>
References: <530343.39699.qm@web35513.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <530343.39699.qm@web35513.mail.mud.yahoo.com>
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
To: Sandra Bonus <mrsbonus1@yahoo.com>
Cc: autofs@linux.kernel.org

On Sun, 2007-01-21 at 21:36 -0800, Sandra Bonus wrote:
> Here's the entire script
> Note that all the shares are password protected and the user/password is loaded by /opt/maj/standard
> This worked perfectly for autofs 4.1.4 and just stopped working after going to v5
> 
> # $Id: auto.smb,v 1.3 2005/04/05 13:02:09 raven Exp $
> 
> # matthews improved auto.smb file
> # under Fedora Core 4 it successfully mounts all shares in my network
> # including shares ending in $
> 
> . /opt/maj/standard
> 
> # This file must be executable to work! chmod 755!
> key="$1"
> opts="-fstype=cifs,username=$SMB_USER,password=$SMB_PASSWORD"
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
> $SMBCLIENT -U $SMB_USER%$SMB_PASSWORD -gNL $key 2>/dev/null| awk -v key="$key" -v opts="$opts" -F'|' -- '
>         BEGIN   { ORS=""; first=1 }
>         /Disk/  { if (first) { print opts; first=0 }
>         sub(/ /, "\\ ", $2)
>         dir=$2
>         sub ("\\$","\\$",dir)
>         print " \\\n\t /" dir, "://" key "/" dir 
>         }
>         END     { if (!first) print "\n"; else exit 1 }
>         '

This looks ok and "sub ("\\$","\\$",dir)" seems to provide a valid mount
entry to autofs but the "\" in "\$" is being stripped somewhere causing
the parse of the mount entry to fail.

Could you log a Bugzilla against FC-6 for this probelm please.

Ian
