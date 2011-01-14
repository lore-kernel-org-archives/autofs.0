From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 01/18] Add a dentry op to handle automounting rather than abusing follow_link()
Date: Fri, 14 Jan 2011 09:24:47 +0000
Message-ID: <32127.1294997087@redhat.com>
References: <AANLkTimcjg-JaVr1w=sCNQHTWFxquPvpL=YJZNGTN3cY@mail.gmail.com> <20110111174809.2291.52242.stgit@warthog.procyon.org.uk> <20110111174815.2291.41967.stgit@warthog.procyon.org.uk> <AANLkTi=F6PSgQs78MpmG_V3q_ksmYMUwU8=xBoNOypto@mail.gmail.com> <14657.1294921241@redhat.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <AANLkTimcjg-JaVr1w=sCNQHTWFxquPvpL=YJZNGTN3cY@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Piggin <npiggin@gmail.com>
Cc: dhowells@redhat.com, npiggin@kernel.dk, viro@zeniv.linux.org.uk, raven@themaw.net, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Nick Piggin <npiggin@gmail.com> wrote:

> You still have to notice that it is .d_automount in rcu-walk mode, and bail
> out if it is. I can't see where you do that.

follow_managed(), and thus follow_automount() and ->d_automount(), are never
reached in rcu_walk mode, from what I can tell of the code.

There are two places follow_managed() is called:

 (1) do_lookup() - where follow_managed() is only called in the else-part of
     an if-statement contingent on a check of LOOKUP_RCU.

 (2) do_last() - where follow_managed() is subsequent to a mutex having been
     taken, so rcu-walk mode must have been exited prior to this as the
     process may have needed to sleep.

At least, I'm assuming you may not sleep whilst in rcu-walk mode.

David
