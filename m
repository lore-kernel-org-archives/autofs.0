From: Ian Kent <raven@themaw.net>
Subject: Re: [Bug 53951] race condition on mounting local disks with autofs
Date: Thu, 06 Feb 2014 08:18:49 +0800
Message-ID: <1391645929.2608.17.camel@perseus.fritz.box>
References: <bug-53951-13602@https.bugzilla.kernel.org/>
	 <bug-53951-13602-54xc3ri31k@https.bugzilla.kernel.org/>
	 <20140205174917.GH11667@thunk.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=XszNZ99F2HOTG/GdkjhoAhdUJwI=; b=CBpDUk8PnrKcBlx3H7oYnOjBOS5s
	+knQdGpy3rBG/p7hlnXTtdK2LJ6FApyfi67JZnzOYhXdJqrwFPv+bBUEU2xWjk/K
	/UmkNuuxt6PwK3xnyfkEwq2p+JJYqORamgd5vD9vsRZ0ZmOiya+s/lvdMH6zYNlp
	4KT+W53aaU1Svi8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=XszNZ99F2HOTG/GdkjhoAh
	dUJwI=; b=tZNHiR+ETbZVE70TpuMJ71HS8vK1pdUapIXYgw8QHkcSCjB24JaYmx
	2hlZX4NoW7u3dk/uee3ZCdJ6mf7achPeTYqc6BCWCjXgZlG5cDHbGsat9P+VTWCT
	v1aIhTfUOFErmzzvYzNtRZAlXoiA9rB8lZ3DwSC+50aWVzQ1xGGvU=
In-Reply-To: <20140205174917.GH11667@thunk.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: harri@afaics.de
Cc: bugzilla-daemon@bugzilla.kernel.org, linux-ext4@vger.kernel.org, autofs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>

On Wed, 2014-02-05 at 12:49 -0500, Theodore Ts'o wrote:
> Original bug report, from https://bugzilla.kernel.org/show_bug.cgi?id=53951:
> 
> Harald Dunkel 2013-02-16 15:55:40 UTC
> 
> I am using autofs to mount a local disk to /misc/data6 on
> request. Problem: It seems that the first access silently fails, if
> the disk is not yet mounted.

Does it!

Or is it the mix of system calls that are made, some of which won't
trigger the mount and others that will. I know from experience that
find(1) does a fairly unusual mix of these calls.

Does it still happen if you append a "/" to /misc/data6.

Since there are a number of system calls that won't trigger mounts,
which is required to avoid mount storms, there needs to be some way to
selectively force mount triggering and appending a "/" to a path is the
way it's done (at least it should function that way).

Mind you the mix of calls won't matter if the automount is mounted
"nobrowse" since mount point directories that don't yet exist should
trigger a mount on any access.

The default installed autofs configuration sets this but if you wiped
out the configuration and didn't retain that setting then the automount
will be mounted "browse", the internal program default.

What are you using for that setting?

Ian

