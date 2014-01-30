From: Ian Kent <raven@themaw.net>
Subject: Re: autofs linux 3.8.13 and "Too many levels of symbolic links"
Date: Thu, 30 Jan 2014 22:30:19 +0800
Message-ID: <E2163B9E-3214-477B-BB93-91FA4B424CE9@themaw.net>
References: <52E92627.9050801@molgen.mpg.de> <1391041164.2620.10.camel@perseus.fritz.box> <52EA2963.9070709@molgen.mpg.de>
Mime-Version: 1.0 (1.0)
Content-Transfer-Encoding: 8BIT
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	references:mime-version:in-reply-to:content-type
	:content-transfer-encoding:message-id:cc:from:subject:date:to;
	 s=mesmtp; bh=ti2xUXZwKRgzzG0txavHelABAVA=; b=A4tz42XU43xDVB1wRW
	hz6wLldffOEkRRFWJdam4PU1jpZC33L8XR9W0QVTrUqXEWZFKumWdzCi+JmoZ8hK
	umeBiRkk99ai/OP8uOCcJJ/88s06IvdYHLrBUYjVHHOfNAcUThPzg+a2o8wqo9hk
	pcf9Y2wHuYsOevuN+18jC717E=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=references:mime-version:in-reply-to
	:content-type:content-transfer-encoding:message-id:cc:from
	:subject:date:to; s=smtpout; bh=ti2xUXZwKRgzzG0txavHelABAVA=; b=
	F1gyVYItZirc5npghZ/bPcq7bkX5nT6UXzpqD2itbv8m71h8W6luESgr0VUYaG1Z
	tbo0VcTfqdiE4E0ifFax3HZ67cJE5sAcH7nKXxed6zPIB5HeXsODijajA3NGotjv
	5Ivsmi5Mh8s+t3EBoEOaNps1jytvF+k9UEpKdnXQeFA=
In-Reply-To: <52EA2963.9070709@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: "leonardo.lists@gmail.com" <leonardo.lists@gmail.com>, autofs <autofs@vger.kernel.org>



> On 30 Jan 2014, at 6:28 pm, Donald Buczek <buczek@molgen.mpg.de> wrote:
> 
> Thanks, Leonardo and Ian.
> 
> In contrast to what Leonardo described, in our case the problem doesn't go away after some time. If the daemon is restarted and able to unmount the automount root ( /scratch here) than everything looks fine after the restart (however, the visible problem might just be (lazy?) unmounted away ?).
> 
> Sadly, I am not able to reproduce it at will. The problem occurs rarely: We have about 12 active (and 24 most-of-the-time idle) machines running this code since mid December and had about 8 of theses issues. Of these, three were on one workstation and two were on another one, so there is a dependency on the hardware or usage pattern which is not yet identified. We have very active machines which mount and unmount a lot more then these two and didn't have an issue.

And with any leads as to where to look I'm stuck at guessing where to look.
Understanding what leads to the symptom would be a big help.


> 
> I know its an old kernel. Sure, latest and greatest first is the systematic way to go, but I thought, I'd ask for ideas first, because the kernel upgrade will take much time and work (legacy graphic cards, netfilter functionality...) and surely will bring new bugs and problems as well. It always did.

Yeah, I understand that.
The reason for an asksing if it can be reproduced on a current kernel is that it could already be fixed.

Don't think that is the case here though so continue to profile the problem.

I'm pretty sure I've looked at this before and have been left thinking, what needs to happen to make this happen can't happen!

> 
> I hoped to get autofs running cleanly before that. There isn't so much change in "git log -p v3.8.13..master  fs/autofs4" anyway.

This probably isn't the autofs module, it's probably in the automount code in the VFS.

Specific automount support has been added to the VFS around 2.6.32 so this sort of problem could be in the NFS module (assuming your seeing this with autofs NFS auto mounts), the autofs module itself or somewhere in the VFS (most likely the path walking code). Since this automount support was added the path walking code been continuously changed, pretty much re-written, so there's a lot of ground to cover.

> 
> The logs I currently have are loglevel 1 only and there is nothing unusual logged.  I can change the loglevel to 9 on the currently hung system but there are now messages when the directory is accessed.
> 
> I forgot to dump the autofs_info and autofs_sb_info struct the last time. Here they are just for completeness: http://owww.molgen.mpg.de/~buczek/autofs-demo/typescript_2.l
> 
> Oh yes, another info: We've seen this on various automount maps with various nfs-servers, so it doesn't depend on that.
> And we rebuild the maps and kill -HUP the daemon a lot.

I wonder, mmm.
We need more information.
Check things for inconsistencies when it happens.
Things like /proc/mounts for duplicate mounts etc.

I don't think I've ever got a full autofs debug log from anyone who's seen this.
TBH I don't think it will give any clues but not having seen it is just another variable I can't eliminate.

> 
> I plan to go the long way to 3.13 now and let you know if I have any new information.
> 
> Thanks again
> 
>  Donald
> 
> 
>> On 01/30/14 01:19, Ian Kent wrote:
>>> On Wed, 2014-01-29 at 17:02 +0100, Donald Buczek wrote:
>>> Hello,
>>> 
>>> we are trying to switch from amd to autofs. After successfully testing
>>> and rolling it out to the first several machines, from time to time we
>>> get directories stuck with "Too many levels of symbolic links" on a path
>>> which should be automounted via an indirect map.
>>> 
>>> linux 3.8.13
>> What is linux 3.8.13?
>> Oh right, an old kernel.
>> You need to reproduce this with a current kernel, 3.13.0 for example.
>> OTOH I have had a couple of recent reports of this, not including
>> Leonardo's, so any information is useful.
>> 
>>> autofs 5.0.8
>>> 
>>> As an example, here is data from a system where the path /scratch/tmp is
>>> stuck:
>>> 
>>> http://www.molgen.mpg.de/~buczek/autofs-demo/
>>> 
>>>    auto.master    # master map
>>>    auto.scratch    # indirect map for /scratch
>>>    autofs            # from /etc/defaults
>>>    typescript       # shows the problem and a bit of gdb dump of kernel
>>> structures
>>>    typescript.l     # same with line numbers for reference
>>>    gdb-macros     # macros used in the gdb session
>>> 
>>>  From typescript.l , line 122ff it is clear, that /scratch/tmp is not
>>> currently mounted. On the other hand, the gdb session finds the dentry
>>> of /scratch/tmp which has d_flags 0x70080 (line 99,120). This is
>>> DCACHE_MANAGE_TRANSIT+DCACHE_NEED_AUTOMOUNT+DCACHE_MOUNTED+DCACHE_RCUACCESS
>>> with DCACHE_MOUNTED indicating that there should be something mounted
>>> there(?). I think, this state is faulty and necessarily leads to ELOOP
>>> during path walk. Probably the situation is known by the gurus here?
>> Well, at least I believe there's a bug to be found now.
>> 
>> From this output it does show a dentry that, according to the config,
>> shouldn't exist (but might still), is fully visible and claims it's
>> mounted (and definitely should be).
>> 
>>> Is there any known bug which can lead to this situation? Any advice?
>> Any more information you gather would be good.
>> How frequently does this occur?
>> Any idea of the activity leading to this?
>> A full debug log and a time the mount was discovered inoperable might
>> help.
>> 
>>> Thank you
>>> 
>>>    Donald
> 
> 
> -- 
> Donald Buczek
> buczek@molgen.mpg.de
> Tel: +49 30 8413 1433
> 
