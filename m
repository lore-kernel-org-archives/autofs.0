From: Ian Kent <raven@themaw.net>
Subject: Re: Regular deadlocks
Date: Fri, 01 Jul 2016 15:03:04 +0800
Message-ID: <1467356584.3908.40.camel@themaw.net>
References: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
	 <1466906389.739.25.camel@themaw.net>
	 <c4d585e4-fae9-829f-b7ad-74724af5c2f9@excellency.fr>
	 <1466987208.3191.6.camel@themaw.net>
	 <17c66f92-bda8-1eb9-621c-47e39406acc2@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=gAMItgtSJWpk7Ui01j2zU72OGGc=; b=O9ZRuT
	GOkk2uuZNm5ongNBBe2UNzEKaKPonlZFZ5l1NRxWeCxFVAShlcA001e2hnfaCscf
	ouMZd06WX8z5qQPwJHiGJSS/KXgLyik2l0J2YZMZREZDKwDrpaizK55uR+nxSnv5
	5INC1DYOSSxSg3lxpJZAy+UxB1kJ0bDW5G5tc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=gAMItgtSJWpk7Ui
	01j2zU72OGGc=; b=eqO0w/yfyDYIViWYaDKpdV/Sh1+mukklspxAs4flASE17B1
	376Jp6kDPwOUKZM4jem2aeyxVhqM+z36tp2C62Mf65eVBEY8oVA/mW1qoNZ2bUC6
	3Pydgn1Li7Bgvn8HNKMvpUHDTDe5GP4EZovvcjKBexDvcEg/mJVUvCm3pP/8=
In-Reply-To: <17c66f92-bda8-1eb9-621c-47e39406acc2@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Cyril B." <cbay@excellency.fr>, autofs@vger.kernel.org

On Mon, 2016-06-27 at 16:04 +0200, Cyril B. wrote:
> On 06/27/2016 02:26 AM, Ian Kent wrote:
> > How is autofs configured.
> > 
> > If --disable-mount-locking is not used then any mount can block all other
> > mounts, if it is used then there can be mtab corruption if still using a
> > text
> > based mtab.
> 
> I use --disable-mount-locking.
> 
> > I always use --disable-mount-locking and nowadays the mtab is usually a
> > symlink
> > into the proc file system so corruption isn't a problem.
> 
> /etc/mtab is actually not a symlink on my systems.
> 
> 
> Anyway, I have more details for you as the issue appeared today and I 
> could investigate some more. This is on a server that only mounts one 
> single NFS server (http12), so the multi-servers blocking issue is 
> irrelevant here.
> 
> A few minutes before the "deadlock" occurred, /nfs/http12 was unmounted 
> by autofs, I assume because it was idle. I have TIMEOUT=600. That 
> explains why the issue appears much more frequently on a server which is 
> way less busy (and usually in the middle of the night): the NFS server 
> needs to be idle enough to be unmounted.

That does seem to be causing a problem.

The mount request for /nfs/http12 doesn't seem to be able to make progress but
that could be due to what looks like a signal handling problem, not sure.

There are a bunch of processes blocked on poll(2), waiting for input from a pipe
that probably belongs to a process that has died (quite a few of them).

You would think that poll(2) whould get a SIGCHLD signal when the child process
terminates but, unfortunately, that can't be relied upon in a threaded
application.

Only a single thread of those that don't have SIGCHLD blocked will receive the
signal, and that might not be the thread that fork(2)ed the child, and if there
are multiple signals sent at the same time the number of signals delivered might
not match the number of processes that sent the signal.

So I think the first thing to try will be to change the logic around the poll(2)
call in the timed_wait() function to be non-blocking and check for child process
existence before waiting on poll(2) again.

That's probably not going to help with whatever has caused a problem with
mount(8) (or probably mount.nfs(8)) but it will provide the opportunity to put
some logging in to try and get more information on it. Not only that you will th
en likely get a bunch of mount failures for mounts that shouldn't have failed.

The really annoying thing is that there is no output al all from any of the
child process that must have been forked.

Anyway, that's going to take a while.

> 
> However, I still had many /home/userX mounted (by autofs), which point 
> to /nfs/http12/userX. Shouldn't autofs not unmount /nfs/http12 when at 
> least one /home/userX is mounted? To be clear, here's an extract from my 
> /proc/mounts BEFORE the NFS server is unmounted by autofs:

That's another fairly difficult question.

First it's the kernel dentry corresponding to /nfs/http12 that holds the
last_used counter that determines if the dentry hasn't been used for the given
timeout. For that timeout to occur the dentry must not have been busy during
that time which means no open file handles, no working directories open within
it and no activity that would update the last_used value (not usually plain path
walks).

Then there's the question of bind mounting.

I think that when you bind mount the result is an independent mount but just how
that is handled when bind mounting a sub directory of a mount isn't clear. The
output of /proc/mounts (last time I looked at this case) makes it look like the
parent mount is used.

So it's not clear what's going on there.

If the parent mount is used for each bound mount then there would be multiple
independent mounts each able to be umounted independently. For a start that
implies the business of each of these mounts can't influence the busyness of
others and so neither the parent itself.

That sounds a bit strange I know but it would take a lot of time trawling the
VFS to really understand what is going on there.

We do however see that /nfs/http12 can be umounted so I think we can assume
something similar to what I describe is the way it is.

I don't know yet what that means for the scenario here, what I've suggested
above needs to be done first I think.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
