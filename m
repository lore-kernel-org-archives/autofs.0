From: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] autofs4 deadlock during expire - kernel 2.6
Date: Wed, 24 Sep 2003 15:57:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030924155720.C31236@devserv.devel.redhat.com>
References: <1064408962.5074.2.camel@laptop.fenrus.com> <Pine.LNX.4.44.0309242136080.6713-100000@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309242136080.6713-100000@raven.themaw.net>; from raven@themaw.net on Wed, Sep 24, 2003 at 09:38:16PM +0800
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Arjan van de Ven <arjanv@redhat.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>

On Wed, Sep 24, 2003 at 09:38:16PM +0800, Ian Kent wrote:
> > interruptible_sleep_on ?
> > 
> 
> OK so maybe I should have suggestions instead of comments.

instead of interruptible_sleep_on(), it looks like you really want
to use completions for this code..
see kernel/workqueue.c for how those are used
