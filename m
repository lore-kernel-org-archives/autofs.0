From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Query about autofs4 module
Date: Fri, 17 Dec 2004 10:45:23 -0500
Message-ID: <16834.65299.47641.618270@segfault.boston.redhat.com>
References: <20041217125201.55052.qmail@web8404.mail.in.yahoo.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20041217125201.55052.qmail@web8404.mail.in.yahoo.com>
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
Content-Type: text/plain; charset="us-ascii"
To: "s. lele" <satlele@yahoo.co.in>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] Query about autofs4 module; "s. lele" <satlele@yahoo.co.in> adds:

satlele> Their was one problem reported as follows: RHEL3 U3 X86 system
satlele> generates automount messages to /var/log/messages that look like:
satlele> automount[<pid>]: BUG: <mount_point> already mounted

satlele> After checking the following bugzilla web-link:
satlele> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=132831, the
satlele> problem was found due to autofs module.  autofs module need to be
satlele> unloaded and autofs4 module need to be loaded.  The following
satlele> steps steps should hopefully resolve the problem: # service autofs
satlele> stop # rmmod autofs # service autofs start which should show
satlele> autofs4 module in "lsmod" command.

satlele> My query is as follows: Before unloading autofs module and loading
satlele> autofs4 module, just want to confirm if the following autofs
satlele> options will be honoured with autofs4 module in NIS environment
satlele> (used for automounting) without any problem:

satlele> test -hard,tcp,intr,bg,rsize=32768,wsize=32768,retry=100
satlele> xxxx:/export/home/home_00/test /usr/sbin/automount /home yp
satlele> auto.home --timeout 3600 -XXX=i686-pc-linux2.4.21-ZZZ

This should work fine.

-Jeff
