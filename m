From: Ian Kent <raven@themaw.net>
Subject: Re: Background mount vs. changing ping timeout
Date: Tue, 20 Nov 2007 10:17:10 +0900
Message-ID: <1195521430.3079.18.camel@raven.themaw.net>
References: <1195507365.28065.13.camel@honslw16.conocophillips.net>
	<x494pfhoqcy.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x494pfhoqcy.fsf@segfault.boston.devel.redhat.com>
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

On Mon, 2007-11-19 at 16:52 -0500, Jeff Moyer wrote:
> "Norman R. Weathers" <norman.r.weathers@conocophillips.com> writes:
> 
> > Hello,
> >
> > We are currently using an older Fedora (Core 3) and are needing to
> > update to a later Fedora (Core 4 minimum).  During testing, we noticed
> > that the autofs utils for FC4 had a race condition, so we upgraded the
> > kernel (2.6.17) and autofs utilities (autofs-5.0-rc3 RPM).  I have
> > noticed through observation and perusing the list that bg is no longer
> > honored as a passed mount option for NFS through autofs.  A problem that
> > has caused us is that if server is down or under heavy load, it won't
> > respond to the rpc_ping in time, and so the automounter drops the
> > attempt to mount.  This causes a cascade effect in our cluster, ie.,
> > jobs that would have help up due to a backgrounded mount now fall
> > through, and it is possible to have "thousands" of jobs fall through our
> > batch scheduler all because the first set of jobs failed due to a long
> > mount or a server down temporarily.  Is there some way to increase the
> > rpc_ping?  Is there some way to trick bg to be passed through and short
> > circuit the rpc_ping?  We are not going to be doing sub-mounts or
> > multi-homed mounts.
> >
> > Any help would be greatly appreciated.
> 
> Your version of automount is still old.  Please grab the latest
> src.rpm from f8, or grab the latest from Ian's git repo.

Actually, that would need to be the git repo or the base tarball and
patches on kernel.org.

> 
> When you do that, you'll find that the rpc_ping code will not be
> executed unless an entry is a replicated server entry.  If you still
> timeout on the mounts, you can experiment with the "retry" nfs mount
> option.

This was merged only recently and so it didn't make it into F-8.
I can add it to F-8 if that will help.

Presumably, in this case the mount will hang waiting for the server and
with configure options used in the F-8 build other mounts should still
be possible without the "bg" option.

Ian
