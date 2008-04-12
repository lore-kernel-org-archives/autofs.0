From: Ian Kent <raven@themaw.net>
Subject: Re: autofs-5.0.1-0.rc2.55.el5.3 core dump
Date: Sat, 12 Apr 2008 11:22:31 +0800
Message-ID: <1207970551.3138.9.camel@raven.themaw.net>
References: <47FF8D07.7080208@schrodinger.com>
	<x49iqyo9x8i.fsf@segfault.boston.devel.redhat.com>
	<47FF9443.4020305@schrodinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47FF9443.4020305@schrodinger.com>
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


On Fri, 2008-04-11 at 09:39 -0700, Simon Gao wrote:
> Jeff Moyer wrote:
> > Simon Gao <gao@schrodinger.com> writes:
> >
> >   
> >> Hi,
> >>
> >> We have many RHEL 5.1 desktops running 2.6.18-53.1.14 X86_64. Many of 
> >> them have core dump files related to autofs. The autofs package is
> >> autofs-5.0.1-0.rc2.55.el5.3.
> >>     
> >
> >   
> >> # strings core.2594 | head
> >>     
> >
> > You can use the 'file' command to determine to what program a core
> > belongs:
> >
> > $ file /tmp/core.2350 
> > /tmp/core.2350: ELF 32-bit LSB core file Intel 80386, version 1 (SYSV), SVR4-style, from 'automount'
> >
> > Anyway, we won't be able to tell why it dumped core without at least a
> > stack trace, and preferrably the core file itself.
> >
> > Cheers,
> >
> > Jeff
> >   
> I can provide a core file if you let me know to where I can upload the file?

Maybe I'm a bit slow and maybe there's something I just don't know but I
always have trouble setting up an environment that can get useful
information from a supplied core file.

How about you provide a gdb backtrace for the core?
That would be far easier and quicker for everyone.

You can get what we need by installing the corresponding
autofs-debuginfo package and running:

gdb -c /tmp/core.2350 /usr/sbin/automount
gdb> thr a a bt

and then posting that output. This should tell us if what you've seen is
something that has been seen before and has been fixed or if it's
something new.

The output is useless without at least the autofs-debuginfo package
installed.

Ian
