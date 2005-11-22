From: Ian Kent <raven@themaw.net>
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Wed, 23 Nov 2005 07:34:57 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511230728340.2069@donald.themaw.net>
References: <1132670358.4039.37.camel@brilong-lnx>
	<Pine.LNX.4.63.0511222329100.9982@donald.themaw.net>
	<17283.17854.189791.135878@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17283.17854.189791.135878@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Tue, 22 Nov 2005, Jeff Moyer wrote:

> ==> Regarding Re: [autofs] stat of /users/no-such-user takes 15 seconds; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Tue, 22 Nov 2005, Brian Long wrote:
> >> I have an auto.master deployed to thousands of hosts and it looks like
> >> this:
> >> 
> >> /misc /etc/auto.misc --timeout=60 /auto /etc/auto.indirect
> >> rsize=32768,wsize=32768,tcp /users auto_home
> >> rw,hard,intr,rsize=32768,wsize=32768,tcp
> >> 
> >> As you can see, /users comes from NIS auto.home map.  In our case,
> >> auto.home contains over 34,000 entries.  I've noticed in RHEL 3 U5 and
> >> beyond (autofs-4.1.3-130), trying to stat (ls) /users/no-such-user takes
> >> roughly 12-15 seconds.  In RHEL 3 U3 (autofs-4.1.3-12), it returns
> >> immediately.  This is a regression in my opinion.
> 
> raven> Bummer. I thought that update code was OK.
> 
> >> After looking at tcpdump data, it appears automounter is downloading the
> >> entire auto.home map when it fails to lookup "no-such-user".  This
> >> results in a > 700KB transfer from the NIS server :(
> 
> raven> This is exactly the sort of problem I was concerned about when
> raven> people asked for periodic reload of maps. I didn't do that and
> raven> clearly I was right.
> 
> raven> Having said that it possibly shouldn't be doing this either. I'll
> raven> have to check the lookup code to see what I'm doing.
> 
> raven> Probably I'm signaling a re-load because, since the entry is now
> raven> missing, the map may need to be updated.
> 
> raven> I hasten to point out there was quite a bit of demand for having "up
> raven> to date maps"! Having a HUP signal to force a re-load wasn't enough.
> 
> raven> Given your situation and the fact that we need to know about
> raven> changes, what do you think the semantics of handling map updates
> raven> should be?
> 
> raven> Seems to me there are only two options when an out of date map entry
> raven> is encountered. Update, remove or add the given entry and accept
> raven> there may be more you don't know about or re-read the whole map. Now
> raven> even the simple addition and removal is not simple as the lookup is
> raven> done in a subprocess so somehow the process leader needs to be told
> raven> what to get!
> 
> Ian, the point here is that the map key isn't out of date.  We don't detect
> that the entry didn't exist in the first place.  See my other post to this
> thread, where I've attached a patch.  Comments on that are, of course,
> encouraged.

Think I get it now.

Your point is that the case where the map lookup to the server fails to 
find the key and the entry doesn't exist in the local entry database is 
not handled, yes.

Ian
