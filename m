From: Ian Kent <raven@themaw.net>
Subject: Re: Background mount vs. changing ping timeout
Date: Wed, 21 Nov 2007 16:02:43 +0900
Message-ID: <1195628563.3076.12.camel@raven.themaw.net>
References: <1195507365.28065.13.camel@honslw16.conocophillips.net>
	<x494pfhoqcy.fsf@segfault.boston.devel.redhat.com>
	<1195521430.3079.18.camel@raven.themaw.net>
	<1195567323.25181.6.camel@honslw16.conocophillips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1195567323.25181.6.camel@honslw16.conocophillips.net>
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

On Tue, 2007-11-20 at 08:02 -0600, Norman R. Weathers wrote:
> 
> 
> On Tue, 2007-11-20 at 10:17 +0900, Ian Kent wrote:
> > On Mon, 2007-11-19 at 16:52 -0500, Jeff Moyer wrote:
> > > "Norman R. Weathers" <norman.r.weathers@conocophillips.com> writes:
> > > 
> > > > Hello,
> > > >
> > > > We are currently using an older Fedora (Core 3) and are needing to
> > > > update to a later Fedora (Core 4 minimum).  During testing, we noticed
> > > > that the autofs utils for FC4 had a race condition, so we upgraded the
> > > > kernel (2.6.17) and autofs utilities (autofs-5.0-rc3 RPM).  I have
> > > > noticed through observation and perusing the list that bg is no longer
> > > > honored as a passed mount option for NFS through autofs.  A problem that
> > > > has caused us is that if server is down or under heavy load, it won't
> > > > respond to the rpc_ping in time, and so the automounter drops the
> > > > attempt to mount.  This causes a cascade effect in our cluster, ie.,
> > > > jobs that would have help up due to a backgrounded mount now fall
> > > > through, and it is possible to have "thousands" of jobs fall through our
> > > > batch scheduler all because the first set of jobs failed due to a long
> > > > mount or a server down temporarily.  Is there some way to increase the
> > > > rpc_ping?  Is there some way to trick bg to be passed through and short
> > > > circuit the rpc_ping?  We are not going to be doing sub-mounts or
> > > > multi-homed mounts.
> > > >
> > > > Any help would be greatly appreciated.
> > > 
> > > Your version of automount is still old.  Please grab the latest
> > > src.rpm from f8, or grab the latest from Ian's git repo.
> > 
> > Actually, that would need to be the git repo or the base tarball and
> > patches on kernel.org.
> > 
> 
> git repo.  I knew I should have been working on this all this time
> instead of waiting for final tarballs... (grin).  I haven't used git
> yet, but there is no time like the present...
> 
> > > 
> > > When you do that, you'll find that the rpc_ping code will not be
> > > executed unless an entry is a replicated server entry.  If you still
> > > timeout on the mounts, you can experiment with the "retry" nfs mount
> > > option.
> > 
> > This was merged only recently and so it didn't make it into F-8.
> > I can add it to F-8 if that will help.
> > 
> > Presumably, in this case the mount will hang waiting for the server and
> > with configure options used in the F-8 build other mounts should still
> > be possible without the "bg" option.
> > 
> > Ian
> > 
> 
> Actually, that is exactly what we want.  There are times when
> applications blindly do an ls in a directory, and an automount storm
> happens ( we have ~ 100 mounts in this particular directory), and while
> not all mounts may be necessary to complete, it is deadly to the jobs in
> question if that one mount that they do need returns from the automount
> as dead instead of just passing on to mount and letting it keep trying
> instead (in a blocking/hanging state).  How much would it take to create
> a src rpm?  I am willing to try this, because our other option at this
> point in time is to use FC4 and shoe horn in the FC3 automounter because
> of a race condition with FC4's automounter that we seem to hit at every
> turn.

I spent a fair bit of yesterday bringing Fedora autofs up to date for
development and F8.

It's a bit hard to find the updates on the mirrors just yet but either
autofs-5.0.2-18 in the development tree or autofs-5.0.2-17 in the
updates/testing/8 tree will do as they are basically the same.

Build from the srpm and try it out.

Remember that you will need an recent kernel for this to work best.
Kernel 2.6.17 should work OK but really a 2.6.23 based kernel would have
all current corrections. Beware that there is at least one kernel
release that has problems, 2.6.22 I think, and should be avoided. Also
there are a few Fedora kernels with the problem and aren't necessarily
marked as a 2.6.22 revision.

Ian
