From: Paul Smith <psmith@netezza.com>
Subject: Another minor build nit...
Date: Tue, 07 Nov 2006 17:16:22 -0500
Message-ID: <1162937782.26623.24.camel@localhost>
Reply-To: psmith@netezza.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

I notice that you have defined an INSTALLROOT make variable, which is
very handy.  Just a comment that all the autotools and lots of other
F/OSS build systems have settled on DESTDIR as the name of this variable
(it does the same thing INSTALLROOT does).

Adding something simple like:

   INSTALLROOT = $(DESTDIR)

to Makefile.rules or similar could allow for both uses, which would make
integrating autofs with automated build systems that have built-in
support for autotools-style configure/build/install systems.

Cheers!

-- 
-----------------------------------------------------------------------------
 Paul D. Smith <psmith@netezza.com>                       http://netezza.com
 "Please remain calm--I may be mad, but I am a professional."--Mad Scientist
-----------------------------------------------------------------------------
      These are my opinions--Netezza takes no responsibility for them.
