From: Ian Kent <raven@themaw.net>
Subject: Re: nested automounts: bind and nfs
Date: Tue, 02 Oct 2007 12:53:50 +0800
Message-ID: <1191300830.26331.24.camel@raven.themaw.net>
References: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
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
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org

On Mon, 2007-10-01 at 16:08 +0200, Lukas Kolbe wrote:
> Hi!
> 
> I'm having the problem that was described last year on this list:
> http://osdir.com/ml/linux.kernel.autofs/2006-08/msg00040.html
> 
> Given the following mount map:
> 
> eclipse-3.1 \
>   /bin          -rw,nosuid,grpid          fileserver:/volumes/vol1/eclipse-3.1/bin.linx86 \
> 
> eclipse \
>   /bin          -rw,nosuid,grpid          :/vol/eclipse-3.1/bin \
> 
> We can't access /vol/eclipse/bin on the client if /vol/eclipse-3.1/bin
> is not already mounted. The log says:
> 
> 
> Oct  1 15:58:45 lahn automount[3329]: attempting to mount entry /vol/eclipse
> Oct  1 15:58:45 lahn automount[3329]: mounted /vol/eclipse
> Oct  1 15:58:45 lahn automount[3329]: attempting to mount entry /vol/eclipse/bin
> Oct  1 15:58:45 lahn automount[3329]: mount(nfs): nfs: mount failure :/vol/eclipse-3.1/bin on /vol/eclipse/bin
> Oct  1 15:58:45 lahn automount[3329]: failed to mount /vol/eclipse/bin
> 
> This fails, after a simple ls -la /vol/eclipse/bin.
> 
> Now we're doing ls -la /vol/eclipse-3.1/bin:
> 
> Oct  1 15:59:04 lahn automount[3329]: attempting to mount entry /vol/eclipse-3.1
> Oct  1 15:59:04 lahn automount[3329]: mounted /vol/eclipse-3.1
> Oct  1 15:59:04 lahn automount[3329]: attempting to mount entry /vol/eclipse-3.1/bin
> Oct  1 15:59:04 lahn automount[3329]: mount(nfs): mounted fileserver:/volumes/vol1/eclipse-3.1/bin.linx86 on /vol/eclipse-3.1/bin
> Oct  1 15:59:04 lahn automount[3329]: mounted /vol/eclipse-3.1/bin
> 
> And after that, ls -la /vol/eclipse/bin of course succeeds:
> 
> Oct  1 15:59:06 lahn automount[3329]: attempting to mount entry /vol/eclipse/bin
> Oct  1 15:59:06 lahn automount[3329]: mounted /vol/eclipse/bin
> 
> Should I try the patch mentioned in the thread last year? I'm currently
> using kernel 2.6.18 (from debian, we're bound to that one since it
> supports xen), autofs-5.0.2 with all patches from kernel.org applied.

Can you post a debug log of this failure please.
Instructions to get what we need can be found at
http://people.redhat.com/jmoyer.

Ian
