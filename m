From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta2
Date: Tue, 16 May 2006 23:11:30 -0400
Message-ID: <x49y7x12vml.fsf@redhat.com>
References: <Pine.LNX.4.64.0605091848390.12829@raven.themaw.net>
	<446251C5.5070407@inria.fr>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <446251C5.5070407@inria.fr> (Guillaume Rousse's message of "Wed,
	10 May 2006 22:49:09 +0200")
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] [ANNOUNCE] autofs 5.0.0 beta2; Guillaume Rousse <Guillaume.Rousse@inria.fr> adds:

Guillaume.Rousse> Ian Kent wrote:
>> Hi all,
>> 
>> It's time for an updated beta.
>> 
>> autofs ======
>> 
>> The package can be found at:
>> 
>> ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5
>> 
>> It is autofs-5.0.0_beta2.tar.[gz|bz2]
>> 
>> No source rpm is there as it can be produced by using:
>> 
>> rpmbuild -ts autofs-5.0.0_beta2.tar.gz
>> 
>> and the binary rpm by using:
>> 
>> rpmbuild -tb autofs-5.0.0_beta2.tar.gz
>> 
>> See the INSTALL file for information about configure options and kernel
>> requirements.
Guillaume.Rousse> I couldn't test it really yet, as mandriva development
Guillaume.Rousse> kernel is still 2.6.14, however here are a few remarks:

Guillaume.Rousse> First, stripping binaries by default, especially during
Guillaume.Rousse> compilation, is opposite behaviour of standard
Guillaume.Rousse> autotools-based procedure, where it only occurs if you
Guillaume.Rousse> install with "make stripinstall". I need to have debug
Guillaume.Rousse> symbols present when building a package, as they are
Guillaume.Rousse> automatically for extracting them in a separate debug
Guillaume.Rousse> package. I've found that "make DEBUG=1" would prevent
Guillaume.Rousse> stripping, but it also defines an additional CFLAG with
Guillaume.Rousse> unknown result :/

Try the attached patch.  It was made against the 4.1.3 Red Hat packages,
but you get the idea.  Basically, "make -DDONTSTRIP."

Guillaume.Rousse> Second, the two attached patches don't apply anymore: -
Guillaume.Rousse> autofs-4.1.4-signal-race-fix.patch seems to refer to
Guillaume.Rousse> parts of automount.c not existing anymore -
Guillaume.Rousse> autofs-4.1.1-get-best-mount.patch refer to a 4 args
Guillaume.Rousse> get_best_mount() function that only has 3 args nowadays

Why would you apply 4.1.x patches to 5.x?  *Quite* a lot has changed.  I
suggest dropping the patches.

Guillaume.Rousse> Third, the following patches still apply, but I got no
Guillaume.Rousse> clue about their usefulness: -

Guillaume.Rousse> autofs-4.1.0-hesiod-bind.patch

I'll do some digging on this one tomorrow.

Guillaume.Rousse> autofs-4.1.0-loop.patch

Drop this one.

-Jeff

--- autofs-4.1.3/Makefile.rules.orig	2006-04-05 12:33:53.000000000 -0400
+++ autofs-4.1.3/Makefile.rules	2006-04-05 13:15:15.000000000 -0400
@@ -22,10 +22,16 @@ CFLAGS    = -O2 -g -DDEBUG
 LDFLAGS   = -g
 STRIP     = :
 else
+ifdef DONTSTRIP
+CFLAGS    = -O2 -g
+LDFLAGS   = -g
+STRIP     = :
+else # normal compile
 CFLAGS    = -O3 -fomit-frame-pointer -Wall
 LDFLAGS   = -s
 STRIP     = strip --strip-debug
-endif
+endif # DONTSTRIP
+endif # DEBUG
 
 CC        = gcc
 CXX       = g++
