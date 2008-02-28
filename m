From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/4] autofs4 - track uid and gid of last mount requestor
Date: Wed, 27 Feb 2008 23:59:52 -0800
Message-ID: <20080227235952.70a31d9f.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0802261151400.8490@raven.themaw.net>
	<Pine.LNX.4.64.0802261208400.8490@raven.themaw.net>
	<20080227204546.72e16e8d.akpm@linux-foundation.org>
	<1204179747.3501.21.camel@raven.themaw.net>
	<20080227223734.caab0165.akpm@linux-foundation.org>
	<1204182500.3501.49.camel@raven.themaw.net>
	<47C667EC.6060700@openvz.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <47C667EC.6060700@openvz.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Pavel Emelyanov <xemul@openvz.org>
Cc: Ian Kent <raven@themaw.net>, Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Thu, 28 Feb 2008 10:51:08 +0300 Pavel Emelyanov <xemul@openvz.org> wrote:

> > So, why do we need the uid and gid? When someone walks over an autofs
> > dentry that is meant to cause a mount we send a request packet to the
> > daemon via a pipe which includes the process uid and gid, and as part of
> > the lookup we set macros for several mount map substitution variables,
> > derived from the uid and gid of the process requesting the mount and
> > they can be used within autofs maps.
> 
> Why do we need the uid then? Is just pid not enough to uniquely 
> identify a task?

The problem is that the userspace daemon is restarted.  ie: it exits
and is re-run.  It then needs to pick up various state from its previous
run.
