From: Chris Feist <cfeist@redhat.com>
Subject: Re: [patch] Maintain backwards compatibility w/ local file maps
	w/o etc.
Date: Thu, 21 Oct 2004 10:28:43 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1098372523.9364.17.camel@gold.msp.redhat.com>
References: <1098291410.3527.18.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0410211040430.4454@wombat.indigo.net.au>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410211040430.4454@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


> But this is a file map not a program map?

Yes, in the past (3.1.7 & 4.0.0) autofs would check for entries in the
/etc/ directory even if it wasn't included in the auto.master file.

So, the following two files used to do the same thing:

File A:
/home /etc/auto.home

File B:
/home auto.home

So when people upgrade from 3.1.7 or 4.0.0 to 4.1.3 their maps end up
breaking.

Thanks,
Chris
