From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Background mount vs. changing ping timeout
Date: Mon, 19 Nov 2007 16:52:13 -0500
Message-ID: <x494pfhoqcy.fsf@segfault.boston.devel.redhat.com>
References: <1195507365.28065.13.camel@honslw16.conocophillips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1195507365.28065.13.camel@honslw16.conocophillips.net> (Norman
	R. Weathers's message of "Mon\, 19 Nov 2007 15\:22\:45 -0600")
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
To: "Norman R. Weathers" <norman.r.weathers@conocophillips.com>
Cc: autofs@linux.kernel.org

"Norman R. Weathers" <norman.r.weathers@conocophillips.com> writes:

> Hello,
>
> We are currently using an older Fedora (Core 3) and are needing to
> update to a later Fedora (Core 4 minimum).  During testing, we noticed
> that the autofs utils for FC4 had a race condition, so we upgraded the
> kernel (2.6.17) and autofs utilities (autofs-5.0-rc3 RPM).  I have
> noticed through observation and perusing the list that bg is no longer
> honored as a passed mount option for NFS through autofs.  A problem that
> has caused us is that if server is down or under heavy load, it won't
> respond to the rpc_ping in time, and so the automounter drops the
> attempt to mount.  This causes a cascade effect in our cluster, ie.,
> jobs that would have help up due to a backgrounded mount now fall
> through, and it is possible to have "thousands" of jobs fall through our
> batch scheduler all because the first set of jobs failed due to a long
> mount or a server down temporarily.  Is there some way to increase the
> rpc_ping?  Is there some way to trick bg to be passed through and short
> circuit the rpc_ping?  We are not going to be doing sub-mounts or
> multi-homed mounts.
>
> Any help would be greatly appreciated.

Your version of automount is still old.  Please grab the latest
src.rpm from f8, or grab the latest from Ian's git repo.

When you do that, you'll find that the rpc_ping code will not be
executed unless an entry is a replicated server entry.  If you still
timeout on the mounts, you can experiment with the "retry" nfs mount
option.

Cheers,

Jeff
