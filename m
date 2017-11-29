From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Wed, 29 Nov 2017 10:56:25 +0800
Message-ID: <ae8e93be-8e3f-ffd8-9043-13737230d18d@themaw.net>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
 <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
 <874lpo2y9e.fsf@notabene.neil.brown.name>
 <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
 <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
 <20171127160147.GA27613@qualcomm.com>
 <fe35e57a-df04-3e77-a717-48483c01701a@themaw.net>
 <20171128002935.GC27898@qualcomm.com>
 <87a7z5yjbs.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=y/go2pKbUKvylYd9lgFY3x08FNeGY
        KbOaM3TIyntJgg=; b=hDOa6rLb0Gpb69QLkSsgyTTqeK9/nb+eT8FahvNLYqn4W
        JScZ6eDg2JRUMAazK1u9RpqPdmApWMAZIEPI0Zm/O/Wc5FSLUzo7VzN+H1UX7t4l
        1mR3Qq/C822jJPRzc77uNNuLE1KrpLspnv3g/6EEmrn03g78ypnN2MQh3J58BcBD
        0uOUSvpk9ASMMqgXuuQTo1mIMHWYlcqofOplx0GPle1xLDsY61k73IoB+Xxogjt/
        43YcY/3Cu+jT+4T0pOt13bHoOA0L2WdfELi7oIfi3b/V8ff8/6kAoM0LNEk0lVlx
        CqXHOpmt1LK2RBJ5DBVGW1XEizGCtzRGBxpqILb8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=y/go2p
        KbUKvylYd9lgFY3x08FNeGYKbOaM3TIyntJgg=; b=HmlbaN3NOJ600A6rWsli5Y
        luFUrM4JZrhZpeIS2g+H6GkTBPfQ1sPEb/7IWx3y3LrL1xVZ3XaxSmNgpFVIR66/
        Ha343k3dYboV5s9UhXQJ6x0btYtkpE/4qbsCjGOpcOmG8aPnAqXblSfyGUI/niTJ
        vghm145WXAvOl5JCBcr7ndse4Yq9prb7zUOFOOEXHW+VhrcgI2Zjp2isKXypPMKt
        roLWpq0f926l67VM2PL5P3sS1Nc259Yc4qScDx0QwfakdA7xaFSbsnOcZHO+ZJHv
        Ua5WzSDeqFgJlrmrbjShPaWdW2HDDNcSKTbMwhPFmHxbvLbTSvk9ouMML+tgoyww
        ==
In-Reply-To: <87a7z5yjbs.fsf@notabene.neil.brown.name>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>, Mike Marion <mmarion@qualcomm.com>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>


Adding Al Viro to the Cc list as I believe Stephen Whitehouse and
Al have discussed something similar, please feel free to chime in
with your thoughts Al.

On 29/11/17 09:17, NeilBrown wrote:
> On Tue, Nov 28 2017, Mike Marion wrote:
> 
>> On Tue, Nov 28, 2017 at 07:43:05AM +0800, Ian Kent wrote:
>>
>>> I think the situation is going to get worse before it gets better.
>>>
>>> On recent Fedora and kernel, with a large map and heavy mount activity
>>> I see:
>>>
>>> systemd, udisksd, gvfs-udisks2-volume-monitor, gvfsd-trash,
>>> gnome-settings-daemon, packagekitd and gnome-shell
>>>
>>> all go crazy consuming large amounts of CPU.
>>
>> Yep.  I'm not even worried about the CPU usage as much (yet, I'm sure 
>> it'll be more of a problem as time goes on).  We have pretty huge
>> direct maps and our initial startup tests on a new host with the link vs
>> file took >6 hours.  That's not a typo.  We worked with Suse engineering 
>> to come up with a fix, which should've been pushed here some time ago.
>>
>> Then, there's shutdowns (and reboots). They also took a long time (on
>> the order of 20+min) because it would walk the entire /proc/mounts
>> "unmounting" things.  Also fixed now.  That one had something to do in
>> SMP code as if you used a single CPU/core, it didn't take long at all.
>>
>> Just got a fix for the suse grub2-mkconfig script to fix their parsing 
>> looking for the root dev to skip over fstype autofs
>> (probe_nfsroot_device function).
>>
>>> The symlink change was probably the start, now a number of applications
>>> now got directly to the proc file system for this information.
>>>
>>> For large mount tables and many processes accessing the mount table
>>> (probably reading the whole thing, either periodically or on change
>>> notification) the current system does not scale well at all.
>>
>> We use Clearcase in some instances as well, and that's yet another thing
>> adding mounts, and its startup is very slow, due to the size of
>> /proc/mounts.  
>>
>> It's definitely something that's more than just autofs and probably
>> going to get worse, as you say.
> 
> If we assume that applications are going to want to read
> /proc/self/mount* a log, we probably need to make it faster.
> I performed a simple experiment where I mounted 1000 tmpfs filesystems,
> copied /proc/self/mountinfo to /tmp/mountinfo, then
> ran 4 for loops in parallel catting one of these files to /dev/null 1000 times.
> On a single CPU VM:
>   For /tmp/mountinfo, each group of 1000 cats took about 3 seconds.
>   For /proc/self/mountinfo, each group of 1000 cats took about 14 seconds.
> On a 4 CPU VM
>   /tmp/mountinfo: 1.5secs
>   /proc/self/mountinfo: 3.5 secs
> 
> Using "perf record" it appears that most of the cost is repeated calls
> to prepend_path, with a small contribution from the fact that each read
> only returns 4K rather than the 128K that cat asks for.
> 
> If we could hang a cache off struct mnt_namespace and use it instead of
> iterating the mount table - using rcu and ns->event to ensure currency -
> we should be able to minimize the cost of this increased use of
> /proc/self/mount*.
> 
> I suspect that the best approach would be implement a cache at the
> seq_file level.
> 
> One possible problem might be if applications assume that a read will
> always return a whole number of lines (it currently does).  To be
> sure we remain safe, we would only be able to use the cache for
> a read() syscall which reads the whole file.
> How big do people see /proc/self/mount* getting?  What size reads
> does 'strace' show the various programs using to read it?

Buffer size almost always has a significant impact on IO so that's
likely a big factor but the other aspect of this is notification
of changes.

The risk is improving the IO efficiency might just allow a higher
rate of processing of change notifications and similar symptoms
to what we have now.

The suggestion is that a system that allows for incremental (diff
type) update notification is needed to allow mount table propagation
to scale well.

That implies some as yet undefined user <-> kernel communication
protocol.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
