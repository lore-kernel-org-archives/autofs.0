From: Ian Kent <raven@themaw.net>
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Tue, 22 Nov 2005 23:50:29 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511222329100.9982@donald.themaw.net>
References: <1132670358.4039.37.camel@brilong-lnx>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1132670358.4039.37.camel@brilong-lnx>
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
To: Brian Long <brilong@cisco.com>
Cc: autofs@linux.kernel.org

On Tue, 22 Nov 2005, Brian Long wrote:

> I have an auto.master deployed to thousands of hosts and it looks like
> this:
> 
> /misc   /etc/auto.misc          --timeout=60
> /auto   /etc/auto.indirect      rsize=32768,wsize=32768,tcp
> /users  auto_home               rw,hard,intr,rsize=32768,wsize=32768,tcp
> 
> As you can see, /users comes from NIS auto.home map.  In our case,
> auto.home contains over 34,000 entries.  I've noticed in RHEL 3 U5 and
> beyond (autofs-4.1.3-130), trying to stat (ls) /users/no-such-user takes
> roughly 12-15 seconds.  In RHEL 3 U3 (autofs-4.1.3-12), it returns
> immediately.  This is a regression in my opinion.

Bummer. I thought that update code was OK.

> 
> After looking at tcpdump data, it appears automounter is downloading the
> entire auto.home map when it fails to lookup "no-such-user".  This
> results in a > 700KB transfer from the NIS server  :(

This is exactly the sort of problem I was concerned about when people 
asked for periodic reload of maps. I didn't do that and clearly I was 
right.

Having said that it possibly shouldn't be doing this either. I'll have to 
check the lookup code to see what I'm doing.

Probably I'm signaling a re-load because, since the entry is now missing, 
the map may need to be updated.

I hasten to point out there was quite a bit of demand for having "up to 
date maps"! Having a HUP signal to force a re-load wasn't enough.

Given your situation and the fact that we need to know about changes, what 
do you think the semantics of handling map updates should be?

Seems to me there are only two options when an out of date map entry is 
encountered. Update, remove or add the given entry and accept there may be 
more you don't know about or re-read the whole map. Now even the simple 
addition and removal is not simple as the lookup is done in a subprocess 
so somehow the process leader needs to be told what to get!

Did someone ask what would be the advantages of turning autofs into a 
threaded app?

> 
> In the older autofs version, it does NOT do this.  I have opened a Red
> Hat issue tracker (82760), but in parallel I wanted to ask this list if
> this is known behavior and if there is any way I can disable the
> download of the entire auto.home map using /etc/sysconfig/autofs or
> auto.master options to the automount program.

I'm sure that the folks at RedHat will help us with this.

There's nothing atm but perhaps an environment variable to tell autofs 
whether to be lazy about updates. If I can just come up with a simple way 
to tell the process leader what it needs to do and, if only a record 
update, the key???

I'll think about it.

Ian
