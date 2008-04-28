From: Ian Kent <raven@themaw.net>
Subject: Re: include a master file: where does the automounter look
Date: Mon, 28 Apr 2008 16:53:52 +0800
Message-ID: <1209372832.3243.23.camel@raven.themaw.net>
References: <48158BB4.3050008@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48158BB4.3050008@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org


On Mon, 2008-04-28 at 10:32 +0200, Stef Bon wrote:
> Hello,
> 
> when I read the manpage for auto.master (and other docs) I see that I 
> can include another master file by doing:
> 
> +auto.master
> 
> The comment says that by doing so, the you can specify a master map 
> which is found using
> nsswitch sources.
> What happens then? Where does it look then?

If you have a line in /etc/nsswitch.conf like:

automount: files nis

it will look in /etc for auto.master (files) and try to connect to a nis
server and ask for auto.master.

So, it depends on the source specified in /etc/nsswitch.conf.

> 
> When I add a line with an auto.master file with full path:
> 
> +/var/run/autofs/auto.master
> 
> it works also.

That's right.
This just prevents autofs from consulting /etc/nsswitch.conf because it
doesn't need to.

Ian
