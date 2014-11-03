From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 04/13] autofs4 - change printks AUTOFS defined prints
Date: Mon, 03 Nov 2014 06:33:35 -0800
Message-ID: <1415025215.17743.12.camel@perches.com>
References: <20141103081218.6215.85903.stgit@perseus.themaw.net>
	 <20141103081234.6215.82821.stgit@perseus.themaw.net>
	 <1415003136.17743.9.camel@perches.com>
	 <1415006418.6573.6.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1415006418.6573.6.camel@perseus.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 2014-11-03 at 17:20 +0800, Ian Kent wrote:
> On Mon, 2014-11-03 at 00:25 -0800, Joe Perches wrote:
> > On Mon, 2014-11-03 at 16:12 +0800, Ian Kent wrote:
> > > Use the AUTOFS_*() print defines instead of raw printks.

Hi again Ian

> > It's probably better to simply use
> > 	#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > or
> > 	#define pr_fmt(fmt) KBUILD_MODNAME ":%d:%s" fmt, current->pid, __func__
> > if you _really_ want pid/func in the output
> 
> I do, yes.

That's fine.  I left out the trailing semicolon/space.
The pr_fmt could be something like:
#define pr_fmt(fmt) KBUILD_MODNAME ":%d:%s: " fmt, current->pid, __func__
or add a "pid:" descriptor prefix if you like too:
#define pr_fmt(fmt) KBUILD_MODNAME ":pid:%d:%s: " fmt, current->pid, __func__

> > it's better to use a consistent style for
> > these logging functions ideally with terminating
> > newlines so there isn't a mix of code with
> > and without those newlines.  That inconsistency
> > leads to unintended defects.
> 
> The idea here was to make the logging consistent throughout.

Mine too.

> I have become used of not using the new-line terminator in logging over
> the years and tend to favour that myself. You recommend not doing that
> probably from a kernel wide consistency perspective? Maybe that is
> better ...

Yes, kernel style consistency is the rationale.

Over time, people come along and add messages
while not reading the code very closely so using
the kernel style with newlines can help avoid
these trivial defects.

cheers, Joe

