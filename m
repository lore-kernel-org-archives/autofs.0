From: Jeff Layton <jlayton@redhat.com>
Subject: Re: Not correctly mount SMB shares ending in $
Date: Tue, 16 Sep 2008 06:22:27 -0400
Message-ID: <20080916062227.61121d1c@tleilax.poochiereds.net>
References: <48C5F518.9010800@edcint.co.nz>
	<1221018586.3030.63.camel@raven.themaw.net>
	<48C8D7FE.9000501@edcint.co.nz>
	<1221142584.28271.15.camel@raven.themaw.net>
	<48CB1F71.50407@edcint.co.nz>
	<1221538602.3084.8.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1221538602.3084.8.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Tue, 16 Sep 2008 12:16:42 +0800
Ian Kent <raven@themaw.net> wrote:

> On Sat, 2008-09-13 at 12:03 +1000, Matthew Jurgens wrote:
> > Ok, so I updated the script to the RPM version and added the
> > authentication parts:
> > 
> > #!/bin/bash
> > 
> > # This file must be executable to work! chmod 755!
> > key="$1" # key comes is as something like a hostname eg matthew
> > opts="-fstype=cifs,username=$SMB_USER,password=$SMB_PASSWORD"
> > 
> > smbauthfile=/tmp/smbauth.tmp
> > cat << EOT > $smbauthfile
> > username=$SMB_USER
> > password=$SMB_PASSWORD
> > EOT
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
> > $SMBCLIENT -A $smbauthfile -gL $key 2>/dev/null| awk -v key="$key" -v
> > opts="$opts" -F'|' -- '
> >         BEGIN   { ORS=""; first=1 }
> >         /Disk/  {
> >                   if (first)
> >                         print opts; first=0
> >                   dir = $2
> >                   loc = $2
> >                   # Enclose mount dir and location in quotes
> >                   # Double quote "$" in location as it is special
> >                   gsub(/\$$/, "\\$", loc);
> >                   print " \\\n\t \"/" dir "\"", "\"://" key "/" loc
> > "\""
> >                 }
> >         END     { if (!first) print "\n"; else exit 1 }
> >         '
> > 
> > 
> > 
> > Now its output is slightly different but the result is still the same
> > -fstype=cifs,username=USER,password=PASSWORD \
> >          "/C" "://xp0/C" \
> >          "/ADMIN$" "://xp0/ADMIN\$" \
> >          "/C$" "://xp0/C\$"
> > 
> > vs the older output
> > -fstype=cifs,username=USER,password=PASSWORD \
> >          /C "://xp0/C" \
> >          /ADMIN\$ "://xp0/ADMIN\$" \
> >          /C\$ "://xp0/C\$"
> > mount:
> > //xp0/C/$ on /smb/xp0/C$ type cifs (rw,mand)
> 
> As I said before, the mount command looks OK, but I wonder if any recent
> CIFS kernel changes are getting confused by the "\" in the location
> (aka //xp0/C\$). That would be a bit of a bummer as autofs needs it but
> getting rid of it before the actual mount isn't straight forward.
> 

Yes. There are some recent changes to the mount.cifs command and CIFS
VFS in kernel to try to handle delimiters a little more intelligently
(they were really broken before in some cases). This mount command does
not look right to me though. You have this:

"://xp0/C\$"

...and the mount helper is interpreting that last \ as a delimiter.
Since you have that in quotes already, you shouldn't need to escape the
trailing $. So I think this would be more likely to work:

"://xp0/C$"

Cheers,
-- 
Jeff Layton <jlayton@redhat.com>
