From: "Lever, Charles" <Charles.Lever@netapp.com>
Subject: RE: replicated mounts patch
Date: Wed, 20 Apr 2005 09:57:10 -0700
Message-ID: <482A3FA0050D21419C269D13989C611307CF4C79@lavender-fe.eng.netapp.com>
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Jeffrey Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org, raven@themaw.net

> On Wed, 2005-04-20 at 09:13 -0700, Lever, Charles wrote:
> > if the mount option default settings change (say it was 'udp' in 
> > earlier releases, and is now 'tcp') the meaning of a 
> missing option on 
> > the mount command line is different.
> > 
> > so looking at the mount options is a completely unreliable way to 
> > determine which transport protocol is in use...
> 
> True, but at least this makes some effort at it. The old code did a
> UDP/NFSv2 ping no matter what. This is still what happens in 
> the absence of these mount options.
> 
> Is there some way to pull this info out of the mount program 
> or the kernel so we could determine the appropriate default 
> at runtime? That would be the best way to do it.

ok, i've reviewed the code in the kernel that generates the contents of
/proc/mounts.  this will always show at least the transport protocol and
the NFS version.  /etc/mtab (and thus the mount command) does not
guarantee this; if a mount is done with defaults (ie the options aren't
specified), the options in effect will not show up in /etc/mtab.

/proc/mounts is modulated by the namespace of the process that is
reading it.  if the automounter process can see all system mounts,
you're golden, but any namespace-related access control will affect the
ability for an automounter to read the mount options you're interested
in from /proc/mounts.

the kernel (post 2.6.12) can do under-the-cover mounts.  thus entries
may be added to or removed from /proc/mounts over time, and there may be
an interesting challenge to find the right entry given this churn.
