From: Ian Kent <raven@themaw.net>
Subject: Re: Query automount maps
Date: Thu, 17 Jan 2008 11:14:49 +0900
Message-ID: <1200536089.3084.23.camel@raven.themaw.net>
References: <BAC1D28A5AB852439A6914CA7AB4E63F051929F0@permls05.wde.woodside.com.au>
	<x49tzlex1ba.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49tzlex1ba.fsf@segfault.boston.devel.redhat.com>
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
To: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Cc: autofs@linux.kernel.org


On Tue, 2008-01-15 at 15:48 -0500, Jeff Moyer wrote:
> "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au> writes:
> 
> > Hi Ian and all
> >
> > Is there a way I can ask the automount process running on a client what
> > maps it has?  I'd like to be able to say "tell me all the maps you know
> > about" or "tell me the server:/path/to/somewhere for
> > /nfs/server/some/path".  Does this make sense?
> [...]
> > I'm really just after a way of checking that autofs map changes are
> > picked up by the clients.
> 
> It doesn't actually make sense, and here's why: the automounter won't
> recognize the update until a mount is triggered.  As such, you can
> just trigger a mount and compare what gets mounted with what you
> expect.  Is there some reason that this won't work for you?

It's a little different for version 5.

It happens that way for indirect mounts but direct mounts need to be
handled differently. They always use the current cache entry and are
updated when a HUP signal is sent to the daemon. It would be better if
we did a lookup to check currency at mount request time but I haven't
done that as yet. This is because there isn't always a one-one
correspondence between the mount request and what's been stored in the
internal cache so it's not straight forward.

It does need a bit more work.

It's easy enough to to find out what map is associated with an automount
by looking in /etc/mtab on Solaris and /proc/mounts on Linux. The map is
the first field. But we don't have a way, at the moment, to ask autofs
to report what is in the internal cache for a given automount point. We
are planning to improve the status reporting using a similar method to
what we have used to implement the dynamic log level changes but this
will be a while and I'm not sure this is actually practical. For
example, if someone asked for an indirect mount with 10,000 entries what
would we report? Maybe just the map associated with the mount point
rather than the contents of the map. Anyway, we haven't really thought
about this yet because we are still finding other bugs and it is very
much an enhancement.

Ian
