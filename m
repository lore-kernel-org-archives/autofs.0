From: Ian Kent <raven@themaw.net>
Subject: Re: two /net paths to the same local mount?
Date: Mon, 12 Jul 2010 10:53:47 +0800
Message-ID: <1278903227.2930.18.camel@localhost>
References: <4C1FBABF.5060207@oracle.com>
	<35D166B0274C8DB77A6BE435@[192.168.1.100]>
	<4C225338.8070008@oracle.com>
	<1277348429.2841.44.camel@localhost>  <4C2A1C03.1070908@oracle.com>
	<1277903577.2819.8.camel@localhost>  <4C2B5B4E.3010501@oracle.com>
	<1277950748.3137.2.camel@localhost>  <4C33CA03.2020904@oracle.com>
	<1278476554.5423.9.camel@localhost>  <4C379CD7.4070404@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=XFFQqCp/TBYsw6/aCDc4eH7wZ8g=;
	b=UxnapCqxpVLal3BrBCJQUydrkToKxLR3OPjgVgbuRnZ98W96zEYkux0FpgSZxfSn2SqUdnDTR9PlK1koqINaoJXLslh11v4RN5P95bsBRY4mKG85zY1ng9nXHYaRnuonwoEE2DuGJ+62zA/woeSd+SFCTaShHzyIHBpFctgftvk=
In-Reply-To: <4C379CD7.4070404@oracle.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Chris Quenelle <chris.quenelle@oracle.com>
Cc: autofs@linux.kernel.org, Frank Thommen <frank.thommen@embl.de>

On Fri, 2010-07-09 at 15:04 -0700, Chris Quenelle wrote:
> Ian Kent wrote:
> 
> > strace output is often not very useful.
> > 
> > If you think there is some sort of deadlock going on get a sysreq-t dump
> > to syslog. We still haven't seen a debug log?
> 
> I've had reports that my emails are being delayed when they go out to the list.
> If anyone is following along and you'd like me to add you to my cc:
> lines so you get the email directly, let me know, and I'll do that.

That's going to happen if you post to a subscribers only list without
subscribing to it.

> 
> I'm getting close to my limits of what this problem is worth to me.

And yet you haven't really provided the information requested?

I don't remember but did we get the distribution and autofs version your
using?

> I suspect the two broken paths will get unwedged if I reboot the system.
> But I'd love to know how to prevent it from happening again.
> 
> I saw these lines in /var/log/messages:
> 
> > >>>> Jun 29 09:04:46 carabas automount[11786]: Debug logging set for /net
> > >>>> Jun 29 09:09:22 carabas automount[11786]: get_pkt: message pending on control fifo.
> > >>>> Jun 29 09:09:22 carabas automount[11786]: Basic logging set for /net
> 
> Does that mean that all debugging output from automount should be
> going to that file?  Or could the debug output still be going someplace
> else (or into /dev/null?) In between the first line of that log output and
> the last line, I provoked a correctly functioning automount of
> a local file system, and I also tried to access the "broken" path
> to the local filesystem.

What file, I don't understand what you mean?

But you don't mention what you have done to tell syslog to actually send
"all" facility daemon messages to the syslog.

Try having a look at Jeffs page http://people.redhat.com/jmoyer for a
description debug logging setup.

> 
> So that in combination with strace/automount not giving any output
> when I access the broken path, makes me think the control path
> is not getting out of the kernel.

Maybe.

> 
> Can you point me to an explanation of what a "sysreq-t dump" is and
> how to get it?  I don't have access to the console of this machine,
> hopefully it's something I can do from a root term window.

Wherever your distribution's has kernel documentation (or a package that
contains the documentation) look at Documentation/sysrq.txt.

Often, you will find you can:

echo "t" > /proc/sysrq-trigger

to get a trace dump, which is what I'm asking for.

> 
> To summarize my problem, I have a test set of paths to access a local
> filesystem, 7 work and 2 don't.
> 
> /net/carabas/export/home1
> /net/carabas/export/home2    <-- fails
> /net/carabas/export/home3    <-- fails
> /net/carabas.sfbay/export/home1
> /net/carabas.sfbay/export/home2
> /net/carabas.sfbay/export/home3
> /net/carabas.sfbay.sun.com/export/home1
> /net/carabas.sfbay.sun.com/export/home2
> /net/carabas.sfbay.sun.com/export/home3
> 
> 
> I don't see anythign suspicious in the output of:
> showmount
> df
> /etc/host.conf
> strace automount
> automount -l debug /net
> 
> 
> 
> 
> --chris
