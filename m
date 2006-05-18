From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta2
Date: Thu, 18 May 2006 16:56:52 +0200
Message-ID: <446C8B34.5000602@inria.fr>
References: <Pine.LNX.4.64.0605091848390.12829@raven.themaw.net>	<446251C5.5070407@inria.fr>
	<x49y7x12vml.fsf@redhat.com>	<446C78F9.2080403@inria.fr>
	<x49mzdfjt3g.fsf@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49mzdfjt3g.fsf@segfault.boston.redhat.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Cc: autofs@linux.kernel.org

Jeff Moyer wrote:
> ==> Regarding Re: [autofs] [ANNOUNCE] autofs 5.0.0 beta2; Guillaume Rousse <Guillaume.Rousse@inria.fr> adds:
> 
> Guillaume.Rousse> I couldn't test it really yet, as mandriva development
> Guillaume.Rousse> kernel is still 2.6.14, however here are a few remarks:
> Guillaume.Rousse> First, stripping binaries by default, especially during
> Guillaume.Rousse> compilation, is opposite behaviour of standard
> Guillaume.Rousse> autotools-based procedure, where it only occurs if you
> Guillaume.Rousse> install with "make stripinstall". I need to have debug
> Guillaume.Rousse> symbols present when building a package, as they are
> Guillaume.Rousse> automatically for extracting them in a separate debug
> Guillaume.Rousse> package. I've found that "make DEBUG=1" would prevent
> Guillaume.Rousse> stripping, but it also defines an additional CFLAG with
> Guillaume.Rousse> unknown result :/
>>> Try the attached patch.  It was made against the 4.1.3 Red Hat packages,
>>> but you get the idea.  Basically, "make -DDONTSTRIP."
> 
> Guillaume.Rousse> I can achieve the same result without the patch with make
> Guillaume.Rousse> CFLAGS="-O2 -g" LDFLAGS="-g" STRIP=":" However, I find a
> Guillaume.Rousse> bit cumbersome to need top pass arguments both to
> Guillaume.Rousse> configure and to make invocation. And I wanted to point
> Guillaume.Rousse> out it was not standard behaviour.
> 
> Well, patches are welcome, I'm sure.  =)
Even one that would replace existing Makefile.in with automake-generated 
ones ? That's the easiest way I know :)

> I've still not gotten to the hesiod patch.  I hope to do it by the end of
> the week.
Don't worry, there is no emergency at all for me, as I still don't have 
the correct kernel to test autofs 5 anyway :/
