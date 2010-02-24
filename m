From: Ian Kent <raven@themaw.net>
Subject: Re: automounting smb share with options,
 and suggestion to use fstab entry for direct mounts without options
 and target
Date: Wed, 24 Feb 2010 10:39:42 +0800
Message-ID: <4B84916E.7060208@themaw.net>
References: <4B8416AB.4090207@muc.ccc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B8416AB.4090207@muc.ccc.de>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: x@muc.ccc.de
Cc: autofs@linux.kernel.org

On 02/24/2010 01:55 AM, x@muc.ccc.de wrote:
> hi!
> 
> i've got two issues with autofs, first one:
> 
> i want to mount an smb share. i have to pass username/password as
> well as the server's ip as a mount option (plus uid, gid, and all
> other smb options should be generally accessible using autofs, too, i
> guess). the following doesn't work:
> 
> /srv/smb
> -fstype=smbfs,ip=10.1.2.3,user=administrator,password=secret,uid=smbuser,gid=smbgroup
> //10.1.2.3/C$/

You can't start a mount location with "/" because it will be interpreted
as a path instead of a mount location. The sun ":" escape has always
been used to cover this case.

eg.
/srv/smb  -fstype=smbfs,....  ://10.1.2.3/C$/

Not sure if you will have a problem with the trailing "/", you'll need
to check.

> 
> a mount command with these options (replacing the "-" by "-o ")
> _does_ work. the funny thing is that such a manual mount won't work
> using 10.1.2.3:/C$/ notation, obviously because that already makes
> mount think the fstype must be nfs.
> 
> what i already found out is that the //<server>/<share>/ notation
> seems to cause problems to automount. using 10.1.2.3:/C$/ seems not
> to cause the same problem as when using mount (automount seems to
> still understand the fs type is smb) but it still fails, so it seems
> to mess up the other options somehow.
> 
> now that leads me to the second issue:
> 
> the above fs is in the fstab and currently has to be mounted manually
> when needed. now having that done by automount would be nice. that's
> a simple direct mount, so the idea is to simply add to auto.master:
> 
> /-      /etc/auto.direct
> 
> and to add to /etc/auto.direct:
> 
> /srv/smb
> 
> now the options and target are missing - on purpose. what i mean/find
> most straightforward/find most intuitive, would be to have the
> possibility to just add the mountpoint to the direct mounts, so that
> automount will just mount the fs according to fstab (like when
> calling mount manually with the mountpoint as the only argument). 
> that would btw. also fix/work around the issue #1 :)
> 
> as i mentioned, to me this seems most intuitive. obviously - as
> that's not (the way it was) implemented, others don't. but maybe it's
> still regarded as a nice thing to have?

That's quite an interesting idea and, to be honest, I hadn't thought of
doing it that way. I'm not sure if that could lead to problems though so
I'd need to think about it for a while.

Ian
