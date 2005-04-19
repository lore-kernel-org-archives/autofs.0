From: raven@themaw.net
Subject: Re: mount -o bind
Date: Wed, 20 Apr 2005 00:46:41 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504200041320.8587@donald.themaw.net>
References: <200504182056.j3IKutJ30896@mail.velociti.us>
	<Pine.LNX.4.62.0504200020110.8587@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504200020110.8587@donald.themaw.net>
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

On Wed, 20 Apr 2005 raven@themaw.net wrote:

> On Mon, 18 Apr 2005, Lucas Peet wrote:
>
>>  Hello,
>> 
>> 
>> 
>>  Does autofs / automount have the ability to bind one directory to another
>>  like 'mount -o bind dir1 dir2'?  And if so, can this be handled by using
>>  wildcards in the maps?  Here is my situation:
>> 
>> 
>> 
>>  I have a large directory of user's home directories.  These are in a 
>>  chroot
>>  jail, so making soft links isn't an option, and hard links won't work for
>>  directories.  I need to bind (mount) a directory that lives outside the
>>  chroot jail to a directory / mount point inside each home directory.  The
>>  users will only be accessing this directory for short periods (to copy a
>>  file or two), and I think it would be more practical to have autofs mount 
>>  it
>>  whenever they needed access to it, and unmount it when they're done.
>> 
>> 
>> 
>>  I'm not sure on the exact number of mounted filesystems Linux can handle 
>>  (or
>>  if a directory mounded via -o bind counts towards that, though I'd assume 
>>  it
>>  would), but I would think that using automount instead of putting hundreds
>>  of entries into fstab would be more the Linux way of doing things.  Even 
>>  if
>>  I had to put an entry for each user in a map, that would be a better
>>  solution to me than using fstab, since they all wouldn't be mounted at the
>>  same time, all the time.
>> 
>> 
>> 
>>  Dir to be accessed by all users:  /home/stuff/everyone
>> 
>> 
>> 
>>  Mounted to: /home/users/*/everyone
>
> What would be the map key in this case?
>
> Perhaps you could do something like ...
>
> auto.master:
>
> /home	/etc/autofs.home
>
> autofs.home:
>
> *	/ :/home/users/& :/home/stuff/&/everyone

You might also need a -bind for this.

*	-bind :/home/users/& :/home/stuff/&/everyone

Alternately:

*	/ localhost:/home/users/& localhost:/home/stuff/&/everyone

might work.

>
> I haven't tried this so I'm not sure it will work.
> Give it a try. It will be interesting to see how chroot affects this as that 
> will probably affect the path that autofs gets back at mount request time.
>
> Note that it can't work with anything less than 4.1.4 for the : escape to 
> work in multi-maps.

And another thing.
This would mount two directories at a time. When the mount times out both 
would be umounted.

>
> Ian
