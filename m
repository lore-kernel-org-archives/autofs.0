From: Ian Kent <ikent@redhat.com>
Subject: Re: NFSv4 to be a default on RHEL-6
Date: Thu, 09 Dec 2010 22:51:25 +0800
Message-ID: <1291906285.2899.27.camel@perseus>
References: <4CFF4CE8.6080708@s3group.cz> <1291811765.17231.6.camel@perseus>
	<4CFF7F35.9070506@s3group.cz> <1291815950.17231.26.camel@perseus>
	<4CFF9C98.1060706@s3group.cz>  <4D00D0C4.8050704@RedHat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4D00D0C4.8050704@RedHat.com>
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
To: Steve Dickson <SteveD@redhat.com>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Thu, 2010-12-09 at 07:51 -0500, Steve Dickson wrote:
> 
> On 12/08/2010 09:56 AM, Ondrej Valousek wrote:
> > On 08.12.2010 14:45, Ian Kent wrote:
> >> On Wed, 2010-12-08 at 13:51 +0100, Ondrej Valousek wrote:
> >>> On 08.12.2010 13:36, Ian Kent wrote: 
> >>>> The default should be determined by mount.nfs(8) since that's what
> >>>> autofs uses to perform mounts.
> >>> I see, but it works only if the nfs4 root export is the same as /. It
> >>> does not work otherwise. Example:
> >>> Server 'dorado' exporting directory /exports which is also fsid=0 for
> >>> nfs4.
> >>> There is (also shared) subdirectory 'ext1' in this one. When I do:
> >>>
> >>> cd /net/dorado/exports/ext1
> >>>
> >>> ... the export is mounted using NFSv3. Theoretically if I did:
> >>>
> >>> cd /net/dorado/ext1
> >>>
> >>> ... I should have the same mounted via NFSv4, right? Unfortunately it
> >>> does not work. But it should because:
> >>>
> >>> mount dorado:/ext1 /mnt
> >>>
> >>> works (giving nfs4 mount)....
> >> The only information the hosts map has to go on is the export list
> >> received from the server.
> >>
> >> There is no way for autofs to know that /exports is the global root from
> >> the mountd exports information. It only knows that /exports is an export
> >> and neither does it know what NFS version the server may offer for this
> >> mount. That information just isn't available.
> >>
> >> As I said, I thought in recent Fedora releases (not sure now when this
> >> should have happened), that
> >>
> >> mount <server>:/exports /<some mount point>
> >>
> >> and 
> >>
> >> mount <server>:/ /<some mount point>
> >>
> >> should both work and mount as NFSv4. Correct me if I'm wrong but your
> >> point is that it is mounting as NFSv3 so perhaps we should log a bug and
> >> see what the experts have to say on this.
> >>
> >> Ian
> >>
> >>
> > Hi Ian,
> > 
> > I understand that autofs can not know that /exports is a global root. I just thought that mine:
> > 
> > cd /net/dorado/ext1
> > 
> > ... (i.e. omitting the "exports" word) should work as this way should autofs pass something like this : "mount.nfs dorado:/ext1 /net/dorado/ext1" which would succeed then, resulting in a nfs4 mount. What happens now is (obviously) that autofs can not find 'ext1' in the exports information from 'dorado' and so it fails even without trying....
> It depends on your server... If your server does not support v4, the
> mount will roll back to v3. An rpcinfo -p <server> will show if 
> the server support v4.

Knowing that the server supports NFSv4 doesn't tell me which export is a
global root though (does it?).

I guess I could code the rpcinfo calls and rewrite the mount code to
retry if v4 is supported. Not sure I like that idea though.

My problem is knowing for sure what the global root is and then I also
don't know what mount.nfs(8) will do with it. If I did have some way of
knowing what the global root was then trying to accommodate it will
cause mounts that fall back to v3 to fail.

I thought that the recent NFS server changes were meant to allow both
the mount paths above to function, like I think they do on other OSes
(I'll check on that if you really want me to)?

Ian
