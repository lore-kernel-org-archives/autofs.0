From: Ian Kent <raven@themaw.net>
Subject: Re: Large number of mount request.
Date: Mon, 10 Jul 2006 13:41:54 +0800
Message-ID: <1152510114.2896.13.camel@raven.themaw.net>
References: <20060708055304.30906.qmail@web56008.mail.re3.yahoo.com>
	<010301c6a3c1$ce6837f0$251a17ac@ZyXEL.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <010301c6a3c1$ce6837f0$251a17ac@ZyXEL.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Latrell <is85022@cis.nctu.edu.tw>
Cc: autofs@linux.kernel.org, ramana@intraperson.com

On Mon, 2006-07-10 at 09:40 +0800, Latrell wrote:
> Hi, All:
> 
> I use autofs to mount shares of users under home directory with. Each user 
> login, a map file will be created and an automount daemon will be invoked 
> with options pid-file, ghost, timeout and file.
> When user logout, I need the automount daemon killed. Thus, I send SIGTERM 
> to the automount daemon. It's probably there are several automount daemons 
> existing in the same time.
> I found a case if many users logout at the same time, many SIGTERMs will be 
> sent to corresponding automount daemons. In such cirsumstance, some 
> automount daemons will not be killed and will exist in system forever. Thus 
> I check the pid under /proc and send SIGTERM again when the automonut daemon 
> not killed.
> 
> Did I use autofs in the wrong way?

Think so.
It sounds like you should have one autofs daemon instance managing the
mountpoint and let it mount and umount as needed.

You won't be able to do it this way with autofs version 5 if you upgrade
at some point.

> Ms stress test is to keep login(invoke automount), mount(cd share1),access, 
> logout(umount, kill automount) for 4 users sessions.
> 
> Many thanks,
> Latrell.
> 
> ps. I patched the lock patch, and the condition not changed.

Yes. Those signals will mess things up.

> 
> ----- Original Message ----- 
> From: "ramana" <intraperson@yahoo.com>
> To: "Ian Kent" <raven@themaw.net>; "Latrell" <is85022@cis.nctu.edu.tw>; 
> "Jeff Moyer" <jmoyer@redhat.com>
> Cc: <autofs@linux.kernel.org>
> Sent: Saturday, July 08, 2006 1:53 PM
> Subject: Re: [autofs] Large number of mount request.
> 
> 
> >
> >
> > --- Ian Kent <raven@themaw.net> wrote:
> >
> >>
> >> I think Jeff has pretty much summed it up.
> >>
> >> The SIGTERM terminates autofs and you then have unnecessary startup
> >> and
> >> shutdown overhead giving a window where mounts will not work as there
> >> is
> >> no daemon to manage them.
> >>
> >> Don't forget that there was also a bug in the lock routines that
> >> cause
> >> it not to wait sometimes. Apply, at least the locking patch to 4.1.4.
> >
> > I do not think so.
> >
> > His explanation about what actually he is doing is not very clear.
> >
> > Little more explanation on how he is doing strss test would help,
> > 'rather than trying to include his own conclusions'
> >
> > Thanks in advance.
> >
> > Regards
> > ramana
> >
> > --
> >
> > Autodir
> >
> > __________________________________________________
> > Do You Yahoo!?
> > Tired of spam?  Yahoo! Mail has the best spam protection around
> > http://mail.yahoo.com
> > 
