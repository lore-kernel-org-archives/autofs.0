From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: nested automounts: bind and nfs
Date: Thu, 11 Oct 2007 12:49:24 +0200
Message-ID: <1192099764.18125.3.camel@localhost>
References: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1191300830.26331.24.camel@raven.themaw.net>
	<1191321007.27255.12.camel@localhost>
	<1191332917.26331.171.camel@raven.themaw.net>
	<1192025757.27076.31.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1192029316.3151.11.camel@raven.themaw.net>
	<1192030146.27076.46.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1192034852.3151.21.camel@raven.themaw.net>
	<1192035764.20253.5.camel@localhost>
	<1192092341.3114.38.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1192092341.3114.38.camel@raven.themaw.net>
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


Hi Ian!


> Congratulations Lucas you've managed to create an autofs map that the
> current autofs4 kernel module can't handle, well done.

D'Oh!

> I'll try to explain, but I can't be sure I'll be very clear.

I'm so sorry, I didn't mean to :)

It's just that I came into this situation where we're having
historically a Sun-based server (and client) park and are slowly and
(luckily) only partially switching to linux where it makes sense. The
system as you can imagine has grown over time (e.g. the last twenty-some
years IIRC, the oldest configuration file I touched was from 1994 I
think), and I now have to make linux fit into that ... I never would
have thought that Unix is _that_ much different from Unix. 

> Now the problem.

I *think* I understand what you describe there. If I were more
knowledgeable about the internals of Linux and autofs I could be of more
help :(

> The patch below should apply ok to most kernels you're using as there
> haven't been changes in this area for quite a while. It would be good if
> you could test this out and see if you observe any other side effects.

Looks fairly simple - shall I test it even with your warning in the
other mail?

> Ian

I really appreciate what you're doing, Ian. This is tough stuff and to
me it looks very scary.

-- 
Lukas
