From: Ryan Go <ryan@rentec.com>
Subject: Re: autofs-5.0.3 segfaulting when HUP'ed
Date: Fri, 31 Oct 2008 17:49:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0810311748030.8489@elr.eragrp.pbz>
References: <Pine.LNX.4.64.0810291158340.1841@elr.eragrp.pbz>
	<1225334666.3012.38.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1225334666.3012.38.camel@zeus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Thu, 30 Oct 2008, Ian Kent wrote:

> On Wed, 2008-10-29 at 12:48 -0400, Ryan Go wrote:
[snip...]
>
> Grab:
> autofs-5.0.3-library-reload-fix.patch
> autofs-5.0.3-expire-thread-create-cond-handling.patch
>
> as well, uploaded to kernel.org just now, might take a while to sync to
> the mirrors.
>
> I'm not sure this solves the problem but an initial report was positive.
> Let me know how it goes.
>
> Ian
>
>
>

Hello Ian,

The patches seemed to resolve the segfault problem.

Thanks for the help.

Ryan

---
Ryan Go
Renaissance Technologies LLC
