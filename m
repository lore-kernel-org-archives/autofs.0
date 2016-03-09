From: Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: "Too many levels of symbolic links"
Date: Wed, 09 Mar 2016 18:44:47 +0100
Message-ID: <56E0610F.9020704@molgen.mpg.de>
References: <1391145206.2486.25.camel@perseus.fritz.box>	 <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de>	 <530484B7.6030305@molgen.mpg.de>	 <1392896501.2508.16.camel@perseus.fritz.box>	 <1392898704.2508.26.camel@perseus.fritz.box>	 <530625D0.7020808@molgen.mpg.de>	 <1392946952.2495.3.camel@perseus.fritz.box>	 <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de>	 <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>	 <1393726942.9725.5.camel@perseus.fritz.box>	 <1393744241.9725.16.camel@perseus.fritz.box>	 <5313467C.9080102@molgen.mpg.de>	 <1393814402.2787.19.camel@perseus.fritz.box> <1393913207.2781.20.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1393913207.2781.20.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>

Hi, Kent,

in 2014 we analyzed and discussed a problem which in my view boiled down 
to "autofs refuses to mount on a path (dentry) which already is mounted 
in another namespace." This is because it uses d_mountpoint ( = 
DCACHE_MOUNTED) to decide whether a mount should be attempted or not. At 
that point I selfishly changed our setting to avoid use of mount 
namespaces and left you alone with the problem.

But now we need mount namespaces ourselves using kernel 4.4.2 and the 
old problem reoccurred

So my questions:

* am I right, that this problem is still unresolved?
* is this considered a bug?

and if so, do you already have an idea, which way this could be resolved?

As a reminder, here is the script we used to demonstrate the problem ( 
assuming /project/mariux32 is served by autofs) :

===
#! /bin/sh

ls -ld /project/mariux32/.
unshare -m -- bash -c "sleep 6;ls -ld /project/mariux32/.;echo exit..." &
kill -USR1  `cat /var/run/autofs-running`
sleep 3
ls -ld /project/mariux32/.
wait
===

In your mail quoted below you wrote, the error would be avoided if "/" 
was set to shared before automount is started, but I can't confirm this.

===
root:nsa:/scratch/local/# systemctl stop automount.service
root:nsa:/scratch/local/# mount --make-rshared /
root:nsa:/scratch/local/# systemctl start automount.service
root:nsa:/scratch/local/# ./test.sh
drwxrwsr-x 6 mx32prj mx32grp 56 Feb 24  2011 /project/mariux32/.
ls: cannot access /project/mariux32/.: Too many levels of symbolic links
drwxrwsr-x 6 mx32prj mx32grp 56 Feb 24  2011 /project/mariux32/.
exit...
root:nsa:/scratch/local/#
===

Thank you!

   Donald


On 03/04/14 07:06, Ian Kent wrote:
> On Mon, 2014-03-03 at 10:40 +0800, Ian Kent wrote:
>>> That doesn't solve the problem, however, that mounts cloned by a
>>> unshare(CLONE_NEWNS) would never expire. Also there is another bug
>>> somewhere, because I see, that the mount, visible to the
>>> /usr/lib/colord/colord process was logged as "unmounted" in the nfs
>>> server when it expired in the global namespace. So I doubt it would be
>>> working even for that process. So possibly automounted mounts shouldn't
>>> be cloned at all? Together with chroot or pivot_root the sematics would
>>> be more than unclear anyway. Your problem now :-)
>> Hehe, like I said some people are going to be disappointed.
>>
>> There's just one question about this that remains.
>>
>> Assuming systemd is setting "/" shared what happens if "mount
>> --make-rprivate /" is run before autofs is started?
>>
>> So if you can spend a little more time on this an answer to this would
>> be helpful.
> No need for this, thanks to your reproducer.
>
> In fact the problem doesn't appear happen if "/" is set shared so in
> your case "/" must be set either slave or private.
>
> And expanding the reproducer a bit I see another failure case too, and
> it doesn't appear to be the unreliable d_mountpoint() check, not sure
> yet exactly what it is.
>
> Thanks
> Ian
>


-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
