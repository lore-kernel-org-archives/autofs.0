From: raven@themaw.net
Subject: Re: [PATCH] replicated mounts fix, also possible bug in
	beta2?
Date: Sun, 3 Apr 2005 00:53:52 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504030041050.9613@donald.themaw.net>
References: <1112442929.5055.18.camel@tleilax.poochiereds.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1112442929.5055.18.camel@tleilax.poochiereds.net>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org

On Sat, 2 Apr 2005, Jeff Layton wrote:

> I've been working on a patch for the userspace portion of autofs to
> change the way that replicated mounts are handled. This patch changes
> mount_nfs.c such that it parses all of the mounts in the list, sorts
> them, and then tries to mount each in turn. The existing code breaks
> (fails to mount) if it picks a mount in the list that the client does
> not have permission to mount. I originally worked up the patch for a
> version of the autofs daemon in RHEL, but I'd like to have it considered
> for inclusion upstream as well.

Yes. That part of the code is a bit broken.
I've been working on it and I hope beta3 will work better.

One of the things that the replcated server code is meant to do is avoid 
trying to mount to servers that aren't responding. How does your 
implementation handle this?

One of the things that needs to be done here as well is to implement a 
proximity metric. Like order of precedence of localhost, local subnet and 
rest of world. How do you sort your list of hosts?

>
> The problem I've hit is that the latest version (autofs-4.1.4_beta2)
> seems to break replicated mounts. The newest version no longer seems to
> pass the entire mount string to mount_mount() in mount_nfs.c -- it only
> seems to pass the first mount in a (whitespace separated) list. This is
> a show-stopper for my patch, but also seems to break replicated mounts
> in the existing code as well (unless I'm missing something).

That can't be right.
get_best_mount is called in mount_mount with the mount entry string to 
check ping times etc.

>
> In any case, the current revision of my mount_nfs.c is at:
>
> http://poochiereds.net/svn/autofs/autofs-4.1.4_beta2/modules/mount_nfs.c

I can'r seem to view this.
Patches are really the only way to do this.

>
> I can generate diffs if you like, but the patch is pretty large (an
> overhaul, really), so it's probably easier to look at the file itself.
>
> I believe it retains all of the current functionality of mount_nfs.c,
> but I can't really test on the latest rev it until I work out the
> problem above. I got the basic code working on the RHEL-patched version
> of autofs, so it's pretty close.

One of the biggest problems is ensuring existing functionality is 
retained. It's really hard work.

Ian
