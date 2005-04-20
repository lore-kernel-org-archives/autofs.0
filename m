From: raven@themaw.net
Subject: RE: mount -o bind
Date: Wed, 20 Apr 2005 20:02:23 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504201958130.1883@donald.themaw.net>
References: <200504192203.j3JM3CJ32241@mail.velociti.us>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200504192203.j3JM3CJ32241@mail.velociti.us>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Lucas Peet <lpeet@velociti.us>
Cc: autofs@linux.kernel.org

On Tue, 19 Apr 2005, Lucas Peet wrote:

>
> On Wed, 20 Apr 2005 raven@themaw.net wrote:
>
>> What would be the map key in this case?
>
> I *think* the key would be the user's home directory?
>
>> Perhaps you could do something like ...
>>
>> auto.master:
>> /home	/etc/autofs.home
>>
>> autofs.home:
>> *	/ :/home/users/& :/home/stuff/&/everyone
>
> I don't understand a whole lot about autofs just yet (I'm learning though!)
> but I'm not sure if that's what I'm after.
>
> Say I have a 200GB drive in the system for a central shared filestore,
> mounted as /data.  I have this shared via Samba on the network.  I want this
> to be available as /home/users/lpeet/data (for each user in /home/users) so
> it can be accessed via FTP as well.
>
>> I haven't tried this so I'm not sure it will work.
>> Give it a try. It will be interesting to see how chroot affects this as
> that
>> will probably affect the path that autofs gets back at mount request time.
>
> The chroot environment isn't system wide - it's only in place when
> connecting through FTP.  Do you still think that will affect the path?

See following message but ...

In the case that I describe the chroot will cause the mount.
Both the needed directories will be mounted before chroot completes so in 
the case I've described it should be OK.

What kernel are you using?
This could make a difference.

>
>> Note that it can't work with anything less than 4.1.4 for the : escape to
>> work in multi-maps.

That's the ":" escape I'm talking about.
If you use localhost the mounts should be bind mounts anyway, giving the 
same result.

>
> I'm upgrading now.  :)
>
>> And another thing.
>> This would mount two directories at a time. When the mount times out both
>> would be umounted.
>
> So...does this mean that since there's only one mapping, using a wildcard,
> that if say one user logs in, access the directory, that automount will
> mount the directory for every user or just the user that requested it to be
> mounted?  At the same time, if the timeout occurs for one user, will it
> unmount the directory for all the users? Or will it leave the directory
> mounted for all the users and wait until the last user has stopped accessing
> it, and unmount it for all the users at that time?

They would be mounted on demand.
See following post.

Ian
