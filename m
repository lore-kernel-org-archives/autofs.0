From: "Colin Simpson" <Colin.Simpson@iongeo.com>
Subject: Re: Thoughts on dynamic networking with AutoFS/NFS
Date: Sun, 19 Jun 2011 22:38:17 +0100
Message-ID: <1308519497.27829.87.camel@shyster>
References: <6E56BACC0FDACB4E88FD63C76CE749460D39CA@edi1exch01.iouk.ioroot.tld>
	<1308455985.3300.42.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1308455985.3300.42.camel@perseus.themaw.net>
Content-Class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi Ian,

Thanks for getting back.

On Sun, 2011-06-19 at 04:59 +0100, Ian Kent wrote:
> The issue is NFS.
> 
> Dynamic fail-over for mounts has been on the NFS list of things to do
> for over five years and is not done yet. I'm not even sure anything is
> being done or has been done toward it. And that's just for the simpler
> case of read-only mounts.
> 
> I'm not sure that is what your after either but the difficulty would
> be
> considerably more for read-write mounts. For example, although nfs
> mounts are stateless (nfs4 is another matter entirely), they rely on a
> file handle that is constructed based on server dependent information
> so
> moving from one network to another and expecting mounts to just
> continue
> to work is not going to be simple, if it is even possible.
> 

I can see it's mainly an NFS issue, the fail-over would be nice (plus
the ability to just time out and remove a mount if the connection is
just gone). I was just kind of hoping that maybe autofs had looked at
mitigating this NFS shortcoming for the mounts that it manages. 

I guess fail-over of mounts isn't something that can be that smooth
(though it should be but not necessarily with the present NFS versions
I'd guess). Even if it worked as well as, say clustered NFS does (where
the NFS server swaps to a new node), locks get lost and clients take
their chances, but it works pretty well for most cases. 

> >
> > Our present workaround is to hook a script into NM that detects when
> > on or off lan. If going on lan to off, it will stop the autofs. If
> > still mounts present when stopped, it will forcibly umount them.
> > Pretty ugly, but better for the system than lots of dead mounts,
> which
> > breaks lots of things (and doesn't recover if connecting to a new
> lan
> > IP). Going off to on lan and starting autofs seems to recover and
> see
> > the automounts fine (despite the previous brutality to the mount
> > points we performed).
> 
> How do you force the umount?
> 
It's pretty horrible. We stop autofs, we give it the time to run it's
standard stop. If there are any mounts left we "umount -fl" them. The
maps are all simple so it's easy enough. (Though we have a funny case on
RHEL5, where autofs is stopped, we clean the mounts, then when autofs is
restarted the stale mounts (occasionally) reappear, it's quite
intermittent). 

This is all run from a script in dispatcher.d (I half expected to see
autofs featuring in here at some point, as sendmail does (to avoid
dealing with dbus directly I guess) and get it to reload it's maps if a
data provider now become available on network change).

> That would be OK for simple maps and simple maps are quite common but
> for anything with hierarchical dependencies it will be a challenge to
> get the umount order correct. Clearly the applications must be able to
> handle this as well.
> 
In our application, the main purpose of the mounts is for the user to
see their network homedir or various shared project directories. So, in
general, the only thing still looking at these mounts on a connection or
VPN dropping will be a shell or a GUI file browser. 

If the shell (or whatever app) doesn't like the mounts going, it doesn't
really matter (even if it just crashes). It's better than the
alternative, locking up the system randomly if you hit hung mount point,
locking programs that hate stale mounts (rpm or yum, for example) or
leaving you with some hung app that you can't kill (esp in the GUI).
That would be a terrible user experience. 

This may not be good for the system (but seems to work) and is horrible,
but what's our alternative?

> OTOH, if the mounts table is clean when the machine wakes then any
> access should just magically bring back the mounts. But there are
> cases
> where that won't work when using lazy umount to get rid of the mounts
> in
> the first place.
> 
When we detect the internal network is back we restart the autofs and
the mounts seem to work again fine. 

> >
> > Any thoughts on this (maybe the talk of integrating automounts into
> > sssd will change things)? Or can autofs (by option maybe) be forced
> to
> > clear its mounts forcibly on being stopped.
> 
> What talk?
> 

Talk was probably too strong a word. I just notices sssd mentioned
automounter maps support in it's bug list. 

Thanks

Colin

This email and any files transmitted with it are confidential and are intended solely for the use of the individual or entity to whom they are addressed.  If you are not the original recipient or the person responsible for delivering the email to the intended recipient, be advised that you have received this email in error, and that any use, dissemination, forwarding, printing, or copying of this email is strictly prohibited. If you received this email in error, please immediately notify the sender and delete the original.
