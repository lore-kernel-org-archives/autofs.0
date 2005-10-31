From: Ian Kent <raven@themaw.net>
Subject: Re: autofs4 looks up wrong path element when ghosting is
	enabled
Date: Mon, 31 Oct 2005 21:27:32 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0510312119320.2069@donald.themaw.net>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
	<17203.7543.949262.883138@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509241644420.2069@donald.themaw.net>
	<17205.48192.180623.885538@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509250918150.2191@donald.themaw.net>
	<17208.24786.729632.221157@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0510152006340.30122@donald.themaw.net>
	<17238.45372.628520.739194@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0510291536320.2949@donald.themaw.net>
	<17254.252.746357.935671@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17254.252.746357.935671@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Jeff Moyer wrote:

> ==> Regarding Re: autofs4 looks up wrong path element when ghosting is enabled; Ian Kent <raven@themaw.net> adds:
> 
> raven> So to resolve this we need to ignore negative and unhashed dentries
> raven> when checking if directory dentry is empty.
> >>
> raven> Please test this patch and let me know how you go.
> >> OK, I've finally got 'round to testing your patch.  It does fix the test
> >> case I was using.  My only concern is the potential for regressions.
> >> I'll try making sure all of my various maps still work as advertised.
> 
> raven> I've spotted a regression with this patch.  It doesn't stop autofs
> raven> from appearing to function correctly. It causes mount callbacks when
> raven> they shouldn't made. So it seems that there is a case when an autofs
> raven> directory is, as yet unhashed, but should be used.
> 
> I'm not sure I follow.  What do you mean it doesn't stop autofs from
> *appearing* to function correctly?  Do you have a reproducer that fails?

Any pseudo direct map will produce the behaviour.

It behaves as if the ghost option was not specified even when it has. 
This is because the altered test for an empty directory is always 
returning true even though the directory isn't empty.

I'm still trying to understand why this happens. In theory it's just not 
the expected behaviour. I must be missing something in the directory 
creation. I've been here before and looked several times and I just can't 
see why it happens this way.

Ian
