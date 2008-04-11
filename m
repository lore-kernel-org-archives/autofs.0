From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs-5.0.1-0.rc2.55.el5.3 core dump
Date: Fri, 11 Apr 2008 12:23:25 -0400
Message-ID: <x49iqyo9x8i.fsf@segfault.boston.devel.redhat.com>
References: <47FF8D07.7080208@schrodinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47FF8D07.7080208@schrodinger.com> (Simon Gao's message of "Fri\,
	11 Apr 2008 09\:08\:39 -0700")
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
To: Simon Gao <gao@schrodinger.com>
Cc: autofs@linux.kernel.org

Simon Gao <gao@schrodinger.com> writes:

> Hi,
>
> We have many RHEL 5.1 desktops running 2.6.18-53.1.14 X86_64. Many of 
> them have core dump files related to autofs. The autofs package is
> autofs-5.0.1-0.rc2.55.el5.3.

> # strings core.2594 | head

You can use the 'file' command to determine to what program a core
belongs:

$ file /tmp/core.2350 
/tmp/core.2350: ELF 32-bit LSB core file Intel 80386, version 1 (SYSV), SVR4-style, from 'automount'

Anyway, we won't be able to tell why it dumped core without at least a
stack trace, and preferrably the core file itself.

Cheers,

Jeff
