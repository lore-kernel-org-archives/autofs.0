From: Ian Kent <raven@themaw.net>
Subject: Re: More autofs problems
Date: Mon, 30 Jun 2008 22:41:28 +0800
Message-ID: <1214836889.3008.45.camel@raven.themaw.net>
References: <4868946B.7050801@aei.mpg.de>
	<1214815665.3008.11.camel@raven.themaw.net>
	<4868B0BA.9040208@aei.mpg.de>
	<1214822142.3008.18.camel@raven.themaw.net>
	<4868DD3C.5020706@aei.mpg.de>
	<1214832384.3008.27.camel@raven.themaw.net>
	<4868EA97.4000103@aei.mpg.de>
	<1214835616.3008.35.camel@raven.themaw.net>
	<4868EE71.7070607@aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4868EE71.7070607@aei.mpg.de>
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
To: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Cc: autofs@linux.kernel.org


On Mon, 2008-06-30 at 16:32 +0200, Carsten Aulbert wrote:
> 
> Ian Kent wrote:
> 
> > Encouraging the Debian folks to qa version 5 would be probably the best
> > thing you could do for everyone.
> 
> It's already in Debian, but only for the next stable version aka lenny:
> 
> http://packages.debian.org/search?keywords=autofs5&searchon=names&suite=all&section=all
> 
> So, I don't know how much effort it would be to backport them to glibc
> 2.3 instead of 2.7 and so on...

Should be OK, as long as the pthreads library is stable (mmm ... when
did nptl make it into glibc?) and you're running a recent (perhaps
patched) kernel.

> 
> Might be worth a try, if you say it's stable enough ;)

Yeah, it's always hard to say "it's stable enough" because all I see
most of the time are bug reports and there are still a some annoying
problems. But a lot of work has gone into v5 and reports are quite
positive. As well, bug fixes and enhancements tend to introduce new and
interesting bugs so it's an ongoing effort.

But then it's been included in RHEL-5 from initial release and it's
holding up fine.

Ian
