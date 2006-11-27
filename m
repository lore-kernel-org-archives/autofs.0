From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: excluding some pattern to prevent useless mount request
Date: Mon, 27 Nov 2006 13:48:46 -0500
Message-ID: <x49bqmswws1.fsf@segfault.boston.devel.redhat.com>
References: <456B1516.1030108@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <456B1516.1030108@inria.fr> (Guillaume Rousse's message of "Mon,
	27 Nov 2006 17:40:54 +0100")
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

==> On Mon, 27 Nov 2006 17:40:54 +0100, Guillaume Rousse <Guillaume.Rousse@inria.fr> said:

Guillaume> While looking in server's log, I found many such mount requests:
Guillaume> Nov 26 04:23:19 yquem rpc.mountd: refused mount request from
Guillaume> chouchen.inria.fr for /home/yquem/.hidden (/): no export entry
Guillaume> ...
Guillaume> Nov 26 04:22:33 yquem rpc.mountd: refused mount request from
Guillaume> medoc.inria.fr for /home/yquem/.directory (/): no export entry

Guillaume> I guess they are caused by graphical file manager trying to find
Guillaume> metadata directories when displaying mount points. Is there a way to
Guillaume> prevent them ?

No, there is not a way to prevent them.  The basic problem is that the
requests could be valid;  how is the automounter to know which
directory lookups to ignore?  haldaemon has been responsible for some
problems in the past, but its authors chose to include special cases
for automount-managed directories.  This is not the most ideal
solution, I guess, but it is the most attractive from the autofs point
of view.

Can you find out which applications are causing these lookups and file
bugs in their respective bug trackers?

-Jeff
