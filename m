From: Vincent McIntyre <vincent.mcintyre@csiro.au>
Subject: Re: expected behaviour for replicated servers
Date: Fri, 16 Jun 2017 08:25:14 +1000
Message-ID: <20170615222513.GA18515@mayhem.atnf.CSIRO.AU>
References: <20170615021949.GM10434@mayhem.atnf.CSIRO.AU>
 <1497520371.2650.1.camel@themaw.net>
 <1497523500.2650.3.camel@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=dkim;
  t=1497565522; x=1529101522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=W7cdNuGArPt8qfoZmpvnn9pjZRLB0QKYbQ/aPiJHA70=;
  b=j6Uec0AJmAOVsf4M5l8qaszW33rXFdkrI3jTQVYHHOxoHsWP/HiuEd9s
   JOcDEPWgAe51vvzwy3ITpCtucSldfz5Q/3k77MDDciUeA8c53JFJBi5ZN
   VUVzdnxCK8dD+5dHTXiGKUkZlnloZkKPVgbeI/qqmmpsuc3hDt3j6+uNc
   M=;
Content-Disposition: inline
In-Reply-To: <1497523500.2650.3.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Thanks for your reply

On Thu, Jun 15, 2017 at 06:45:00PM +0800, Ian Kent wrote:
> On Thu, 2017-06-15 at 17:52 +0800, Ian Kent wrote:
> > On Thu, 2017-06-15 at 12:19 +1000, Vincent McIntyre wrote:
> > > Hello
> > >=20
> > > I can't see this in the manpages or README.replicated-server,
> > > perhaps I can provide a patch...
> > >=20
> > > I have this setup:
> > >=20
> > > $ grep autofs /etc/nsswitch.conf
> > > autofs: files nis
> > >=20
> > > $ cat /etc/auto.master
> > > /nfs=A0=A0auto.nfs=A0=A0-rw,hard,intr,vers=3D3
> > > $ ypcat -k auto.nfs
> > > foo=A0=A0-ro,hard=A0=A0boxa,boxb:/export/foo
> > >=20
> > >=20
> > > Question:
> > >=20
> > > If boxa has the NFS server running (so autofs ping works)
> > > but does not export /export/foo,
> > > what is the expected behaviour?
> >=20
> > I haven't looked, so just I'll say what I think should happen.
> >=20
> > >=20
> > > boxa and boxb are in different subnets, the client is in
> > > the same subnet as boxa.
> >=20
> > If the network proximity code is working properly boxb probably
> > won't make it to the list of servers to try because it should
> > look like it's further away.

That makes some kind of sense, but see below.

> >=20
> > >=20
> > > What I am seeing is that the automount fails completely
> > > upon trying boxa. boxb is never tried (no request logged on boxb).
> > > Looking at the autofs debug log, I can see
> > > get_nfs_info called for boxa, twice in fact.
> > > For boxb, only get_supported_ver_and_cost is called,
> > > after which the daemon tries to mount the share from boxa.
> >=20
> > That's likely expected as I'm pretty sure I construct the list
> > of servers that have the selected characteristics including
> > proximity.
> >=20
> > For proximity it will check network address against local
> > interfaces to work that out so you probably shouldn't see an NFS
> > ping at all as that's used to establish best response amongst
> > the list of selected servers.
> >=20
> > I'd need to have a look at the code.
> >=20
> > >=20
> > >=20
> > > What I was hoping to see is that the client also tries boxb
> > > before giving up.
> > >=20
> > > I tried fiddling with:
> > > =A0the order (boxb,boxa:/export/foo)
> > > =A0weights (boxb(3),boxa:/export/foo),
> > > but none of this made any difference.
> >=20
> > If I'm right then boxb won't get onto the list of servers to try
> > so there's probably not much you can do about it, (again if I am
> > right) possibly it should change to include the further away
> > servers .... that might not be a straight forward change ...
>=20
> Actually it looks more like boxb should be added to the end of the
> list of servers to try.
>=20
> I see a bug in there but I don't think it's triggering.  It's more
> likely there's been a problem connecting to boxb for some reason.
>=20
> The debug log might be useful but I'd probably still need to add
> some more debug log messages to work out what's going on.
>=20

Connection to boxb was working fine, I did a manual mount to check.

I was able to get the behaviour I wanted by adding --use-weight-only
(ie -w in auto.master) and not specifying any weights in auto.nfs.

Is it correct to say that --use-weight-only turns off all the
proximity heuristics ? I think not because autofs.master says

  ...If no server  weights are given then each available server
  will be tried in the order listed, within proximity.

But that manpage never mentions proximity anywhere else, so perhaps
it would be helpful to refer the reader to "the package's README files" ?

Going back over README.replicated-servers, it does not say anything
that suggests hosts are _left out_ of the priority-ordered list. So
perhaps there is a little buglet in there somewhere.

Vince
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
