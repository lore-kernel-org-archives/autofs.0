From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Problems with automounts dying
Date: Mon, 27 Mar 2006 12:30:37 -0500
Message-ID: <17448.8509.948460.939698@segfault.boston.redhat.com>
References: <20060326140544.GA5749@uio.no>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060326140544.GA5749@uio.no>
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
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] Problems with automounts dying; "Steinar H. Gunderson" <sgunderson@bigfoot.com> adds:

sgunderson> Hi, Lately I've been receiving multiple bug reports about
sgunderson> autofs starting to forget mountpoints, for instance:

sgunderson>   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=349073

sgunderson> Does anybody else experience this? I can't reproduce it myself,
sgunderson> but it sounds very much real :-) Any ideas?

From the bug:

 For many months now, automount forgets mountpoints shortly after using
 them for the first time.
 ...

 During the first cd, automount might log something like the following:
   Jan 20 21:07:21 cerebro automount[17613]: failed to mount /fs/doom_localvol4

This sounds like the kernel is caching a negative dentry indefinitely.  Ian
fixed this a while back.

Note that this looks to be the side-effect of another problem, though.  Can
you get debug logs for this?  Ideally, you'd gather everything requested in
the "Filing bug reports" section of the following web page:

    http://people.redhat.com/jmoyer/

I hope this helps.

-Jeff
