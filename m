From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: mount 2.12: proplist and failed mounts
Date: Fri, 25 Jun 2004 08:19:16 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16604.6212.198799.326752@segfault.boston.redhat.com>
References: <20040625110243.GH22003@neu.nirvana>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040625110243.GH22003@neu.nirvana>
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
To: Axel Thimm <Axel.Thimm@atrpms.net>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] mount 2.12: proplist and failed mounts; Axel Thimm <Axel.Thimm@atrpms.net> adds:

Axel.Thimm> Hi, I was happily using autofs 4.1.3 with mount 2.11y. The maps
Axel.Thimm> contained the proplist option (we share the maps with some OSF1
Axel.Thimm> boxes), but that did not disturb.

Axel.Thimm> for other reasons I had to upgrade mount to 2.11 (part of
Axel.Thimm> util-linux). Suddenly autofs will not mount anymore with errors
Axel.Thimm> like:

Axel.Thimm> Jun 25 12:25:50 heretic automount[12646]: failed to mount
Axel.Thimm> /home/thimm Jun 25 12:25:50 heretic automount[12648]: >>
Axel.Thimm> Unsupported nfs mount option: proplist Jun 25 12:25:50 heretic
Axel.Thimm> automount[12648]: mount(nfs): nfs: mount failure
Axel.Thimm> nukleon:/amd/nukleon/1/home/ag-linke/thimm on /home/thimm

Axel.Thimm> I tested mount -o proplist and I got the above error and the
Axel.Thimm> exit code was 32:
>> mount -o proplist nukleon:/amd/nukleon/1/home/ag-linke/thimm /home/thimm
Axel.Thimm> Unsupported nfs mount option: proplist
>> echo $?
Axel.Thimm> 32

Axel.Thimm> OK, so I thought mount has become quite picky now, and
Axel.Thimm> downgraded. I retried the manual mount and got the same error &
Axel.Thimm> exit code!

Axel.Thimm> But autofs works properly again?!?

Axel.Thimm> For one I'd like to understand how autofs manages to workaround
Axel.Thimm> this error for 2.11y, and perhaps whether this can be used for
Axel.Thimm> mount 2.12, also. Granted, the true error lies in the
Axel.Thimm> configuration asking for unsupported proplist options, but
Axel.Thimm> since it had a nice and greceful error fallback until now, it
Axel.Thimm> would be nice to keep it.

You need to specify the sloppy mount option (-s) for this to work.  It
basically tells mount to not be so picky about options it doesn't
understand.  (Note that autofs uses this option.)

As for your experience, were you using Red Hat packages per chance?  I had
a bug filed here (on FC2, I think) which described your situation.  The
problem was that someone (not naming names) accidentally committed some
code which did not allow sloppy mounts for NFS.  It has since been fixed.

Please let me know if you need more help tracking this down.

Thanks!

Jeff
