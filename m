From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [autofs4 patch] Use /proc/mounts instead of /etc/mtab
Date: Wed, 08 Nov 2006 22:25:15 -0500
Message-ID: <x49ac31nvxg.fsf@segfault.boston.devel.redhat.com>
References: <x49zmb1nwy5.fsf@segfault.boston.devel.redhat.com>
	<1163042229.4475.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1163042229.4475.2.camel@localhost> (Ian Kent's message of "Thu,
	09 Nov 2006 11:17:09 +0800")
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
Cc: autofs mailing list <autofs@linux.kernel.org>

==> On Thu, 09 Nov 2006 11:17:09 +0800, Ian Kent <raven@themaw.net> said:

Ian> On Wed, 2006-11-08 at 22:03 -0500, Jeff Moyer wrote: > Hi, Ian,
Ian> list,
Ian> > 
Ian> > Here is a patch to consult /proc/mounts instead of /etc/mtab
Ian> when > deciding if a path has already been mounted.  The problem
Ian> with using > /etc/mtab, as you know, is that it sometimes does
Ian> not get updated.  We > know that /proc/mounts will always be
Ian> right, so why not use it?

Ian> Good for v4 but keep in mind that in v5 /proc/mounts can have a
Ian> lot of entries compared to /etc/mtab. The cost of doing this can
Ian> be quite high.  mount(8) must play well with mtab for v5.

It's not just mount(8), but also the caller's responsibility.  You
have to be sure to check for the mtab not updated return value, and
issue another mount call to try to update it.

-Jeff
