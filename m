From: Rob Horton <robh@dongle.org.uk>
Subject: Re: Autofs 4->5 with LDAP problems
Date: Sat, 23 Aug 2008 11:35:15 +0100
Message-ID: <20080823103515.GA19290@dongle.org.uk>
References: <20080822150940.GA13963@dongle.org.uk>
	<x49k5e93uoo.fsf@segfault.boston.devel.redhat.com>
	<20080822195950.GA14334@dongle.org.uk>
	<48AF9B0F.6000604@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <48AF9B0F.6000604@themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Thanks for the help debugging this.

The problem was that ou=auto.misc,dc=maths,dc=qmul,dc=ac,dc=uk (which I
forgot to quote in the original message) should have been an automountMap
instead of an organisationalUnit. The autofs version I was using seems
to just segfault at this point, whereas a newer one (I tried the CentOS
one) gave some useful output.

Thanks again,
Rob
