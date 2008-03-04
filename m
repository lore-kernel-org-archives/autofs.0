From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 3/4] autofs4 - track uid and gid of last mount requestor
Date: Tue, 04 Mar 2008 15:16:34 -0700
Message-ID: <m1od9u2kzh.fsf@ebiederm.dsl.xmission.com>
References: <1204179747.3501.21.camel@raven.themaw.net>
	<20080227223734.caab0165.akpm@linux-foundation.org>
	<1204182500.3501.49.camel@raven.themaw.net>
	<20080227232339.af6e904a.akpm@linux-foundation.org>
	<1204185623.3501.84.camel@raven.themaw.net>
	<x494pbtxaup.fsf@segfault.boston.devel.redhat.com>
	<20080228195118.GA16634@sergelap.austin.ibm.com>
	<1204255932.3969.86.camel@raven.themaw.net>
	<20080229160921.GA24296@sergelap.ibm.com>
	<m1bq5y3p2o.fsf@ebiederm.dsl.xmission.com>
	<20080303152855.GB25643@sergelap.austin.ibm.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080303152855.GB25643@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Mon, 3 Mar 2008 09:28:55 -0600")
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Ian Kent <raven@themaw.net>, Jeff Moyer <jmoyer@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Pavel Emelyanov <xemul@openvz.org>

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Earlier I had thought this could just be done using a special keyring,
> but atm I'm thinking that would be far uglier than just having a
> struct pid-like credential proxy in the kernel to pass around in place
> of uids.

I have not looked at many of the implementation possibilities so unfortunately
I don't know what makes for a good implementation.

What I do know is that uids are serialized in filesystems, and their
mapping between namespaces is defined by system administrators.

Both of those properties are different from struct pid.  Which means
a generalized struct user in the kernel can at best hold a cache of the
mappings.

My preliminary investigations suggested that for the kernel filesystem
boundary generating a struct user or a struct group just to use for a
permission check and then to throw it away was wasteful.

However for inkernel entities a struct user sounds practical.

All of which is to say that we can learn lessons from the
implementation of struct pid but that we also have different
requirements so we can only use those lessons in a limited fashion.

Eric
