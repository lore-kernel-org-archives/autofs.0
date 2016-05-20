From: Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: "Too many levels of symbolic links"
Date: Fri, 20 May 2016 16:12:42 +0200
Message-ID: <573F1B5A.2050700@molgen.mpg.de>
References: <1391145206.2486.25.camel@perseus.fritz.box>		 <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de>		 <530484B7.6030305@molgen.mpg.de>		 <1392896501.2508.16.camel@perseus.fritz.box>		 <1392898704.2508.26.camel@perseus.fritz.box>		 <530625D0.7020808@molgen.mpg.de>		 <1392946952.2495.3.camel@perseus.fritz.box>		 <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de>		 <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>		 <1393726942.9725.5.camel@perseus.fritz.box>		 <1393744241.9725.16.camel@perseus.fritz.box>		 <5313467C.9080102@molgen.mpg.de>		 <1393814402.2787.19.camel@perseus.fritz.box>	 <1393913207.2781.20.camel@perseus.fritz.box>	 <56E0610F.9020704@molgen.mpg.de> <1458094229.2967.72.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1458094229.2967.72.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>

On 03/16/16 03:10, Ian Kent wrote:
> On Wed, 2016-03-09 at 18:44 +0100, Donald Buczek wrote:
>> As a reminder, here is the script we used to demonstrate the problem (
>> assuming /project/mariux32 is served by autofs) :
>>
>> ===
>> #! /bin/sh
>>
>> ls -ld /project/mariux32/.
>> unshare -m -- bash -c "sleep 6;ls -ld /project/mariux32/.;echo
>> exit..." &
>> kill -USR1  `cat /var/run/autofs-running`
>> sleep 3
>> ls -ld /project/mariux32/.
>> wait
>> ===
>>
>> In your mail quoted below you wrote, the error would be avoided if "/"
>> was set to shared before automount is started, but I can't confirm
>> this.
>>
>> ===
>> root:nsa:/scratch/local/# systemctl stop automount.service
>> root:nsa:/scratch/local/# mount --make-rshared /
>> root:nsa:/scratch/local/# systemctl start automount.service
>> root:nsa:/scratch/local/# ./test.sh
>> drwxrwsr-x 6 mx32prj mx32grp 56 Feb 24  2011 /project/mariux32/.
>> ls: cannot access /project/mariux32/.: Too many levels of symbolic
>> links
>> drwxrwsr-x 6 mx32prj mx32grp 56 Feb 24  2011 /project/mariux32/.
>> exit...
>> root:nsa:/scratch/local/#
>> ===
> Actually, assuming /project is an indirect mount, I think that should
> have been OK.

My fault. It does work. I've overlooked

 > unshare  since  util-linux  version  2.27  automatically  sets 
propagation to private in a
 > new mount namespace to make sure that the new namespace is really
 > unshared.  It's possible to disable this feature with option 
--propagation unchanged.

So in fact it does

 > unshare(CLONE_NEWNS)                    = 0
 > mount("none", "/", NULL, MS_REC|MS_PRIVATE, NULL) = 0

If I add "--propagation unchanged" to the test script, it works. Might 
be a solution for our environment.

I understand, that the combined semantics of automount and mount 
namespaces are yet to be defined and there is no clear,unique way to do 
that.

But independent of that, I think it might be better if autofs would 
continue to try to mount on top of a dentry with DCACHE_MOUNTED set and 
this might be a requirement for most of the thinkable solutions.

> Again, there's more going on, probably unshare not cloning file handles
> (the -m clones only the mount namespace I think). Without a way of
> sending mount requests to the automount daemon, which needs to be done
> via a file handle (the current pipe implementation or even if it was
> socket based) the symptom will be the same as when / is propagation
> private.

Well, with "mount --make-rshared /" and "unshare -m --propagation 
unchanged" it looks like everything seems to be working. And the mounts 
can be triggered from the new namespace as well. There is only one 
cosmetic thing: When a automount expires, the unmount fails when the 
(shared mount) in the other namespace still is busy. This generates some 
log.

2016-05-20T15:43:39+02:00 deadbird automount[938]: expiring path 
/project/mariux32
2016-05-20T15:43:39+02:00 deadbird automount[938]: >> umount.nfs: 
/project/mariux32: device is busy
2016-05-20T15:43:39+02:00 deadbird automount[938]: >> umount.nfs: 
/project/mariux32: device is busy
2016-05-20T15:43:39+02:00 deadbird automount[938]: >> umount.nfs: 
/project/mariux32: device is busy
2016-05-20T15:43:39+02:00 deadbird automount[938]: Unable to update the 
mtab file, /proc/mounts and /etc/mtab will differ
2016-05-20T15:43:39+02:00 deadbird automount[938]: expired /project/mariux32

Regards
   Donald


>
> This is just a guess though.
>
>> Thank you!
>>
>>     Donald
>>
>>
>> On 03/04/14 07:06, Ian Kent wrote:
>>> On Mon, 2014-03-03 at 10:40 +0800, Ian Kent wrote:
>>>>> That doesn't solve the problem, however, that mounts cloned by a
>>>>> unshare(CLONE_NEWNS) would never expire. Also there is another
>>>>> bug
>>>>> somewhere, because I see, that the mount, visible to the
>>>>> /usr/lib/colord/colord process was logged as "unmounted" in the
>>>>> nfs
>>>>> server when it expired in the global namespace. So I doubt it
>>>>> would be
>>>>> working even for that process. So possibly automounted mounts
>>>>> shouldn't
>>>>> be cloned at all? Together with chroot or pivot_root the
>>>>> sematics would
>>>>> be more than unclear anyway. Your problem now :-)
>>>> Hehe, like I said some people are going to be disappointed.
>>>>
>>>> There's just one question about this that remains.
>>>>
>>>> Assuming systemd is setting "/" shared what happens if "mount
>>>> --make-rprivate /" is run before autofs is started?
>>>>
>>>> So if you can spend a little more time on this an answer to this
>>>> would
>>>> be helpful.
>>> No need for this, thanks to your reproducer.
>>>
>>> In fact the problem doesn't appear happen if "/" is set shared so in
>>> your case "/" must be set either slave or private.
>>>
>>> And expanding the reproducer a bit I see another failure case too,
>>> and
>>> it doesn't appear to be the unreliable d_mountpoint() check, not
>>> sure
>>> yet exactly what it is.
>>>
>>> Thanks
>>> Ian
>>>
>>


-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
