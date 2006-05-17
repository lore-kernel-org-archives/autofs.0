From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta2
Date: Wed, 17 May 2006 10:45:49 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605171035370.20033@raven.themaw.net>
References: <Pine.LNX.4.64.0605091848390.12829@raven.themaw.net>
	<446251C5.5070407@inria.fr>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <446251C5.5070407@inria.fr>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

On Wed, 10 May 2006, Guillaume Rousse wrote:

Thanks for the feedback Guillaume.

> Ian Kent wrote:
> > Hi all,
> > 
> > It's time for an updated beta.
> > 
> > autofs
> > ======
> > 
> > The package can be found at:
> > 
> > ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5
> > 
> > It is autofs-5.0.0_beta2.tar.[gz|bz2]
> > 
> > No source rpm is there as it can be produced by using:
> > 
> > rpmbuild -ts autofs-5.0.0_beta2.tar.gz
> > 
> > and the binary rpm by using:
> > 
> > rpmbuild -tb autofs-5.0.0_beta2.tar.gz
> > 
> > See the INSTALL file for information about configure options and
> > kernel requirements.
> I couldn't test it really yet, as mandriva development kernel is still
> 2.6.14, however here are a few remarks:
> 
> First, stripping binaries by default, especially during compilation, is
> opposite behaviour of standard autotools-based procedure, where it only
> occurs if you install with "make stripinstall". I need to have debug
> symbols present when building a package, as they are automatically for
> extracting them in a separate debug package. I've found that "make
> DEBUG=1" would prevent stripping, but it also defines an additional
> CFLAG with unknown result :/

If this is what I think it is then there may be a patch around that I can 
use.

I'm not completely clear on what your saying though.
Could you give more details please.

> 
> Second, the two attached patches don't apply anymore:
> - autofs-4.1.4-signal-race-fix.patch seems to refer to parts of
> automount.c not existing anymore

This patch is not relevant any more.
The signal handling in the threaded environment is completely different.

> - autofs-4.1.1-get-best-mount.patch refer to a 4 args get_best_mount()
> function that only has 3 args nowadays

This patch makes get_best_mount use a long timeout always instead of a 
short timeout followed by long timeout if it the first rpc_ping fails.

I think that get_best_mount was not falling back to the long timeout so 
this patch was used to work around it. I'm fairly sure that was fixed.

Anyway, get_best_mount will go away soon as the server selection code is 
being re-written.

> 
> Third, the following patches still apply, but I got no clue about their
> usefulness:
> - autofs-4.1.0-hesiod-bind.patch

OK. I've seen this patch several times.
No one has yet been able to explain what it's for.

> - autofs-4.1.0-loop.patch

I've seen this patch before as well.
Not sure why this patch is not included.
I'll review it again.

Ian
