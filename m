From: Ian Kent <raven@themaw.net>
Subject: Re: PATCH - 2.6.6-bk3 autofs4 DPRINTK cleanup
Date: Mon, 17 May 2004 10:04:58 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405170954280.10453@wombat.indigo.net.au>
References: <1084753980.21164.6.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1084753980.21164.6.camel@localhost.localdomain>
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
To: Joe Perches <joe@perches.com>
Cc: autofs@linux.kernel.org, jeremy@goop.org


Hi Joe,

Why are you removing the function names from the printks?

Since I'm the one that receives the bug reports and works through them I 
think I have the say in what I need to make it easier for me.

The function names are an essential debuging aid for me, please put them 
back!

btw the code looks a bit out of date. So you're likely wasting you time as 
well.

If you would like to help with autofs4 then you can find the latest 
patches at http://www.kernel.org/pub/linux/daemons/autofs/v4.

Ian
