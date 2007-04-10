From: Ian Kent <raven@themaw.net>
Subject: Re: How exactly does timeout work?
Date: Tue, 10 Apr 2007 11:58:11 +0800
Message-ID: <1176177492.3476.44.camel@raven.themaw.net>
References: <1176133554.30046.175.camel@psmithub>
	<x49wt0ly17p.fsf@segfault.boston.devel.redhat.com>
	<x49slb9xzu6.fsf@segfault.boston.devel.redhat.com>
	<1176137315.30046.185.camel@psmithub>
	<x49odlxxz70.fsf@segfault.boston.devel.redhat.com>
	<1176138870.30046.203.camel@psmithub>
	<x49k5wlxy4i.fsf@segfault.boston.devel.redhat.com>
	<1176140195.30046.225.camel@psmithub>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1176140195.30046.225.camel@psmithub>
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
To: psmith@netezza.com
Cc: autofs@linux.kernel.org

On Mon, 2007-04-09 at 13:36 -0400, Paul Smith wrote:
> On Mon, 2007-04-09 at 13:21 -0400, Jeff Moyer wrote:
> > I'm not sure that the internals are really worth discussing in the man
> > page
> 
> I agree with you to some extent, and I don't think the underlying method
> (using an ioctl, etc.) should be documented there, but I think the
> details of this algorithm can make a difference to how you decide set
> the timeout value, especially for larger timeouts.  It's not even really
> clear (from my reading of the man page) that the timeout is "time from
> the last access of the filesystem", as opposed to "how often we check to
> see if anyone is using it".  At the least it seems like that should be
> made clear, even if the other details (how often the daemon checks for
> example) are not spelled out.  Maybe the text:
> 
> -t, --timeout
>         Set the minimum timeout, in seconds, until directories are
>         unmounted.  The default is 5 minutes.  Setting the timeout to
>         zero disables unmounts completely.
> 
> could be rewritten as:
> 
> -t, --timeout
>         Set the minimum timeout, in seconds, from the last access of the
>         directory until it is unmounted.  The default is 5 minutes.
>         Setting the timeout to zero disables unmounts completely.
> 
> An extra sentence could also be added: "Access times are checked
> periodically, so the actual timeout will be greater than this value.
> The longer the timeout, the less frequently the access times are
> checked." or something.
> 
> > We'll see what Ian thinks.

The wording may need to be a bit different.

Problem is the definition of "busy" which changed in the kernel module
during the version 5 development.

To avoid confusion let me say first that the "autofs4" kernel module
supports "autofs" protocols 3, 4 and 5. So the module name and package
versions can be a source of confusion. The protocol version essentially
determines the information contained in the packet used to communicate
between the module and userspace and not the way in which the expiration
is calculated.

The inode access times aren't (and never were) used to determine
timeout. So the words "Access times" might end up being be misleading.

An expire check is done 4 times a per timeout interval as Jeff pointed
out. There a is small displacement (a proportion of timeout interval)
added to the initial check to try to prevent mounts all being checked at
the same time which can cause expire umounts to happen a little after
the timeout.

For the check itself the kernel module updates a last_used variable for
each mount.

Prior to version 5 update this was updated for any access. So "busy"
could be loosely defined as "any access".

Following the version 5 update it is only updated if the mount is really
busy. This means only if at least one process working directory or any
open file is within the filesystem at the time of an expire check. So
the umount will be triggered timeout seconds after the last working
directory is changed to somewhere outside the filesystem and any open
files have been closed.

I don't want to go into the details of why this was done other than to
say it was required for the direct mount implementation and was done
across the board for consistency and simplicity in the kernel module.

The version 5 update has been in kernel for quite a while now and
doesn't seem to has caused problems.

So I'm not sure what wording should be used in the man page and maybe
it's not such a big deal but there is a difference between kernel
versions.

Sorry for the rant and I hope I haven't completely confused the issue.

Ian
