From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 01/18] Add a dentry op to handle automounting rather than abusing follow_link()
Date: Thu, 13 Jan 2011 12:20:41 +0000
Message-ID: <14657.1294921241@redhat.com>
References: <AANLkTi=F6PSgQs78MpmG_V3q_ksmYMUwU8=xBoNOypto@mail.gmail.com> <20110111174809.2291.52242.stgit@warthog.procyon.org.uk> <20110111174815.2291.41967.stgit@warthog.procyon.org.uk>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=F6PSgQs78MpmG_V3q_ksmYMUwU8=xBoNOypto@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Piggin <npiggin@gmail.com>
Cc: dhowells@redhat.com, npiggin@kernel.dk, viro@zeniv.linux.org.uk, raven@themaw.net, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Nick Piggin <npiggin@gmail.com> wrote:

> So something has gone wrong here. You have documented .d_automount
> can be called in rcu-walk mode, but it doesn't seem to be the case.

Ah.  You removed a column and installed a new one, and I didn't notice.

Neither d_automount() and d_manage() should be entered in rcu-walk mode since
they're both expected to sleep.

Btw, should you add a fifth column for d_seq?

I should also add a column for namespace_sem as d_manage() may be called with
that held (and d_automount() must not be called with that held).

David
