From: Jeff Moyer <jmoyer@redhat.com>
Subject: RE: csh/cd not getting the right cwd at the mount point
Date: Mon, 12 Jul 2004 14:16:26 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16626.54650.919501.227816@segfault.boston.redhat.com>
References: <BA0E4392AD99D040885C414D992C24BE08264BD4@us-bv-m11.bv.tek.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BA0E4392AD99D040885C414D992C24BE08264BD4@us-bv-m11.bv.tek.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: peter.a.harris@exgate.tek.com
Cc: autofs@linux.kernel.org, raven@themaw.net

==> Regarding RE: [autofs] csh/cd not getting the right cwd at the mount point; peter.a.harris@exgate.tek.com adds:

peter> Ian/Jeff, I just tried your test below and I **was** able to touch
peter> the file successfully, even though I was seeing my problem.  The
peter> problem I am seeing seems to be limited to what the system thinks is
peter> the cwd.  Let me try to restate the problem...

[snip]

peter> I sent this in mostly as a "have you seen this in the latest" just
peter> in case it had not been fixed.

The message I was trying to get across was this: I tried precisely the
steps you mentioned, and it works in my environment.  My environment is the
following:
	autofs-4.1.3-10
	kernel-2.4.21-16.EL

The kernel is not public, but the next available release will include the
same autofs4 patches.

peter> I know I am behind.  I have resisted compiling the kernel because
peter> the tool vendors latch on to that as the cause of any problem you
peter> report and won't talk to you until you can duplicate it on vanilla
peter> system, which, since all the files and programs are automounted
peter> becomes something of a catch-22; not insurmountable, but a royal
peter> pain none the less.  I will be rolling forward soon when we apply
peter> RHEL 3 Update 2.  Did I read Jeff's note correctly that the kernel
peter> patch will be in Update 3??  That would make my summer (I know, I
peter> should get out more)!

Yes, autofs4 will be part of RHEL 3 Update 3.  That includes the userspace,
which will be autofs-4.1.3-9.

For those interested, I've posted the RHEL3 autofs4 kernel patch to my
people page, as well.  Note that in addition to this change, autofs4 should
be removed from the unsupported list, otherwise you need to install the
-unsupported rpm.

-Jeff
