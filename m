From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Attempt on mounting a non-existing directory
Date: Thu, 01 Nov 2007 12:11:29 -0400
Message-ID: <x493avqdjym.fsf@segfault.boston.devel.redhat.com>
References: <20071101101633.GJ30850@math.leidenuniv.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20071101101633.GJ30850@math.leidenuniv.nl> (Xiwen Cheng's
	message of "Thu\, 1 Nov 2007 11\:16\:33 +0100")
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
To: Xiwen Cheng <xcheng@math.leidenuniv.nl>
Cc: autofs@linux.kernel.org

Xiwen Cheng <xcheng@math.leidenuniv.nl> writes:

> Recently we migrated from static nfs mounts to autofs on our webserver.
> This concerns all /home/*/public_html/ directories which are mounted
> read-only by default. /etc/autofs/auto.home includes some exceptions
> whereas certain users requested their ~/public_html or even ~/ to be
> writable. 
>
> This setup works _almost_ all the time although syslog reveals some
> extremely strange behaviors, a snippet:
>
> Oct 31 17:38:02 host1 automount[14335]: mount(nfs): nfs: mount failure
> nfs.somewhere.com:/home/user/.bash_profile/public_html on
> /home/user/.bash_profile/public_html

This looks a lot like a kernel bug we've chased down and fixed.  It's
hard to be sure, though, without more of the debug log.  I can't
recall exactly when the fix went in, either.  Is it possible for you
to upgrade your kernel and try again?

> The big question mark is: Why does autofs try to mount ~/public_html one
> threshold/level lower? It shouldn't look any further than
> /home/anyuser/public_html.  
> ~/public_html  

http://people.redhat.com/jmoyer has a section on filing bug reports.
If you collect the data requested on that page, then we can get
further in diagnosing your problem.

> Server info
> ===========
> OS:			2.6.19-gentoo-r5
> net-fs/nfs-utils:	1.0.12-r1
> net-libs/libnfsidmap:	0.19
> net-fs/autofs:	4.1.3-r7

I have no idea what patches are applied to the kernel and the autofs
package.

> An offtopic question: what is the real function of the -g (ghost) flag??
> manpages aren't any help.

On my systems (Red Hat based, go figure), the automount man page
documents the flag.

       -g, --ghost
              Request  that  directories  in  the  automount  be shown but not
              mounted until accesssed. The wildcard entry is not ghosted.

This is the equivalent of browsable maps.

Cheers,

Jeff
