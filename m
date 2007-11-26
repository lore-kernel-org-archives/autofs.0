From: Ian Kent <raven@themaw.net>
Subject: Re: user token
Date: Tue, 27 Nov 2007 03:23:02 +0900
Message-ID: <1196101382.3381.7.camel@raven.themaw.net>
References: <4a3f02760711260149g1f5be5f9q9fcd2ea5d364b95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4a3f02760711260149g1f5be5f9q9fcd2ea5d364b95@mail.gmail.com>
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
To: muzzol <muzzol@gmail.com>
Cc: autofs@linux.kernel.org

On Mon, 2007-11-26 at 10:49 +0100, muzzol wrote:
> hi!
> 
> is any token related to user trying to mount passed to autofs?
> 
> i've tried $USER and other variables without any success.

So you're not using version 5 then, or are you?

Version 5 sets several variables in the environment, USER, GROUP, HOME,
UID and GID.

> 
> what i want to do is something like:
> 
> ============================================
> 
> #!/bin/bash
> 
> # $Id: auto.smb,v 1.3 2005/04/05 13:02:09 raven Exp $
> 
> # This file must be executable to work! chmod 755!
> 
> key="$1"
> mountopts="-fstype=cifs"
> smbopts=""
> credfile="/home/$USER/auto.smb.$key"
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
> if [ -e $credfile ]; then
>         mountopts="$mountopts,credentials=$credfile"
>         smbopts="-A $credfile"
> else
>         smbopts="-N"
> fi
> 
> $SMBCLIENT $smbopts -gL $key 2>/dev/null| awk -v key="$key" -v
> opts="$mountopts" -F'|' -- '
>         BEGIN   { ORS=""; first=1 }
>         /Disk/  { if (first) { print opts; first=0 }; sub(/ /, "\\ ",
> $2); print " \\\n\t /" $2, "://" key "/" $2 }
>         END     { if (!first) print "\n"; else exit 1 }
>         '
> 
> ============================================
> 
> note the credfile line:
> 
> credfile="/home/$USER/auto.smb.$key"
> 
> if there's no variable, can any additional parameter be passwd to the
> executables mappings beside the key?

No other parameters can be passed to program maps.
I don't really know of a sane way to do this.

Ian
