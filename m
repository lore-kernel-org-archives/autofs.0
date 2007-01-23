From: Ian Kent <raven@themaw.net>
Subject: Re: Windows administrative shares broken by v5
Date: Tue, 23 Jan 2007 10:14:52 +0900
Message-ID: <1169514892.3594.24.camel@raven.themaw.net>
References: <758243.87483.qm@web35513.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <758243.87483.qm@web35513.mail.mud.yahoo.com>
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

On Mon, 2007-01-22 at 14:40 -0800, Sandra Bonus wrote:
> That certainly seems to work
> 
> I think I'd tried quoting both the mount point and the mount device but not just the mount device as you have pointed out.

That's good.
At least you have something that will work for now.

In my testing I've found an inconsistency with the handling of the
double quotes. The quoting both didn't work. I think I've fixed that but
"$" in the mount location (the share) still needs to be double quoted. I
need to do some more testing on this to be sure I handle double quotes
in a consistent manner. So there will likely be a further change.

> 
> Thanks
> 
> ----- Original Message ----
> From: Ian Kent <raven@themaw.net>
> To: Sandra Bonus <mrsbonus1@yahoo.com>
> Cc: autofs@linux.kernel.org
> Sent: Monday, January 22, 2007 6:18:27 PM
> Subject: Re: [autofs] Windows administrative shares broken by v5
> 
> On Mon, 2007-01-22 at 16:13 +0900, Ian Kent wrote:
> 
> I'm being a bit hasty here.
> We'll need to do some testing with this.
> See below.
> 
> > > > 
> > > > # $Id: auto.smb,v 1.3 2005/04/05 13:02:09 raven Exp $
> > > > 
> > > > # matthews improved auto.smb file
> > > > # under Fedora Core 4 it successfully mounts all shares in my network
> > > > # including shares ending in $
> > > > 
> > > > . /opt/maj/standard
> > > > 
> > > > # This file must be executable to work! chmod 755!
> > > > key="$1"
> > > > opts="-fstype=cifs,username=$SMB_USER,password=$SMB_PASSWORD"
> > > > 
> > > > for P in /bin /sbin /usr/bin /usr/sbin
> > > > do
> > > >         if [ -x $P/smbclient ]
> > > >         then
> > > >                 SMBCLIENT=$P/smbclient
> > > >                 break
> > > >         fi
> > > > done
> > > > 
> > > > [ -x $SMBCLIENT ] || exit 1
> > > > 
> > > > $SMBCLIENT -U $SMB_USER%$SMB_PASSWORD -gNL $key 2>/dev/null| awk -v key="$key" -v opts="$opts" -F'|' -- '
> > > >         BEGIN   { ORS=""; first=1 }
> > > >         /Disk/  { if (first) { print opts; first=0 }
> > > >         sub(/ /, "\\ ", $2)
> > > This line is no longer needed
> 
> Keep this line as well or the keys won't preserve the spaces.
> 
> > > >         dir=$2
> > > >         sub ("\\$","\\$",dir)
> > > >         print " \\\n\t /" dir, "://" key "/" dir 
> > > The updated print encloses each mount entry in double quotes
> > > >         }
> > > >         END     { if (!first) print "\n"; else exit 1 }
> > > >         '
> > > 
> > > $SMBCLIENT -U $SMB_USER%$SMB_PASSWORD -gNL $key 2>/dev/null| awk -v key="$key" -v opts="$opts" -F'|' -- '
> > >     BEGIN   { ORS=""; first=1 }
> > >     /Disk/  { if (first) { print opts; first=0 }
> > >     dir=$2
> > >     sub ("\\$","\\$",dir)
> > >     print " \\\n\t /" $2, "\"://" key "/" $2 "\"";
> > oops, that should be
> >       print " \\\n\t /" dir, "\"://" key "/" dir "\""
> > >     }
> > >     END     { if (!first) print "\n"; else exit 1 }
> > >     '
> 
> 
> 
> 
> 
> 
> 
>  
> ____________________________________________________________________________________
> Don't get soaked.  Take a quick peak at the forecast
> with the Yahoo! Search weather shortcut.
> http://tools.search.yahoo.com/shortcuts/#loc_weather
