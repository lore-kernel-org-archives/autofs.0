From: Ian Kent <raven@themaw.net>
Subject: Re: automounter segfaults when using negative cache?
Date: Sat, 06 Dec 2008 02:12:02 +0900
Message-ID: <1228497122.14030.88.camel@zeus.themaw.net>
References: <4937BBBC.9030305@s3group.cz>
	<x497i6e6291.fsf@segfault.boston.devel.redhat.com>
	<1228494221.14030.82.camel@zeus.themaw.net>
	<x49tz9i4mey.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49tz9i4mey.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Fri, 2008-12-05 at 11:27 -0500, Jeff Moyer wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > On Fri, 2008-12-05 at 11:00 -0500, Jeff Moyer wrote:
> >> 
> >> The negative caching is done in userspace.  I'm not sure I understand
> >> your question.
> >
> > Me neither but I'm working on the negative caching of non-existent map
> > keys. Turns out to be a bit tricky when multiple nsswitch sources can be
> > tried for each mount since the map may not exist within a given source
> > and so we get NSS_STATUS_UNAVAIL instead of NSS_STATUS_NOTFOUND. Maybe I
> > should just cache the unavailable in the same way?
> 
> Ian, this is autofs version 4.  It's been a while since I implemented
> the negative caching there, but I'd be interested in knowing if you
> think I got it wrong for the case above!

Oh, yeah, lucky it will be Xmas holiday time soon.
I'm going to have a look around the v4 code tomorrow.
I'll spend some time on this as well.

> 
> Cheers,
> Jeff
