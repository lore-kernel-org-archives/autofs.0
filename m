From: Chris Fanning <christopher.fanning@gmail.com>
Subject: Re: autofs and terminal networks woes.
Date: Tue, 8 Mar 2005 12:36:26 +0100
Message-ID: <215ff4410503080336477daa92@mail.gmail.com>
References: <215ff441050217023378003e72@mail.gmail.com>
	<Pine.LNX.4.61.0502172136030.1683@donald.themaw.net>
	<215ff441050217060647db41dc@mail.gmail.com>
	<Pine.LNX.4.61.0502172203440.1683@donald.themaw.net>
	<215ff441050217071517292c1a@mail.gmail.com>
	<4214C1D3.8080107@loran.name>
	<215ff44105022011381b2deee7@mail.gmail.com>
	<Pine.LNX.4.58.0502211236290.9892@wombat.indigo.net.au>
Reply-To: Chris Fanning <christopher.fanning@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.58.0502211236290.9892@wombat.indigo.net.au>
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
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, Jonathan Loran <jonathan@loran.name>

Hi,

well, though observation, it seems the problem I stated before of the
mounts not unmounting is because Nautilus keeps it in sort of cache or
something and the mount remains busy.

anyway, to refresh..
I have a terminal network environment.
All users run their session on the central terminal server. Each pc,
where the users sits, is running X. Problems start when the
user wants to access the floppy because /mnt/floppy is the floppy
drive on the server, when in reality, the user is not phisically at
the server.

ok. since then I've got this working
/terminals/terminal_ip/fd
/terminals/terminal_ip/cd
great!

Now I have another doubt.
I can't expect the users to know the path to the floppy because, for
example, they don't even know their ip.
So I make a link from the users home to their terminals floppy. eg.
ln -s /terminals/terminal_ip/fd /home/a_user/Floppy

But this causes the drive to mount. Bad.

Is there anyway to point to the floppy but delay the mount until the
user really wants it?

Thanks again.
Chris.

On Mon, 21 Feb 2005 12:39:37 +0800 (WST), Ian Kent <raven@themaw.net> wrote:
> On Sun, 20 Feb 2005, Chris Fanning wrote:
> 
> > No Jon, you're not missing anything.
> > I've simply started using smb because the pxes client I've been
> > testing with has a nice check box to include a smb server in the
> > image.
> > You are probably right and nfs is the way to go.
> >
> > By the way, since I've upgraded, autofs doesn't seem to unmount the
> > drives (I can hear the diskette spinning every 8 seconds or so), even
> > with the timeout set.
> >
> > How should I test that to see if it really is a bug?
> 
> Mostly I use the --debug option on the master map entry.
> Then forward the log and I'll see if there's anything amiss.
> 
> What about your autofs4 kernel module?
> 
> >
> > Chris.
> >
> >
> > On Thu, 17 Feb 2005 08:09:55 -0800, Jonathan Loran <jonathan@loran.name> wrote:
> > >
> > >  Chris, Ian,
> > >
> > >  I don't chime in here very often, and I know this is now more or less
> > > working, but the obvious question to me is, since both the thin client and
> > > server are running Linux/Unix, why not use the more native NFS?  Perhaps I'm
> > > missing something obvious.
> > >
> > >  Jon
> > >
> > >  Chris Fanning wrote:
> > >  ok. downloaded, compiled and installed. This works great! Thankyou. Chris.
> > > On Thu, 17 Feb 2005 22:10:58 +0800 (WST), raven@themaw.net
> > > <raven@themaw.net> wrote:
> > >  On Thu, 17 Feb 2005, Chris Fanning wrote:
> > >  Hi Ian,
> > >  Versions? 4.1.3-9
> > >  Perhaps you need to use ://thinclient_ip/fd So, do you suggest I upgrade?
> > > Only if you can solve the problems you face. Certainly not without plenty of
> > > testing.
> > >  When might 4.1.4 be available for debian testing? I guess that will depend
> > > on the Debian folks. I'm hoping they will push 4.1.4 into the Debian tree
> > > fairly soon after it is released. I've tried to get as many fixes into the
> > > new version as I could.
> > >  Should I download the source instead? If you wish to test this out you can
> > > download autofs-4.1.4_beta2-deb.tar.gz which basically contains the files of
> > > a source deb. As i've said before, this is for testing only as I'm not the
> > > maintainer of the Debian package. If you do try this make sure you stop
> > > autofs before installing the deb. Ian
> > > _______________________________________________ autofs mailing list
> > > autofs@linux.kernel.org http://linux.kernel.org/mailman/listinfo/autofs
> > > _______________________________________________
> > > autofs mailing list
> > > autofs@linux.kernel.org
> > > http://linux.kernel.org/mailman/listinfo/autofs
> > >
> > >
> > >
> >
> > _______________________________________________
> > autofs mailing list
> > autofs@linux.kernel.org
> > http://linux.kernel.org/mailman/listinfo/autofs
> >
> 
>
