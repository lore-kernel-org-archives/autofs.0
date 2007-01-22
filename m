From: Ian Kent <raven@themaw.net>
Subject: Re: Windows administrative shares broken by v5
Date: Mon, 22 Jan 2007 16:13:17 +0900
Message-ID: <1169449997.4430.33.camel@raven.themaw.net>
References: <530343.39699.qm@web35513.mail.mud.yahoo.com>
	<1169449675.4430.30.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1169449675.4430.30.camel@raven.themaw.net>
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

On Mon, 2007-01-22 at 16:08 +0900, Ian Kent wrote:
> On Sun, 2007-01-21 at 21:36 -0800, Sandra Bonus wrote:
> > Here's the entire script
> > Note that all the shares are password protected and the user/password is loaded by /opt/maj/standard
> > This worked perfectly for autofs 4.1.4 and just stopped working after going to v5
> 
> Yes, this is due to the change in the way multi-mount entries are
> handled in version 5. This change was made in order to provide on demand
> mounting of these multiple mount entries instead of requiring them all
> to be mounted at once. This results in the "$" to end up not being
> quoted causing the parser to fail.
> 
> However, version 5 does support using double quotes to preserve entries
> (so far only in maps, not the master map itself) in addition to the
> usual "\" quoting. Since the "$" is special because it's used for macro
> substitution it needs to be double quoted.
> 
> Try change below.
> Note that this won't work with version 4.
> 
> > 
> > # $Id: auto.smb,v 1.3 2005/04/05 13:02:09 raven Exp $
> > 
> > # matthews improved auto.smb file
> > # under Fedora Core 4 it successfully mounts all shares in my network
> > # including shares ending in $
> > 
> > . /opt/maj/standard
> > 
> > # This file must be executable to work! chmod 755!
> > key="$1"
> > opts="-fstype=cifs,username=$SMB_USER,password=$SMB_PASSWORD"
> > 
> > for P in /bin /sbin /usr/bin /usr/sbin
> > do
> >         if [ -x $P/smbclient ]
> >         then
> >                 SMBCLIENT=$P/smbclient
> >                 break
> >         fi
> > done
> > 
> > [ -x $SMBCLIENT ] || exit 1
> > 
> > $SMBCLIENT -U $SMB_USER%$SMB_PASSWORD -gNL $key 2>/dev/null| awk -v key="$key" -v opts="$opts" -F'|' -- '
> >         BEGIN   { ORS=""; first=1 }
> >         /Disk/  { if (first) { print opts; first=0 }
> >         sub(/ /, "\\ ", $2)
> This line is no longer needed
> >         dir=$2
> >         sub ("\\$","\\$",dir)
> >         print " \\\n\t /" dir, "://" key "/" dir 
> The updated print encloses each mount entry in double quotes
> >         }
> >         END     { if (!first) print "\n"; else exit 1 }
> >         '
> 
> $SMBCLIENT -U $SMB_USER%$SMB_PASSWORD -gNL $key 2>/dev/null| awk -v key="$key" -v opts="$opts" -F'|' -- '
> 	BEGIN   { ORS=""; first=1 }
> 	/Disk/  { if (first) { print opts; first=0 }
> 	dir=$2
> 	sub ("\\$","\\$",dir)
> 	print " \\\n\t /" $2, "\"://" key "/" $2 "\"";
oops, that should be
	  print " \\\n\t /" dir, "\"://" key "/" dir "\""
> 	}
> 	END     { if (!first) print "\n"; else exit 1 }
> 	'
> > 
> > 
> > 
> > 
> > ----- Original Message ----
> > From: Ian Kent <raven@themaw.net>
> > To: Sandra Bonus <mrsbonus1@yahoo.com>
> > Cc: autofs@linux.kernel.org
> > Sent: Monday, January 22, 2007 4:22:44 PM
> > Subject: Re: [autofs] Windows administrative shares broken by v5
> > 
> > On Sun, 2007-01-21 at 18:19 -0800, Sandra Bonus wrote:
> > > I'm running fedora Core
> > > 
> > > I had made a similar patch to the one described in 
> > > http://linux.kernel.org/pipermail/autofs/2006-December/003554.html
> > > 
> > > to allow the mounting of Windows administrative shares
> > > This was all fine on v4.1.4
> > > 
> > > However as soon as I installed v 5.0.1-0.rc3.2 this was broken and shares ending in $ could not be mounted. I played around with the output of /etc/auto.smb for a while but could not work out a variation that made the admin shares work again.
> > > 
> > > Any ideas?
> > 
> > What is the patch your trying to use?
> > 
> > Ian
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> >  
> > ____________________________________________________________________________________
> > Don't pick lemons.
> > See all the new 2007 cars at Yahoo! Autos.
> > http://autos.yahoo.com/new_cars.html 
