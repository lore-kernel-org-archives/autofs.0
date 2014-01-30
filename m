From: Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: autofs linux 3.8.13 and "Too many levels of symbolic links"
Date: Thu, 30 Jan 2014 11:28:51 +0100
Message-ID: <52EA2963.9070709@molgen.mpg.de>
References: <52E92627.9050801@molgen.mpg.de> <1391041164.2620.10.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1391041164.2620.10.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>, leonardo.lists@gmail.com
Cc: autofs <autofs@vger.kernel.org>

Thanks, Leonardo and Ian.

In contrast to what Leonardo described, in our case the problem doesn't 
go away after some time. If the daemon is restarted and able to unmount 
the automount root ( /scratch here) than everything looks fine after the 
restart (however, the visible problem might just be (lazy?) unmounted 
away ?).

Sadly, I am not able to reproduce it at will. The problem occurs rarely: 
We have about 12 active (and 24 most-of-the-time idle) machines running 
this code since mid December and had about 8 of theses issues. Of these, 
three were on one workstation and two were on another one, so there is a 
dependency on the hardware or usage pattern which is not yet identified. 
We have very active machines which mount and unmount a lot more then 
these two and didn't have an issue.

I know its an old kernel. Sure, latest and greatest first is the 
systematic way to go, but I thought, I'd ask for ideas first, because 
the kernel upgrade will take much time and work (legacy graphic cards, 
netfilter functionality...) and surely will bring new bugs and problems 
as well. It always did.

I hoped to get autofs running cleanly before that. There isn't so much 
change in "git log -p v3.8.13..master  fs/autofs4" anyway.

The logs I currently have are loglevel 1 only and there is nothing 
unusual logged.  I can change the loglevel to 9 on the currently hung 
system but there are now messages when the directory is accessed.

I forgot to dump the autofs_info and autofs_sb_info struct the last 
time. Here they are just for completeness: 
http://owww.molgen.mpg.de/~buczek/autofs-demo/typescript_2.l

Oh yes, another info: We've seen this on various automount maps with 
various nfs-servers, so it doesn't depend on that.
And we rebuild the maps and kill -HUP the daemon a lot.

I plan to go the long way to 3.13 now and let you know if I have any new 
information.

Thanks again

   Donald


On 01/30/14 01:19, Ian Kent wrote:
> On Wed, 2014-01-29 at 17:02 +0100, Donald Buczek wrote:
>> Hello,
>>
>> we are trying to switch from amd to autofs. After successfully testing
>> and rolling it out to the first several machines, from time to time we
>> get directories stuck with "Too many levels of symbolic links" on a path
>> which should be automounted via an indirect map.
>>
>> linux 3.8.13
> What is linux 3.8.13?
> Oh right, an old kernel.
> You need to reproduce this with a current kernel, 3.13.0 for example.
> OTOH I have had a couple of recent reports of this, not including
> Leonardo's, so any information is useful.
>
>> autofs 5.0.8
>>
>> As an example, here is data from a system where the path /scratch/tmp is
>> stuck:
>>
>> http://www.molgen.mpg.de/~buczek/autofs-demo/
>>
>>     auto.master    # master map
>>     auto.scratch    # indirect map for /scratch
>>     autofs            # from /etc/defaults
>>     typescript       # shows the problem and a bit of gdb dump of kernel
>> structures
>>     typescript.l     # same with line numbers for reference
>>     gdb-macros     # macros used in the gdb session
>>
>>   From typescript.l , line 122ff it is clear, that /scratch/tmp is not
>> currently mounted. On the other hand, the gdb session finds the dentry
>> of /scratch/tmp which has d_flags 0x70080 (line 99,120). This is
>> DCACHE_MANAGE_TRANSIT+DCACHE_NEED_AUTOMOUNT+DCACHE_MOUNTED+DCACHE_RCUACCESS
>> with DCACHE_MOUNTED indicating that there should be something mounted
>> there(?). I think, this state is faulty and necessarily leads to ELOOP
>> during path walk. Probably the situation is known by the gurus here?
> Well, at least I believe there's a bug to be found now.
>
>  From this output it does show a dentry that, according to the config,
> shouldn't exist (but might still), is fully visible and claims it's
> mounted (and definitely should be).
>
>> Is there any known bug which can lead to this situation? Any advice?
> Any more information you gather would be good.
> How frequently does this occur?
> Any idea of the activity leading to this?
> A full debug log and a time the mount was discovered inoperable might
> help.
>
>> Thank you
>>
>>     Donald
>>
>


-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

