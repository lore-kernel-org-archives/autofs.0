From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
Subject: RE: Exporting UID to userspace?
Date: Thu, 10 Jun 2004 20:14:25 +0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B3841AD@frodo.avalon.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

> -----Original Message-----
> From: Mike Waychison [mailto:Michael.Waychison@Sun.COM] 

>>>>>If the idea is to have a 'Network Neighborhood' inside
> >>each user's
> >>>>>homedir, you could write an executable map for /home
> >>>>
> >>>>It will hide /home directory content.
> >>>
> >>>No. It wouldn't presuming that your /home subdirs are automounted.
> >
> >
> > What if my home dirs is not automounted from network server? I just 
> > simply want it for local users.
> >
> 
> Well, in that case you'd have to use direct mounts (which 
> don't work as expected in automount4).  Alternatively, you can always
> 
> mkdir /export
> mv /home /export
> 
> And start automounting your home directories from localhost.   Don't
> worry, automount will detect it being local and will not use 
> NFS, rather it will --bind mount the filesystems, so there is 
> no performance hit.
;) Yes, I thought about it, but it's rather ugly solution (as for me),
then it's seems better to spawn new automount process for
~user/NetworkNeigboorhood at logon time and terminate it at logoff.
This allows us to avoid UID/GID exporting problem at all, since it will
be obvious which user's credetials to use for mount.

Any objections?

Dimitry.
