From: Ian Kent <raven@themaw.net>
Subject: Re: Low priority question: negative cache in autofs5
Date: Fri, 05 Dec 2008 22:10:04 +0900
Message-ID: <1228482604.14030.15.camel@zeus.themaw.net>
References: <493910C7.9010308@s3group.cz>
	<1228477716.3033.37.camel@zeus.themaw.net>
	<49391C76.8030704@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49391C76.8030704@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Fri, 2008-12-05 at 13:20 +0100, Ondrej Valousek wrote:
> Hi Ian,
> 
> Thanks for the quick reply. And what is the answer to the first question
> please (regarding lstat & wildcard entry)? :-)

The negative cache working properly will return a fail immediately so
you shouldn't see this.

But then it shouldn't happen for the first case either.
There are quite a few changes scheduled for the next update and I
haven't seen this for a while now so it's a bit hard to get exited about
it.

> It is not he same case I guess....
> Many thanks,
> 
> Ondrej
> 
> Ian Kent wrote:
> > On Fri, 2008-12-05 at 12:30 +0100, Ondrej Valousek wrote:
> >   
> >> Probably to Ian:
> >> I am just looking in the autofs5 (from RHEL5) source. I have an indirect
> >> nis map:
> >> auto.master:
> >> /appli auto.appli
> >> /proj auto.proj
> >>
> >> Now, auto.proj contains a wildcard entry (* nfsserver:/share/&) but
> >> auto.appli does not.
> >>
> >> 1. Every time I try to enter (shortly after each other)
> >> /proj/nonexistent_directory, I got this:
> >> Dec  5 12:10:45 ara automount[3101]: rmdir_path: lstat of
> >> /proj/nonexistent_directory failed
> >> ... why did not the negative cache save us the expensive call to lstat?
> >>
> >>
> >> 2. Every time I try to enter (shortly after each other)
> >> /appli/nonexistent_directory, I got this:
> >> Dec  5 12:11:41 ara automount[3101]: lookup_mount: lookup(yp): key
> >> "nonexistent" not found in map
> >> ... again, looks like the nis daemon was consulted but the negative
> >> cache should take the place.
> >>     
> >
> > Known bug with v5 handling of negative caching of non-existent keys.
> > I'm working on it but it is proving a little bit tricky because of
> > possible multiple map sources listed in nsswitch.conf (at least that's
> > where I'm currently at).
> >
> >   
> >> Maybe I do not understand the concept of negative caching well....
> >>     
> >
> > No .. you got it right .. I missed it.
> >
> > Another thing, there are quite a few changes going into RHEL-5.3 autofs
> > which will make their way into RHEL-4.8 in due course. Hopefully you
> > will not get caught by them but it is worth logging calls for issues in
> > case you are seeing a known issue.
> >
> > Ian
> >
> >   
> 
