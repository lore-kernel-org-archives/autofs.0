From: Alvin Oga <alvin@Mail.Linux-Consulting.com>
Subject: Re: Repeated Meessages - sendmail - virtual
Date: Fri, 23 Jan 2004 23:58:27 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.3.96.1040123235652.19949A-100000@Maggie.Linux-Consulting.com>
References: <Pine.LNX.4.44.0401111724480.260-100000@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401111724480.260-100000@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


hi ya ian

On Sun, 11 Jan 2004, Ian Kent wrote:

> > if you have your own mail server ... use it .. instead of the isp..
> 
> But it's not exactly mine.
> 
> It's a co-located server funded by a friend of mine.
> We run a few domains so I have to be a little careful.

just add each virtual domain you want to support to
	/etc/mail/access

add your users  ian@virtual.com   and ian@virtual-two.com to 
	/etc/mail/virtusertable

http://www.Linux-Sec.net/Mail/Sendmail-Install-Howto

c ya
alvin
