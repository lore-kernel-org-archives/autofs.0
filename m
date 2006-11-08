From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs won't cross-compile
Date: Wed, 08 Nov 2006 11:39:46 -0500
Message-ID: <x491wodki3x.fsf@segfault.boston.devel.redhat.com>
References: <1162928208.26623.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1162928208.26623.15.camel@localhost> (Paul Smith's message of
	"Tue, 07 Nov 2006 14:36:48 -0500")
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
To: psmith@netezza.com
Cc: autofs@linux.kernel.org

Paul Smith <psmith@netezza.com> writes:

> Hi all; autofs's configure.in is not properly set up to allow for
> cross-compiling.  It fails trying to detect -fPIE, because configure.in
> runs AC_RUN_IFELSE to run a program (which of course can't work during
> cross-compilation) and does not provide a cross-compilation result.
>
> I'm not sure why this test for PIE exists or if it's really needed, but
> if you want to keep it please add an argument for cross-compilation.
> Patch is attached, against 4.1.4 (but I checked 5.00beta1 and it had the
> same issue).  As recommended by the autoconf manual, this patch is
> pessimistic and assumes no PIE support for all cross-compilation
> environments.
>
> I've split the patch into two: one for configure.in and one for
> configure itself (I'm not sure if you source code control the configure
> script: some projects do and some don't).

This is the wrong way to go about it.  We should probably provide a
--enable-PIE or some such option.  That way, anyone who cross-compiles
has the option of enabling it.

-Jeff
