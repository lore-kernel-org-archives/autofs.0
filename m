From: Ian Kent <raven@themaw.net>
Subject: Re: 5.0.5 non-expiring mounts
Date: Tue, 15 Feb 2011 11:37:01 +0800
Message-ID: <1297741021.13007.12.camel@perseus>
References: <4D510D53.7010507@gmail.com>
	<20110215011037.GT27735@sunapee.qualcomm.com>
	<1297739464.13007.8.camel@perseus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=wYrLAGJZQTYB46NkyaR/r6VHt/0=;
	b=tZjRVr7g1+TaBxpiV3CsNFhLpioK7oApHeaxZvbbAREZGa1RkHWh5qK4YGf7jTfaqofuEp+yqrIjql3j/H2RzsyHqVV8ecO2nMUbURn8T8dteiyxqJBuEP1xI4/hGUSpa0sHnZ1m23veS1iSxjcokf5ZOf8KKbkrztHf/UExOCg=
In-Reply-To: <1297739464.13007.8.camel@perseus>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Tue, 2011-02-15 at 11:11 +0800, Ian Kent wrote:
> On Mon, 2011-02-14 at 17:10 -0800, Mike Marion wrote:
> > On Tue, Feb 08, 2011 at 01:30:59AM -0800, Philip Ong Jr. wrote:
> > 
> > > I've set the logging level to debug and can see messages of expiring 
> > > mounts in /var/log/messages...but when I check /etc/mtab or /proc/mounts 
> > > or df, i can still see them there. Any ideas if this is a known issue or 
> > > if I can give more info than below?
> > 
> > Out of curiosity... are these direct or indirect mounts?  We're seeing an
> > issue where our huge maps served from LDAP are seeing indirects not umounting
> > while logging expires just fine, but the direct maps are working great.  I
> > believe a co-worker has replicated this exact same behavior with local files
> > based maps too though, so pretty sure it's not really related to LDAP at all,
> > but we've found using LDAP helped clear out a lot of old issues we had a few
> > years ago related to the hashing bits.
> > 
> > I've even done network sniffing while doing a kill -USR1 and the automount
> > daemon opens new sockets for each indirect (our homedirs) path it wants to
> > expire, but there never is any actual network traffic sent across the wire.
> > Even better, the sockets stay stuck in ESTABLISHED for a long time.  Some more
> > USR1/expires and/or HUPs can help clear is, or I just run a script that does
> > an fuser then umount on unused homedirs and that flushes the ports out.  When
> > the ports pile up to >300 or so, you start getting NFS failures with syslog
> > showing "couldn't read superblock."
> > 
> > Oh, and when I say huge maps.. I mean it.  We're >10k direct mounts and I don't
> > know how many indirect mounts, but it's even more then that.
> 
> What kernel and source?

That is kernel revision and autofs revision?

> Ian
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
