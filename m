From: Paul Smith <psmith@netezza.com>
Subject: Re: autofs won't cross-compile
Date: Tue, 14 Nov 2006 17:46:18 -0500
Message-ID: <1163544378.32038.6.camel@localhost>
References: <1162928208.26623.15.camel@localhost>
	<x491wodki3x.fsf@segfault.boston.devel.redhat.com>
Reply-To: psmith@netezza.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x491wodki3x.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Wed, 2006-11-08 at 11:39 -0500, Jeff Moyer wrote:
> Paul Smith <psmith@netezza.com> writes:
> 
> > Hi all; autofs's configure.in is not properly set up to allow for
> > cross-compiling.  It fails trying to detect -fPIE, because configure.in
> > runs AC_RUN_IFELSE to run a program (which of course can't work during
> > cross-compilation) and does not provide a cross-compilation result.
> >
> > I'm not sure why this test for PIE exists or if it's really needed, but
> > if you want to keep it please add an argument for cross-compilation.
> > Patch is attached, against 4.1.4 (but I checked 5.00beta1 and it had the
> > same issue).  As recommended by the autoconf manual, this patch is
> > pessimistic and assumes no PIE support for all cross-compilation
> > environments.
> >
> > I've split the patch into two: one for configure.in and one for
> > configure itself (I'm not sure if you source code control the configure
> > script: some projects do and some don't).
> 
> This is the wrong way to go about it.  We should probably provide a
> --enable-PIE or some such option.  That way, anyone who cross-compiles
> has the option of enabling it.

That's fine, but why not leave the default as "off", as in my patch?  If
you don't want to do that then please at least add a 5th argument to
AC_RUN_IFELSE to print some kind of message telling the user what to do
(use --enable-pie or --disable-pie).  If you leave it as-is, then
configure just bombs out with a scary error message when it hits that
AC_RUN_IFELSE.

I did find a few other items which broke during cross-compilation; there
are a number of checks in configure looking for programs that live on
the disk, like mount etc.  It's a bit unpleasant since these could
potentially live somewhere different on the target system than they do
on the build system.  One idea would be to have configure options for
these as well.

However, with FHS etc. it's probably not TOO much of a stretch to
imagine these locations are fairly standard.  There is one item, though,
which did bite me: the test for the -s option to mount.  My build system
has it, but my target system uses BusyBox mount which doesn't support
-s.  There is no easy way to turn this off: I had to go in and patch
things to disable it.  It would be nice to have this as a configure
option, or something.

After these changes it does work... yay!

Cheers!

-- 
-----------------------------------------------------------------------------
 Paul D. Smith <psmith@netezza.com>                       http://netezza.com
 "Please remain calm--I may be mad, but I am a professional."--Mad Scientist
-----------------------------------------------------------------------------
      These are my opinions--Netezza takes no responsibility for them.
