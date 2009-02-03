From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS Race Conditions?  Negative Cache?
Date: Tue, 03 Feb 2009 15:28:45 +0900
Message-ID: <1233642525.2951.42.camel@zeus.themaw.net>
References: <F76FAA9B4E7600AAC1FFA15B@ZOP-MACTEL.local>
	<1233113406.3005.21.camel@zeus.themaw.net>
	<E53DDD7AD6715F60A879D415@ZOP-MACTEL.local>
	<1233621955.2951.18.camel@zeus.themaw.net>
	<587B15FCE26A5069952E314B@ZOP-MACTEL.local>
	<1233632076.2951.32.camel@zeus.themaw.net>
	<36B93B4496845E1C4544EFD9@ZOP-MACTEL.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <36B93B4496845E1C4544EFD9@ZOP-MACTEL.local>
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
To: Michael Loftis <mloftis@wgops.com>
Cc: autofs@linux.kernel.org

On Mon, 2009-02-02 at 20:55 -0700, Michael Loftis wrote:
> 
> --On February 3, 2009 12:34:36 PM +0900 Ian Kent <raven@themaw.net> wrote:
> 
> 
> > Using "-n" is likely a problem for autofs prior to 5.0.4 but would also
> > require the 2.6.28 kernel module patch update for the kernel you are
> > using and you need to tell autofs to use the newly introduced ioctl
> > interface otherwise it will still scan mtab from time to time, expecting
> > it to be up to date.
> >
> > But, once the above is in place it should be possible to use a "-n" on
> > the mount commands without affecting autofs function. Not sure the best
> > way to provide that though.
> 
> hmmm food for thought anyway.  I'm always leery of moving forward to newer 
> linux kernels, not much of a problem in Debian since they pick a version 
> and keep with it throughout a release.  I may or may not have time to 
> dedicated to work with the patch you provided for autofs5 immediately, 
> right now our push is to just get this deployed.  I didn't realize the 
> automounter scanned mtab though, so that's good to know.

The main problem arises because we need to check if something is mounted
a lot and /proc/mounts can be much larger than the mtab. The kernel
update I mention above was needed for another reason but an operation to
check mounted-ness was added at the same time to eliminate the need to
look at the mtab. You might not need to go to a new kernel but I've only
ported this particular patch as far back at 2.6.22 at this stage. I need
to do a port back to 2.6.18 at some point soon so maybe that will cover
most of the work needed for the in-between version as well. Anyway, it
is still a big change so it really is your call as to whether it is
worth the effort from yourselves, but this is the story, to the best of
my knowledge anyway.

Ian
