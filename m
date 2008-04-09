From: Ian Kent <raven@themaw.net>
Subject: Re: error returned upon mount failure
Date: Wed, 09 Apr 2008 12:21:51 +0800
Message-ID: <1207714911.2992.15.camel@raven.themaw.net>
References: <Pine.GSO.4.55.0804081730320.21655@loogie.intranet.csupomona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.GSO.4.55.0804081730320.21655@loogie.intranet.csupomona.edu>
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
To: "Paul B. Henson" <henson@acm.org>
Cc: autofs@linux.kernel.org


On Tue, 2008-04-08 at 19:36 -0700, Paul B. Henson wrote:
> I was working with automount 5 on a fairly recent 2.6.23 kernel, and got
> the following error when trying to access an automounted directory:
> 
> gentoo ~ # ls /user/henson
> ls: cannot access /user/henson: No such file or directory

Right.

> 
> 
> The directory did exist, and the automounter configuration was correct,
> but the actual mount failed:
> 
> gentoo ~ # mount -t nfs4 -o sec=krb5i zfs1:/export/user/henson /mnt
> mount.nfs4: Permission denied

Understood.

> 
> 
> On a Solaris 10 system, attempting to access the same directory gave a more
> appropriate error message:
> 
> root@s10 ~ # ls /user/henson
> /user/henson: Permission denied
> 
> root@s10 ~ # mount -o vers=4 zfs1:/export/user/henson /mnt
> nfs mount: mount: /mnt: Permission denied

Yep.

> 
> 
> Would it be possible to have the Linux automounter give a more accurate
> error message for this case?

Not at the moment.
This has been a known limitation for a long time.

I'm working on re-implementing the control interface and, as you may
have seen on the list, am having a bit of difficulty.

While the new implementation will provide the ability for the daemon to
pass the actual fail status I will still need to update the code in the
daemon. That's not as easy as you'd expect either. Not being able to
pass back the status in the past has lead to it being a bit difficult to
get hold of when it's needed and then I need to be sure the return codes
from mount(8) reflect the errors. I really don't want to have to pull
in, and then have to maintain separately, all the mount code.

So, bottom line is, I'm aware of it and I'm working on it and it looks
like it will be a while, sorry.

Ian
