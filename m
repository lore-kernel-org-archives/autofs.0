From: Ian Kent <raven@themaw.net>
Subject: Re: using both nfs3 and nfs4 in a single mount map
Date: Mon, 13 Aug 2007 11:22:47 +0800
Message-ID: <1186975367.14076.12.camel@raven.themaw.net>
References: <1185549849.22250.35.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1185550740.3203.80.camel@raven.themaw.net>
	<1185551130.22250.41.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1185606915.8326.22.camel@raven.themaw.net>
	<1185607363.8326.25.camel@raven.themaw.net>
	<1185802596.22250.52.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1185807243.3210.26.camel@raven.themaw.net>
	<1185974022.22250.64.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1186110967.3219.3.camel@raven.themaw.net>
	<x49myx8d3ng.fsf@segfault.boston.devel.redhat.com>
	<1186752313.22250.104.camel@sangay.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1186752313.22250.104.camel@sangay.TechFak.Uni-Bielefeld.DE>
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
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org

On Fri, 2007-08-10 at 15:25 +0200, Lukas Kolbe wrote:
> Hi!
> 
> 
> > >> > /homes  multi yp auto_homes -fstype=nfs4,nosuid,grpid,nobrowse,proto=tcp,port=2049 -- \
> > >> > 		yp auto_homes -fstype=nfs,nosuid,grpid,nobrowse,proto=tcp,port=2049
> > >> > 
> > >> > and see if that gets what you need. The nfs4 one needs to be first
> > >> > because the v4 servers provide both v4 and v3.
> > >> 
> > >> This only gives me the nfs4 mounts, it seems like the second part of the
> > >> multimount is not evaluated when the first one says "I don't have that
> > >> directory you asked me about":
> > >
> > > Aaah yes, of course, sorry about that.
> > > That would be because the first encountered key is used to decide pass
> > > or fail.
> > 
> > No, it is because the second key was never added to the cache.  See my
> > earlier, somewhat cryptic message on this.
> > 
> > As Pete said, if the default should be nfs4, that should happen in mount.
> 
> Yes and no :)
> 
> I'm currently trying to understand the autofs5 code and stumbled upon
> modules/replicated.c, function prune_host_list that get's called from
> mount_nfs.c and *somehow* decides wether to try nfs4 or other nfs
> versions. Would any of you be so kind and explain the way that the
> information from the entry in the auto.master-map (-fstype=nfs4 or =nfs)
> gets propagated down to the actual mount command? 

You probably just want to look at modules/mount_nfs.c.

The actual chain of events is:
1) Parse master map and mount automounts, create
daemon/automount.c:handle_mounts thread for each mount.
2) daemon/automount.c:handle_mounts dispatches events as they come in.
3) A missing packet for an indirect mount leads to a call to
daemon/indirect.c:handle_packet_missing_indirect.
4) Then -> daemon/indirect.c:do_mount_indirect ->
daemon/lookup.c:lookup.c -> modules/lookup_<type>.c:lookup_mount ->
modules/parse_sun.c:parse_mount -> modules/mount_<type>.c:mount_mount.

Ian
