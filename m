From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Autofs weirdness in nsswitch.conf and other stuff...
Date: Fri, 16 Mar 2007 12:49:37 -0400
Message-ID: <x49r6rpb0bi.fsf@segfault.boston.devel.redhat.com>
References: <60464.128.114.56.35.1173996300.squirrel@webmail.soe.ucsc.edu>
	<1174008860.3397.9.camel@raven.themaw.net>
	<45FA996D.2080606@redhat.com>
	<1174055083.3397.11.camel@raven.themaw.net>
	<Pine.LNX.4.64.0703160904560.11089@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0703160904560.11089@simba.math.ucla.edu> (Jim
	Carter's message of "Fri, 16 Mar 2007 09:25:52 -0700 (PDT)")
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> On Fri, 16 Mar 2007 09:25:52 -0700 (PDT), Jim Carter <jimc@math.ucla.edu> said:

[snip]
Jim> I'm inclined to say that if it didn't, it should have, and we should do it 
Jim> "right" rather than carrying forward historical mistakes for the sake of 
Jim> being able to drop a Linux kernel and packages among Solaris configuration 
Jim> files and having it work out of the box (and having it NOT work out of the 
Jim> box when a man-page-following Linux sysop upgrades).  But I can see why 
Jim> Solaris sysadmins might think differently.  Certainly plus lines should not 
Jim> be rejected noisily as errors.  Better to just ignore them.

Clearly you don't work in mixed environments, or legacy environments
for that matter.  Support for included maps is non-negotiable.  Ian
has spent a great deal of time making sure that the Linux automounter
behaves identically to the automounters provided by Sun, HP, IBM, SGI,
etc.  There's a reason for that, and the reason is customers want it.

And, if that's not a good enough reason, by coding to the de facto
standard we also get a great regression test suite (connectathon) for
free.

-Jeff
