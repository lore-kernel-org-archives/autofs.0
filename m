From: raven@themaw.net
Subject: Re: Re: [PATCH 1/3] autofs4 - expiring filesystem from
	under process
Date: Tue, 12 Apr 2005 20:44:51 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504122029420.2460@donald.themaw.net>
References: <Pine.LNX.4.62.0504102044140.5212@donald.themaw.net>
	<16986.44640.269893.824019@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16986.44640.269893.824019@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Michael Blandford <michael@kmaclub.com>

On Mon, 11 Apr 2005, Jeff Moyer wrote:

Glad you were able to find time to review the patches Jeff.
Much appreciated.

> ==> Regarding [PATCH 1/3] autofs4 - expiring filesystem from under process; raven@themaw.net adds:
>
> raven> autofs4-2.6.12-rc1-mm4-wait-order.patch
>
> raven> It's possible for an event wait request to arive before the event
> raven> requestor. If this happens the daemon never gets notified and autofs
> raven> hangs.
>
> I'm not sure I understand your problem description.  Could you please
> elaborate on the set of circumstances that lead to this?

The case is similar to the one you describe below except it's during the 
entry to the expire event.

During an expire, after a dentry is selected to be expired and 
AUTOFS_INF_EXPIRE is set. Another process may take the same path as below 
via try_to_fill_dentry and race for the semaphore. The result is the same 
as your example below.

>
> expire process runs and issues AUTOFS_EXPIRE_MULTI, which sets
> AUTOFS_INF_EXPIRING in flags.  While the expire is in progress, another
> process access the directory in question, causing a call to
> try_to_fill_dentry.  try_to_fill_dentry sees the AUTOFS_INF_EXPIRING flag
> is set, and so calls autofs4_wait with notify set to NFY_NONE.  However,
> when we take the wq sem, we find that the expire has finished, and thus
> create a new wq entry.  Because NFY_NONE is set, we don't tell the daemon.
>
> So how will this process ever get woken up?

Never.
Well spotted.

This certainly looks like a potential race.
It appears to be the same case except on exit from the expire instead of 
on entry.

I've missed it till now.

I don't have a solution yet either but I'll give it some thought and see 
what I can come up with.

Ian
