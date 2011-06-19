From: Ian Kent <raven@themaw.net>
Subject: Re: Thoughts on dynamic networking with AutoFS/NFS
Date: Sun, 19 Jun 2011 11:59:45 +0800
Message-ID: <1308455985.3300.42.camel@perseus.themaw.net>
References: <6E56BACC0FDACB4E88FD63C76CE749460D39CA@edi1exch01.iouk.ioroot.tld>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=/UjSEkrO193sKqva4hzOuo8V2Fo=;
	b=W5CubYrp8hreX12snxf4GYfhReX+M+iIzkI0XllOkiDrCRzqAmjFGr9YMIXRR9rNRqhAL9dcsYMSHIZL6V8Y13KKcKM2GyVCq7LXiqmpBfaxqgOfPlEV7sW05pDjHdTahrMhBNiiNHOVsFOBR5KMkvQVF39l5om/zc8ADwmMUv8=
In-Reply-To: <6E56BACC0FDACB4E88FD63C76CE749460D39CA@edi1exch01.iouk.ioroot.tld>
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
To: Colin Simpson <Colin.Simpson@iongeo.com>
Cc: autofs@linux.kernel.org

On Thu, 2011-06-16 at 20:20 +0100, Colin Simpson wrote:
> Hi
> 
> I was just wondering what the thoughts (maybe plans) are for making
> autofs/nfs more dynamic in the new world of dynamic networking with
> the likes of Network Manager now being the default.

I've read this a couple of times now and I'm still not sure what to say
because the mail is so open ended. But here are a few comments anyway.

That might mean dbus integration which I've tried to avoid because, to
me, that looks really painful and AFAICT the documentation is lousy so
working out what the hell to do is difficult and frustrating.

But that's not really the largest part of the work either, which I won't
try and go into now, because of the main difficulty described below.

> 
> We now have quite a few users with linux laptops and they want to see
> the standard automounts on these. But being laptops they frequently
> switch subnet, jump on WiFi and VPN etc. 
> 
> Most subsystems seem to play pretty well with this dynamic network
> environment and are hooked into NM (with SSSD doing a good job with
> off net credentials and directory services caching)
> 
> Now I know that autofs/nfs is a much harder nut to crack given its
> heavy in kernel component, but I'd have thought the present
> non-dynamic behaviour is a bit of an anomaly. 

The issue is NFS.

Dynamic fail-over for mounts has been on the NFS list of things to do
for over five years and is not done yet. I'm not even sure anything is
being done or has been done toward it. And that's just for the simpler
case of read-only mounts.

I'm not sure that is what your after either but the difficulty would be
considerably more for read-write mounts. For example, although nfs
mounts are stateless (nfs4 is another matter entirely), they rely on a
file handle that is constructed based on server dependent information so
moving from one network to another and expecting mounts to just continue
to work is not going to be simple, if it is even possible.

> 
> Our present workaround is to hook a script into NM that detects when
> on or off lan. If going on lan to off, it will stop the autofs. If
> still mounts present when stopped, it will forcibly umount them.
> Pretty ugly, but better for the system than lots of dead mounts, which
> breaks lots of things (and doesn't recover if connecting to a new lan
> IP). Going off to on lan and starting autofs seems to recover and  see
> the automounts fine (despite the previous brutality to the mount
> points we performed).

How do you force the umount?

That would be OK for simple maps and simple maps are quite common but
for anything with hierarchical dependencies it will be a challenge to
get the umount order correct. Clearly the applications must be able to
handle this as well.

OTOH, if the mounts table is clean when the machine wakes then any
access should just magically bring back the mounts. But there are cases
where that won't work when using lazy umount to get rid of the mounts in
the first place.

> 
> We of course override the automounted home dir for the laptop owner.
> But they can still get to their network one via the automount when on
> lan. And other users can ssh into the back of these laptops (should
> that be necessary) and get their automounted homedir as any other
> machine would.
> 
> Any thoughts on this (maybe the talk of integrating automounts into
> sssd will change things)? Or can autofs (by option maybe) be forced to
> clear its mounts forcibly on being stopped.

What talk?

As far as I know there is no exported API for sssd now.
They want to take over and write a module for an autofs exported API and
expect me to provide the API.

I'm not keen on that because:
1) the autofs module interface is internal and is heavily dependent on
other autofs internals and the various internal modules have
dependencies upon on each other. These internal dependencies should be
removed at some point but, since it is functional now, and there's a lot
of code involved, it's not really on the radar.
2) sssd is the data provider so it should be able to provide the data,
which it can't.

Having said that it may not be a bad idea to develop a module plug-in
interface but that would require quite a lot of work and I'm not sure it
would be worth it given the level within autofs which it would be called
and so the ease with which things could be subtly broken. So that's a
support issue.

In any case the sssd side of things does nothing to overcome the
problems of tearing down and re-constructing mounts.

Ian
