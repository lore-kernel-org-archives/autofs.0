From: Ian Kent <raven@themaw.net>
Subject: Re: top level mount point
Date: Tue, 11 Sep 2007 17:27:44 +0800
Message-ID: <1189502864.3585.10.camel@raven.themaw.net>
References: <10badf220709110016w454badfdt31a82bf6142171cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <10badf220709110016w454badfdt31a82bf6142171cc@mail.gmail.com>
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
To: Shane <squindler@gmail.com>
Cc: autofs@linux.kernel.org

On Tue, 2007-09-11 at 16:46 +0930, Shane wrote:
> Hey All,
> 
> I'm trying to get a "top-level" automount to work.  eg
> 
> /home  -rw,vers=3,fstype=nfs,intr,hard,tcp,rsize=32768,wsize=32768
> srv1:/export/home/
> 
> I've tried a few things so far - putting that exactly as is into
> /etc/auto.master, created an auto.direct file and put /- auto.direct
> into auto.master neither any joy - also tried /home  auto.home in
> auto.master and above but with * or / as the key as contents of
> auto.home none are working.

Not valid in auto.master.

An indirect map must have keys that are a directory component only, that
is no "/"s.

So, in auto.master you can have:

/home	auto.home

and auto.home as:

*	srv1:/export/home/&

to mount /home/myname as srv1:/export/home/myname

You could leave out the "&" but I'm not sure that would be useful.

> 
> Firstly is this actually possible?  Though I have no idea how Apple
> translate our maps into something automount uses they do get around
> this but /home is a symlink to somewhere like
> /private/var/automount/home. If its possible ...what have I missed to
> get this working?

No, not possible with version 4.

Single level indirect maps aren't possible by definition.

Single level direct maps are possible with version 5.

So, in auto.master you could have:

/-	auto.home

and auto.home:

/home	svr1:/export/home
/other/dir	other:/export/other

and the like.

Ian
