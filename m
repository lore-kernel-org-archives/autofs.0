From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Is Autofs 5 Slower Than 4
Date: Wed, 20 Aug 2008 11:06:15 -0400
Message-ID: <x4963pvybdk.fsf@segfault.boston.devel.redhat.com>
References: <241046.64511.qm@web54306.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <241046.64511.qm@web54306.mail.re2.yahoo.com> (Thanh Tran's
	message of "Wed, 20 Aug 2008 08:00:12 -0700 (PDT)")
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
To: ttran7700@yahoo.com
Cc: autofs@linux.kernel.org

Thanh Tran <ttran7700@yahoo.com> writes:

> I upgraded my entire OS from Fedora 5 to 8.  By slow, I mean around 20
> seconds to detect and mount.  There are too many variables.  I was
> hoping it would be a simple polling flag that could be switched in
> autofs.  I can live with the slower time.  I did notice that it took a
> long time only when I physically removed the drive and re-inserted the
> drive.  When I use the "umount" command and not remove the drive, I
> can quickly change directory back to drive and it mounts in like 2
> seconds at most.  Thanks for the help.

I'm still a little unclear on your use case.  Are you sure you're using
autofs to mount your (usb?) drive?  This is typically handled by hal in
newer distributions.

Cheers,

Jeff
