From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] Re: [ANNOUNCE] Important update - autofs 4.1.4 release
Date: Fri, 15 Apr 2005 09:25:50 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504150920450.30832@wombat.indigo.net.au>
References: <Pine.LNX.4.62.0504102120390.14539@donald.themaw.net>
 <Pine.LNX.4.62.0504112324510.6384@donald.themaw.net>
 <16989.52849.68024.30163@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0504141357180.7872@wombat.indigo.net.au>
 <Pine.LNX.4.58.0504141410190.8227@wombat.indigo.net.au>
 <16990.24002.650785.141049@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <16990.24002.650785.141049@segfault.boston.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

On Thu, 14 Apr 2005, Jeff Moyer wrote:

> ==> Regarding Re: [autofs] Re: [ANNOUNCE] Important update - autofs 4.1.4 release; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Thu, 14 Apr 2005, Ian Kent wrote:
> >> On Wed, 13 Apr 2005, Jeff Moyer wrote:
> >> 
> >> > 
> >> > This new version has regressed since beta2 for /net mounts in my 
> >> environment.  A simple ls of /net/<filer> will now show the contents of
> >> > /net/<filer>/exporteddir.  So, for example, we have devfiler which
> >> exports /vol/vol1.  When I do an ls of /net/devfiler, I get the
> >> contents of devfiler:/vol/vol1.
> >> > 
> >> > Okay, after further debugging, it seems we're not identifying this as
> >> a multimount entry.  It's getting late, so I'm going to turn this over
> >> to you.  I think that the checking of first_chunk is bogus.  For
> >> instance, with the below change, everything works as expected for me.
> >>
> >> 
> >> Cool, I'll check this out and get back.
> 
> raven> Could I have the example map entry that breaks the parse please.
> 
> Sheesh, you'd think that I could generate a bug report by now... I'll blame
> it on the late night thing.  =)
> 
> This is an auto.net entry.  Here's what auto.net spits out for this
> particular host:
> 
> -fstype=nfs,hard,intr,nodev,nosuid \
>         /vol/vol1 devfiler:/vol/vol1
> 
> I'm guessing you didn't test auto.net against a host that only exported one
> dir?  Just a guess.  Below are the debug logs.
> 

That's exactly right, I missed that edge case.
I did actually guess that and the above confirms it.

I know exaclty how I'd like to handle it but I haven't had time to generte 
a patch. I'll try to find time at work today but I've got heaps of "work" 
stuff to do. Of course it's Friday here so doing it tonight not looking to 
good either.

Oh well I'll get to it.

Ian

