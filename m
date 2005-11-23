From: Ian Kent <raven@themaw.net>
Subject: Re: automount never umount
Date: Wed, 23 Nov 2005 09:26:04 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0511230924570.26458@wombat.indigo.net.au>
References: <4381E865.4070908@bppiac.hu>
	<Pine.LNX.4.58.0511220822410.16196@wombat.indigo.net.au>
	<4382E835.3020904@bppiac.hu>
	<Pine.LNX.4.63.0511222054060.2600@donald.themaw.net>
	<438344F7.8020503@bppiac.hu>
	<17283.19512.49399.338448@segfault.boston.redhat.com>
	<43838CA9.40105@bppiac.hu>
	<17283.46783.748916.772469@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17283.46783.748916.772469@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 22 Nov 2005, Jeff Moyer wrote:

> 
> Try the kernel rpm located here:
> 
> 	http://people.redhat.com/jmoyer/farkas/kernel-2.6.14-1.1641_FC4.jmoyertest.1.i686.rpm
> 
> It has the potential to generate a good bit of output.  I've attached the
> patch that is incorporated there.  You'll want to post the output of dmesg
> to this list when you get it.
> 
> You'll notice that the second bit of this patch is not related to this
> problem.  Ian, you should take that into account if you keep around the
> expiry of negative dentries.

Good one. Thanks.

Ian
