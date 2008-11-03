From: Ian Kent <raven@themaw.net>
Subject: Re: another make issue
Date: Mon, 03 Nov 2008 10:44:06 +0900
Message-ID: <1225676646.2911.4.camel@zeus.themaw.net>
References: <510ca9b40811021718j43583340p38cec31f35cc87ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <510ca9b40811021718j43583340p38cec31f35cc87ff@mail.gmail.com>
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
To: Paul Wankadia <junyer@gmail.com>
Cc: autofs@linux.kernel.org

On Mon, 2008-11-03 at 12:18 +1100, Paul Wankadia wrote:
> ...
> make[1]: Entering directory `/home/junyer/autofs/samples'
> install -d -m 755 /etc
> install -d -m 755
> install: missing file operand
> Try `install --help' for more information.
> make[1]: *** [dirs] Error 1
> make[1]: Leaving directory `/home/junyer/autofs/samples'
> ...
> 
> samples/Makefile:
> 
>     19  .PHONY: dirs
>     20  dirs:
>     21          install -d -m 755 $(INSTALLROOT)$(autofsmapdir)
>     22          install -d -m 755 $(INSTALLROOT)$(autofsconfdir)
>     23          install -d -m 755 $(INSTALLROOT)$(autofslibdir)
>     24          install -d -m 755 $(INSTALLROOT)/var/run/autofs
> 
> Makefile.conf:
> 
>     68  # Location for configuration init script
>     69  autofsconfdir =
> 
> autofsconfdir should have a sane default?

Yeah, but there's an assumption that at least one of the directories
that is checked will exist on any system, which is obviously wrong. I
could add /etc to the end of the list but, really what we need is a list
of appropriate directories for various distributions, so if I do that
I'll never find out what they are.

What distribution are you using?

Ian
