From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5 and /etc/mtab
Date: Thu, 06 Mar 2008 11:56:08 +0900
Message-ID: <1204772169.3218.20.camel@raven.themaw.net>
References: <n7xwsoh1cju.fsf@sor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <n7xwsoh1cju.fsf@sor.suse.de>
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
To: Matthias Koenig <mkoenig@suse.de>
Cc: autofs mailing list <autofs@linux.kernel.org>


On Wed, 2008-03-05 at 15:16 +0100, Matthias Koenig wrote:
> Hi,
> 
> as it is explicitly stated in the README.v5.release, autofs filesystem
> mounts do not show up in /etc/mtab, only in /proc/mounts.
> 
> Currently df from coreutils cannot detect the filetype of an autofs
> filesystem for this reason. I know that this could possibly be fixed by
> using information grom statfs(2), but there are people who refuse this
> change and want autofs filesystems to be visible in /etc/mtab
> (you might want to take a look at
> https://bugzilla.novell.com/show_bug.cgi?id=333296)
> 
> So, as the change is explicitly stated, I guess, the change has been
> done on purpose. Does someone know the reason?

There are a few reasons.

The foremost reason is because version 5 uses lots of mounts as
triggers, for direct mounts and for the lazy mount/expire of trees of
mounts (aka the multi-mounts and the hosts map). If they were added to
the mtab this would lead to considerable confusion. And if you've used a
system that does add these to the mtab (such as old versions of AIX) and
your map had, even just a few hundred direct mounts, you would
understand how annoying it is. I guess we could use a pseudo mount
option, like "hide", so the entries aren't displayed (but that doesn't
really help with the locking issues below).

There is also the issue of mtab locking, under heavy mount activity,
leading to mtab corruption, which we've seen often in the past. Not
using the mtab for autofs mounts themselves substantially reduces the
pressure on mtab locking.

Finally there's the issue of scanning the mtab which I need to do fairly
often when checking if something is mounted. A few hundred entries isn't
that bad but the number of entries can order in the thousands for quite
a few users which leads to performance problems and aggravates the
locking issues.

Ian
