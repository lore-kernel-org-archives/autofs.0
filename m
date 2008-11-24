From: Bill Shannon <bill.shannon@sun.com>
Subject: Re: Ubuntu NFS automount problem
Date: Mon, 24 Nov 2008 12:31:00 -0800
Message-ID: <492B0F04.1080104@sun.com>
References: <4928BFA4.2090805@sun.com>
	<1227499728.2913.0.camel@zeus.themaw.net>
	<492A56E6.1070603@sun.com>
	<1227531120.2913.9.camel@zeus.themaw.net>
	<492ACFB9.7060201@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <492ACFB9.7060201@redhat.com>
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
To: Peter Staubach <staubach@redhat.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Peter Staubach wrote:
> Bill, why aren't you using the -hosts map?

That's a good question...

I don't remember how I got to this point, but ...

I just tried using -hosts, but it doesn't seem to be working:

vostro# cat /etc/auto.master
# $Id: auto.master,v 1.2 1997/10/06 21:52:03 hpa Exp $
# Sample auto.master file
# Format of this file:
# mountpoint map options
# For details of the format look at autofs(8).
# /misc	/etc/auto.misc	--timeout=60
/home	/etc/auto.home	-nosuid
#/net	/etc/auto.net	-nosuid
/net	-hosts		-nosuid
#/-	/etc/auto.direct	-nosuid
vostro# /etc/init.d/autofs reload
Reloading automounter: checking for changes ...
Reloading automounter map for: /home
Stopping automounter for: /smb
vostro# ls /net/nissan
ls: cannot access /net/nissan: No such file or directory
vostro# /etc/init.d/autofs restart
Stopping automounter:
   Couldn't stop automount for /home done.
Starting automounter:
  failed to start automount point /home
  done.
vostro# /etc/init.d/autofs reload
Reloading automounter: checking for changes ...
Reloading automounter map for: /home
vostro# ls /net/nissan
ls: cannot access /net/nissan: No such file or directory
vostro# grep nissan /etc/hosts
192.168.1.2	nissan

I think that's the reason I ended up with an auto.net map,
although it now seems likely that it never worked as intended.

I started chasing this problem because my auto.home map wasn't
working, which I now understand is the expected behavior based
on the way I'm now exporting my /export/home filesystems.  My
mistake.

I just fixed my auto.home map using multimounts.

Still, any hints as to why the -hosts pseudo-map isn't working
would be appreciated.  Are you sure it's *supposed* to work?
It's not documented in the man page.

I think this is the version of autofs I have:

vostro# dpkg-query -l 'autofs*'
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Installed/Config-f/Unpacked/Failed-cfg/Half-inst/t-aWait/T-pend
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: uppercase=bad)
||/ Name           Version        Description
+++-==============-==============-============================================
ii  autofs         4.1.4+debian-2 kernel-based automounter for Linux

Is there an "autofs5" package I should install instead?

Thanks for your help!
