From: Ian Kent <raven@themaw.net>
Subject: Re: expire_indirect errors in the syslog
Date: Fri, 07 Nov 2008 17:47:46 +0900
Message-ID: <1226047666.3093.125.camel@zeus.themaw.net>
References: <4906C365.8030209@s3group.cz>
	<1225181075.2938.97.camel@zeus.themaw.net>
	<4906CB2A.9010705@s3group.cz>
	<1225192753.2938.103.camel@zeus.themaw.net>
	<4912E18F.7010701@s3group.cz>
	<1226020830.3093.22.camel@zeus.themaw.net>
	<4913F159.5000002@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4913F159.5000002@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Fri, 2008-11-07 at 08:42 +0100, Ondrej Valousek wrote:
> Ian,
> 
> I guess I can not turn debugging on without restarting autofs, right?
> This is a production login box with many users logged in. My experience
> says restarting autofs would freeze the machine.

That can be a problem, I wouldn't.

But occasionally people report enabling debugging on heavily loaded
systems can cause them to behave badly. So, even though you can enable
debug logging on the fly (check the man page), I wouldn't do that
either.

But that also means that, if a problem has already happened, then
changing the server exports likely won't fix it either. But of course it
depends on the problem.

If your not having any specific problems, other than annoying log
messages, then leave the machine alone.

> Thanks,
> 
> Ondrej
> > This specific example should not result in those messages.
> > If you want further analysis of this issue then post a full debug log.
> >
> > Ian
> >
> >
> >   
> 
