From: Dannie Stanley <dannie.stanley@gmail.com>
Subject: Re: Re: autofs timeout and large map
Date: Tue, 1 Nov 2005 20:40:22 -0500
Message-ID: <89e9feae0511011740s5d52af1bh45969b6de2ba9081@mail.gmail.com>
References: <20051028163028.75072c9b.akpm@osdl.org>
	<Pine.LNX.4.63.0510291032450.2075@donald.themaw.net>
	<89e9feae0510310904u389dc003mc311a1f0a1058168@mail.gmail.com>
	<Pine.LNX.4.63.0511012358320.3040@donald.themaw.net>
	<17255.42731.371939.845427@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0511020912090.6481@wombat.indigo.net.au>
	<Pine.LNX.4.58.0511020922260.6481@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0511020922260.6481@wombat.indigo.net.au>
Content-Disposition: inline
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian:

My auto.virtual file looks like this without the line breaks:


  /virtual/USERNAME \
     /public --bind 127.0.0.1:/usr/local/files/public \
     /private --bind 127.0.0.1:/usr/local/files/USERNAME

-- Dannie


On 11/1/05, Ian Kent <raven@themaw.net> wrote:
> On Wed, 2 Nov 2005, Ian Kent wrote:
>
> > On Tue, 1 Nov 2005, Jeff Moyer wrote:
> >
> > > This is quite easy to reproduce.  Basically, after the expire event,
> > > accesses to the /virtual/USERNAME directory do not trigger callouts to the
> > > daemon.  Here is the expiry message from the logs:
> >
> > OK. I'll have a go at reproducing it.
> >
> > I don't have the exact versions but hopefully the problem will be evident
> > in other versions as well.
> >
> > Would it be possible for you the put the source rpm into your people area
> > please.
> >
> > >
> > > automount[2495]: sigchld: exp 2513 finished, switching from 2 to 1
> > > automount[2495]: get_pkt: state 2, next 1
> > > automount[2495]: st_ready(): state = 2
> > > automount[2495]: sig 14 switching from 1 to 2
> > > automount[2495]: get_pkt: state 1, next 2
> > > automount[2495]: st_expire(): state = 1
> > > automount[2495]: expire_proc: exp_proc=2515
> > > automount[2495]: handle_packet: type = 2
> > > automount[2495]: handle_packet_expire_multi: token 22, name jmoyer/private
> > > automount[2516]: expiring path /virtual/jmoyer/private
> > > automount[2516]: umount_multi: path=/virtual/jmoyer/private incl=1
> > > automount[2516]: umount_multi: unmounting dir=/virtual/jmoyer/private
> > > automount[2516]: expired /virtual/jmoyer/private
> > > automount[2495]: handle_child: got pid 2516, sig 0 (0), stat 0
> > > automount[2495]: sig_child: found pending iop pid 2516: signalled 0 (sig 0), exit status 0
> > > automount[2495]: send_ready: token=22
> > > automount[2495]: handle_packet: type = 2
> > > automount[2495]: handle_packet_expire_multi: token 23, name jmoyer/public
> > > automount[2518]: expiring path /virtual/jmoyer/public
> > > automount[2518]: umount_multi: path=/virtual/jmoyer/public incl=1
> > > automount[2518]: umount_multi: unmounting dir=/virtual/jmoyer/public
> > > automount[2518]: expired /virtual/jmoyer/public
> > > automount[2495]: handle_child: got pid 2518, sig 0 (0), stat 0
> > > automount[2495]: sig_child: found pending iop pid 2518: signalled 0 (sig 0), exit status 0
> > > automount[2495]: send_ready: token=23
> > > automount[2495]: handle_child: got pid 2515, sig 0 (0), stat 0
> > > automount[2495]: sigchld: exp 2515 finished, switching from 2 to 1
> > >
> > > What you are left with is a directory hierarchy that looks like this:
> > >
> > > /virtual
> > >         /jmoyer
> > >                /private
> > >                /public
> > >
> > > Clearly the private and public directories should be gone!  As mentioned,
> > > an ls -l in the /virtual/jmoyer directory will look like so:
> > >
> > > # ls -l /virtual/jmoyer/
> > > total 0
> > > dr-xr-xr-x    2 root     root            0 Nov  1 07:16 private
> > > dr-xr-xr-x    2 root     root            0 Nov  1 07:16 public
> >
> > If the --ghost option is used these directories should be creted when the
> > map is first loaded and remain.
>
> Sorry, this is a multi-mount entry isn't it.
>
> Then of course you are right Jeff.
>
> Dannie can you confirm that your map looks like:
>
> /virtual/<user>  /private <mount> /public <mount>
>
> Ian
>


--
Dannie M. Stanley

"The Feynman Problem-Solving Algorithm: (1) write down the problem;
(2) think very hard; (3) write down the answer." - Murray Gell-Mann
