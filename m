From: Jeffrey Layton <jtlayton@poochiereds.net>
Subject: RE: replicated mounts patch
Date: Wed, 20 Apr 2005 13:09:16 -0400
Message-ID: <1114016956.9683.54.camel@barsoom.rdu.redhat.com>
References: <482A3FA0050D21419C269D13989C611307CF4C79@lavender-fe.eng.netapp.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <482A3FA0050D21419C269D13989C611307CF4C79@lavender-fe.eng.netapp.com>
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
To: "Lever, Charles" <Charles.Lever@netapp.com>
Cc: autofs@linux.kernel.org, raven@themaw.net

On Wed, 2005-04-20 at 09:57 -0700, Lever, Charles wrote:
> ok, i've reviewed the code in the kernel that generates the contents of
> /proc/mounts.  this will always show at least the transport protocol and
> the NFS version.  /etc/mtab (and thus the mount command) does not
> guarantee this; if a mount is done with defaults (ie the options aren't
> specified), the options in effect will not show up in /etc/mtab.
> 
> /proc/mounts is modulated by the namespace of the process that is
> reading it.  if the automounter process can see all system mounts,
> you're golden, but any namespace-related access control will affect the
> ability for an automounter to read the mount options you're interested
> in from /proc/mounts.
> 
> the kernel (post 2.6.12) can do under-the-cover mounts.  thus entries
> may be added to or removed from /proc/mounts over time, and there may be
> an interesting challenge to find the right entry given this churn.

But this info will only show existing mounts. If there are no NFS mounts
when the automounter is started, then /proc/mounts won't tell us
anything useful. 

What we really need is some what to know what the default NFS
transport/version is for the kernel we're running on. We also probably
need to get at this info without relying on doing an actual mount first.

-- Jeff
