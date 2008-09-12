From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Unexpected autofs behaviour
Date: Fri, 12 Sep 2008 12:01:43 -0400
Message-ID: <x49bpytnyjc.fsf@segfault.boston.devel.redhat.com>
References: <Pine.LNX.4.64.0807151027190.17891@sixgun.ftc.avagotech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0807151027190.17891@sixgun.ftc.avagotech.net>
	(Michael Coffman's message of "Tue, 15 Jul 2008 10:32:16 -0600 (MDT)")
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
To: Michael Coffman <coffman@ftc.avagotech.com>
Cc: autofs@linux.kernel.org, raven@themaw.net


Sorry for the late response.  I don't think anyone responded yet, right?

Michael Coffman <coffman@ftc.avagotech.com> writes:

> I have a question about the behaviour of autofs.  It seems like it is
> very easy to hit a situation where autofs will unmount a file system
> and an active process will lose access to a file and fail to read it.
> This seems to happen with both direct and indirect mapping.
>
> Specifics about what I am running:
>
>     autofs-4.1.3-199.3
>     kernel - 2.6.9-55.ELsmp
>     arch - x86_64
>     OS - Red Hat Enterprise Linux WS release 4 (Nahant Update 5
>
> autofs is configured to use the defaults and has host mapping
> enabled.  When I run the following simple test:
>
>    date;while [[ -r /net/hostname/test ]]; do :; done; date
>
> command output:
>    Fri Jul 11 09:02:46 MDT 2008
>    Fri Jul 11 09:03:59 MDT 2008
> command output run 2:
>    Fri Jul 11 09:11:42 MDT 2008
>    Fri Jul 11 09:12:45 MDT 2008
>
> As you can see, I lose read access typically shortly after the mount is
> supposed to time out.

Yeah, this looks like one of the race conditions that Ian's been closing
up recently.  I think you'll need to test with a newer kernel, where
newer means your distribution hasn't even released it yet.  Ian may be
able to provide a test kernel, I'm not sure.  Ian, did you get
everything backported to a test tree?

Cheers,

Jeff
