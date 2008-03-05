From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: Kernel patch to better support bind-mounts
Date: Wed, 05 Mar 2008 15:24:12 +0100
Message-ID: <1204727052.3678.3.camel@srss>
References: <1199788697.26268.24.camel@srss>
	<1204634872.11825.79.camel@srss>  <47CD4DC9.2030703@redhat.com>
	<1204685216.3081.7.camel@raven.themaw.net>
	<47CEABF9.8090108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47CEABF9.8090108@redhat.com>
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
To: Peter Staubach <staubach@redhat.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Hi Peter!

>> Lucas has recursive maps.
> > For these mounts to work, we need to ensure that there aren't dependent
> > mounts in the mount point path itself before proceeding. We've used the
> > access system call, made just prior to performing the mount, to make
> > this happen. In this case, however, the lookup flags in the kernel where
> > not triggering the mount.
> 
> And this does not trigger mounts by other applications, such as ls, too?

Nope. If I only 'ls -la' my /vol/ or /homes, nothing gets mounted at
all.

>     Thanx...
> 
>        ps

-- 
Lukas
