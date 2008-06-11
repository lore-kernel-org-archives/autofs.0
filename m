From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: automount reload
Date: Wed, 11 Jun 2008 11:04:54 +0200
Message-ID: <1213175094.11668.2.camel@eldorado>
References: <484F6BAA.2050703@infomaniak.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <484F6BAA.2050703@infomaniak.ch>
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
To: cedric briner <work@infomaniak.ch>
Cc: autofs <autofs@linux.kernel.org>

Hello Cedric,

> # dpkg -l autofs
> ii  autofs                                4.1.4+debian-2.1ubuntu1 
>         kernel-based automounter for Linux

That problem was one of the reasons we took the effort to backport
current (autofs5-5.0.2) versions of autofs to our debian and ubuntu
installations. I can't think of any reason why ubuntu doesn't ship
versopn 5 anymore, but heck ... 

A simple autofs reload would work if you would be using autofs5. But if
you decide to do so, please test extensively beforehand (you'll never
know). For us, it works quite well.

> I thought, I'll do in this order:
> ask joe to log out
> rsync hostA:/export/joe to hostB:/export/joe
> on hostB: exportfs of hostB:/export/joe
> 
> in nis: auto_home, I move joe hostA:/export/joe to
>                                hostB:/export/joe

That's exactly how it's supposed to work.

> on hostW: /etc/init.d/autofs reload

Autofs4 is ... <insert non politically correct swearword here>. Thanks
to Ian and Jeff for their good work on autofs5!

> but it is not working.

-- 
Lukas
