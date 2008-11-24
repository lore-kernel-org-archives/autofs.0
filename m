From: Bill Shannon <bill.shannon@sun.com>
Subject: Re: Ubuntu NFS automount problem
Date: Mon, 24 Nov 2008 12:35:34 -0800
Message-ID: <492B1016.8070508@sun.com>
References: <4928BFA4.2090805@sun.com>
	<1227499728.2913.0.camel@zeus.themaw.net>
	<492A56E6.1070603@sun.com> <492ACF74.6000703@sun.com>
	<1227548632.2913.33.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1227548632.2913.33.camel@zeus.themaw.net>
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

Ian Kent wrote:
>> I just tried that on Linux with autofs and it doesn't seem to work.
>> Is there a Linux equivalent for the "-hosts" pseudo-map on Solaris?
> 
> Yes, with autofs version 4 use "/net /etc/auto.net" in the master map
> which generally should work the way you expect. The internal hosts map
> is available in autofs version 5, which I suspect may be called autofs5
> in ubuntu.

Ah ha!

For reasons I no longer remember, I replaced the standard Ubuntu
/etc/auto.net with my (stupidly wrong) version some time ago.
I just rediscovered the original Ubuntu version and it seems to be
working fine.

Thanks for your help, and sorry for the stupid questions...
