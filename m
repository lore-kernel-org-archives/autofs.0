From: Ian Kent <raven@themaw.net>
Subject: Re: auto.net
Date: Fri, 23 Jan 2004 08:36:15 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0401230829010.30814-100000@wombat.indigo.net.au>
References: <B94D9EFEABBFD745A8BCFC0F658E3D740390C427@sussfe01.sikorsky.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <B94D9EFEABBFD745A8BCFC0F658E3D740390C427@sussfe01.sikorsky.com>
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
To: "Myers, Parrish" <PMyers@SIKORSKY.COM>
Cc: autofs@linux.kernel.org

On Thu, 22 Jan 2004, Myers, Parrish wrote:

> Hello,
>
> I was wondering if I could get some help?  I am kinda new to the autofs
> thing... I think this is a simple question: Is there a simple way to tell if
> I have autofs4 built into my linux kernel?  And, if it isn't, does this
> still affect the use of auto.net (which is a replacement for the '-host'
> flag in the sgi verison)? I am having problems with getting auto.net to
> work. Everything in the setup seems to say it sould work: it does everyting
> but actually mound the directories.
>

There is a lot of usefull information in Forests' post but it's
possible that it's comiled in.

You are obviously using an autofs version 4, but which one.

I think that all the v4 daemons issue a message identifing the kernel
autofs version at startup.

For autofs            says version 3
    autofs4 standard  says version 4
    autofs4 updated   should say 4.04 (anything lower should be
                      updated).

Ian
