From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 01/18] Add a dentry op to handle automounting rather than
 abusing follow_link()
Date: Fri, 14 Jan 2011 16:24:03 +0000
Message-ID: <20110114162403.GF19804@ZenIV.linux.org.uk>
References: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
 <20110111174815.2291.41967.stgit@warthog.procyon.org.uk>
 <AANLkTi=F6PSgQs78MpmG_V3q_ksmYMUwU8=xBoNOypto@mail.gmail.com>
 <AANLkTi=YygMc2ExFxvWqiFbSr-bWRVcn17toanJBdR08@mail.gmail.com>
 <16508.1294931527@redhat.com>
 <AANLkTi=ZiOZ08WEkTt8nVWkaeSG9mnM0JQ-ov=kO2mpc@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=ZiOZ08WEkTt8nVWkaeSG9mnM0JQ-ov=kO2mpc@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>, npiggin@kernel.dk, raven@themaw.net, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Fri, Jan 14, 2011 at 12:19:43PM +1100, Nick Piggin wrote:

> Also, I don't like how you return a vfsmount * and use that in path walking. If
> you just returned success and allowed the path walk to continue looking up
> mounted directories, it would be cleaner code, IMO.

No.  Filesystem has no business touching mount tree; leave that to core VFS.
Analysis of what's going on is messy enough as it is, let's *NOT* complicate
it even further.

I think we should take do_add_mount() calls into follow_automount(), making
the API
	NULL => nothing to do here, just follow mount
	ERR_PTR() => sod off
	mnt => here's the thing I want mounted, do it and go there.  If
something's allready got mounted here, just disregard this one and follow
mount as usual (== we'd lost the race)
