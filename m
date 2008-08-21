From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: LDAP-based "auto.net" for /net
Date: Thu, 21 Aug 2008 09:36:31 -0400
Message-ID: <x493akyjxr4.fsf@segfault.boston.devel.redhat.com>
References: <39967.129.83.31.3.1219317751.squirrel@webmail.kickflop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <39967.129.83.31.3.1219317751.squirrel@webmail.kickflop.net>
	(jblaine@kickflop.net's message of "Thu, 21 Aug 2008 04:22:31 -0700
	(PDT)")
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
To: jblaine@kickflop.net
Cc: autofs@linux.kernel.org

jblaine@kickflop.net writes:

> If anyone has been successful in getting /net/hostname
> automounting working with LDAP-based autofs maps (not
> a local /etc/auto.net file), I would love to see your
> LDIF information showing how you configured it.

First, program maps must be on a file system.  Second, are you using
autofs version 4 or 5?  If 5, then you can simply use the ldif
equivalent of:

/net       -hosts

> PS: wiki.autofs.net might as well be taken off the net.
>     It contains absolutely nothing of worth other than
>     a link to the mailing list stuff.

It hasn't exactly been publicized because those working on it (Ian and
myself) haven't had time to make it useful.  Sorry.

Cheers,

Jeff
