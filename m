From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs4 with NetApp-Filer and large export list:
	Stopped working for me
Date: Fri, 27 Apr 2007 09:05:06 -0400
Message-ID: <x493b2m2cjh.fsf@segfault.boston.devel.redhat.com>
References: <4631ED94.70900@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4631ED94.70900@googlemail.com> (Gerd Bavendiek's message of "Fri,
	27 Apr 2007 14:33:24 +0200")
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
To: Gerd Bavendiek <gerd.bavendiek@googlemail.com>
Cc: autofs@linux.kernel.org

==> On Fri, 27 Apr 2007 14:33:24 +0200, Gerd Bavendiek <gerd.bavendiek@googlemail.com> said:

Gerd> Hi,
Gerd> I used to use autofs4 with a NetApp-Filer as NFS server (mostly from
Gerd> SLES9 boxes). This does not seem to work any longer. So I digged a
Gerd> little bit deeper:

Thanks for the detailed problem report!

Gerd> The NetApp-Filer in question exports nearly 100 volumes:

[snip]

Gerd> Apr 27 11:25:06 sappscmn automount[7876]: >> /usr/sbin/showmount: can't 
Gerd> get address for 10.172.230.134/vol/pcc

This is a problem.  This means that the kernel is passing along a
lookup for 10.172.230.134/vol/pcc, when it should only be asking for
10.172.230.134.  What kernel version are you running?  Can you update
to the latest vendor-supplied kernel and try again?  (I'm not sure if
SuSE fixed this in their kernels, but I'm hoping they did).

If the latest kernel does not fix your problem, please respond here
and we'll point you at the appropriate patches to apply.

Note that autofs version 5 now implements a 'hosts' lookup module
which is a bit less kludgy than auto.net.  Ian may have something to
add to this conversation regarding the access lists.

-Jeff
