From: Shane <squindler@gmail.com>
Subject: Re: improving error reporting
Date: Tue, 11 Sep 2007 09:58:13 +0930
Message-ID: <10badf220709101728y3bfc5e3as6799bbeaa84e56d3@mail.gmail.com>
References: <10badf220709100011w4c43daf1ha48f1a38de6940d2@mail.gmail.com>
	<1189433659.3175.24.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1189433659.3175.24.camel@raven.themaw.net>
Content-Disposition: inline
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

On 10/09/2007, Ian Kent <raven@themaw.net> wrote:
> On Mon, 2007-09-10 at 16:41 +0930, Shane wrote:
> > Hey All,
> >
> > Does anyone know of a way I could get automount to help me report
> > which app has requested a bad / non-existant mount?
> >
> > Eg current error of:
> > Sep 10 11:26:14 box automount[21101]: >> mount:
> > srv1:/export/home/.hidden failed, reason given by server: No such file
> > or directory
> > Sep 10 11:26:14 box automount[21101]: mount(nfs): nfs: mount failure
> > srv1:/export/home/.hidden on /home/.hidden
> > Sep 10 11:26:14 box automount[21101]: failed to mount /home/.hidden
> >
> > this is kinda annoying to track back as either this error causes a
> > flood of requests to mount preventing other mounts so people reboot
> > workstations and we can't track the issue or the offending app gets
> > killed before we're on the scene too. ... I realise this isn't exactly
> > autofs's scope as the request comes not from the app directly, but
> > automount is the first point of failure so hopefully theres a way to
> > do this without causing too much overhead.
>
> The only way is enable debug logging but you only want to do that on a
> couple of machines.
>
> If your using autofs version 4 there isn't any way to record the pid of
> the requesting process because it isn't sent from the kernel. So you
> stuck.
>
> Version 5 will log the pid of the requesting process in syslog provided
> you are sending daemon.* somewhere. Be sure to check your syslog
> configuration and the output in syslog to ensure your getting autofs
> debug logging. Be warned there will be quite a bit of output.
>
> Why do you think autofs preventing other mounts?
> What distribution is this?
> What version of autofs?
> What kernel version?
>
> Ian
>

Thanks Ian - foiled by running an old distro I be. We're running
Fedora Core 3 (Kernel 2.6.20.4, autofs 4.1.4-33) still, though Anthony
recently "back-ported" AutoFS 5 so that will be good to look into for
this purpose once its stable and rolled out.

re autofs preventing other mounts - I don't actually think this is
autofs at all its just autofs is the only app reporting the error.
We've got at least one app which seems to be insanely insistent on
trying to access certain files ( /home/desktop.ini, /home/.hidden,
/home/system.ini etc) to the point where we'll see upto a thousand
failed mount attempts per second in the logs - when this happens other
automounts not already mounted fail to get mounted as it appears the
service / daemon is overwhelmed. Is it possible for autofs to limit
the number of attempts to a mount-point which has failed within a
second? ie a delay between attempts so that other processes can get
through. As I believe its the calling app making the thousands of
requests I'm not sure autofs is going to be able to do anything about
curbing the number of failed mount attempts ...
