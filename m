From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs 4.1.4 regression?
Date: Mon, 9 May 2005 17:55:21 -0400
Message-ID: <17023.56393.15007.106702@segfault.boston.redhat.com>
References: <427FD65F.2050708@rosengren.org>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <427FD65F.2050708@rosengren.org>
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
To: Jeremy Rosengren <jeremy@rosengren.org>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] autofs 4.1.4 regression?; Jeremy Rosengren <jeremy@rosengren.org> adds:

jeremy> I previously worked with Ian to troubleshoot and resolve some
jeremy> problems that I was seeing with autofs 4.1.3's replicated server
jeremy> code.  Everything had been working swimmingly with Fedora Core 3's
jeremy> autofs 4.1.3-114 package.

jeremy> I'm testing Fedora Core 4, and am seeing problems with replicated
jeremy> host maps and autofs 4.1.4-5.

There is a regression, but it's in the Red Hat package.  I've got a fix for
it.  Please try 4.1.4-8 from my people page:
  http://people.redhat.com/~jmoyer/autofs/fc4/

I'll push this to rawhide once that's enabled again.  Sorry for the
inconvenience.  Oh, and definitely let me know whether or not this fixes
your problem.

Thanks,

Jeff
