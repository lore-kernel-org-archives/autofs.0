From: "Lucas Peet" <lpeet@velociti.us>
Subject: RE: mount -o bind
Date: Tue, 19 Apr 2005 17:02:41 -0500
Message-ID: <200504192203.j3JM3CJ32241@mail.velociti.us>
References: <Pine.LNX.4.62.0504200041320.8587@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504200041320.8587@donald.themaw.net>
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org


On Wed, 20 Apr 2005 raven@themaw.net wrote:

> What would be the map key in this case?

I *think* the key would be the user's home directory?

> Perhaps you could do something like ...
>
> auto.master:
> /home	/etc/autofs.home
>
> autofs.home:
> *	/ :/home/users/& :/home/stuff/&/everyone

I don't understand a whole lot about autofs just yet (I'm learning though!)
but I'm not sure if that's what I'm after.

Say I have a 200GB drive in the system for a central shared filestore,
mounted as /data.  I have this shared via Samba on the network.  I want this
to be available as /home/users/lpeet/data (for each user in /home/users) so
it can be accessed via FTP as well.

> I haven't tried this so I'm not sure it will work.
> Give it a try. It will be interesting to see how chroot affects this as
that 
> will probably affect the path that autofs gets back at mount request time.

The chroot environment isn't system wide - it's only in place when
connecting through FTP.  Do you still think that will affect the path?

> Note that it can't work with anything less than 4.1.4 for the : escape to 
> work in multi-maps.

I'm upgrading now.  :)

> And another thing.
> This would mount two directories at a time. When the mount times out both 
> would be umounted.

So...does this mean that since there's only one mapping, using a wildcard,
that if say one user logs in, access the directory, that automount will
mount the directory for every user or just the user that requested it to be
mounted?  At the same time, if the timeout occurs for one user, will it
unmount the directory for all the users? Or will it leave the directory
mounted for all the users and wait until the last user has stopped accessing
it, and unmount it for all the users at that time?

Thanks,

-Lucas
