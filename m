From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Thu, 30 Nov 2017 08:00:22 +0800
Message-ID: <ca2890e3-e8c1-d535-d613-3cd21cdd4b28@themaw.net>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
 <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
 <874lpo2y9e.fsf@notabene.neil.brown.name>
 <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
 <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
 <20171127160147.GA27613@qualcomm.com>
 <fe35e57a-df04-3e77-a717-48483c01701a@themaw.net>
 <20171128002935.GC27898@qualcomm.com>
 <87a7z5yjbs.fsf@notabene.neil.brown.name>
 <ae8e93be-8e3f-ffd8-9043-13737230d18d@themaw.net>
 <87lgipwxwo.fsf@notabene.neil.brown.name>
 <aeedaa64-5b1e-a6e7-29f0-576de17eabf4@themaw.net>
 <87efohwn21.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=OPsy7Z6dgLwyBlp6oj2ocAHR9uG+D
        qEF9K/lKsI4fBI=; b=dBY1jAjHcJ0O2+BM9gIMRgU9fLMjuq737hgvCA/E+mSAd
        Nsbt5Xrot4Gp+FiW8TVfvzf7lxAAC7Ttb6r74VwE0jSHGcWS2Uh/uf3DWqoKlp4r
        aQpV54+emzifLC0MiypOOQE2OWeLcWImivxc/D+LCva9XcXdXDSDSXqtx6KRjBSr
        sz9jInWVoNymuIQmzYr57HkaqdAoTIx6K85o7VjO8NQZBSkuS0X2IDyezmFRlnhQ
        +SqwPfHCAFC1uv/KVhWEokesWirYKSFfv2kfWq2XemoIVK9+3mukjjW2nxwPd4qE
        zRVfcr5q1NLNgr85lxNpZ+z/9zSyAShkxHRALQeYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OPsy7Z
        6dgLwyBlp6oj2ocAHR9uG+DqEF9K/lKsI4fBI=; b=AjSemtE6amQiP4TjMMfvp/
        FcmvUKUoBpvjtzMaF4jNjZIaLxmTU7W5OdTx+75wAWHC1DEW3fMcPpJAduUn1oNA
        0oO3HmJOBKSBCIVjDRYXxCi8xfCrFZo7Wxc4mhQHkgGtdiyi2Qo+nIvaRHvRbsgh
        O+5/NPGw3TFv1X15B4WHT457DUBQqMU5ci6rKGFNGip4qiAKudjH32bqGZufSUy4
        g5Cj7ZDSY0CnUG/ipi65cMF8wtLCNS4azKitNVAIAARb7UCk6TnK8VwAwONEWcv6
        qwpa1eFfWvprkwnedhQG2LPDTzVg6WvEMrVJwuNM8pZgYBiEGPowo7WuxN3mzsYw
        ==
In-Reply-To: <87efohwn21.fsf@notabene.neil.brown.name>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>, Mike Marion <mmarion@qualcomm.com>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>

On 29/11/17 15:39, NeilBrown wrote:
> On Wed, Nov 29 2017, Ian Kent wrote:
> 
>> On 29/11/17 11:45, NeilBrown wrote:
>>> On Wed, Nov 29 2017, Ian Kent wrote:
>>>
>>>> Adding Al Viro to the Cc list as I believe Stephen Whitehouse and
>>>> Al have discussed something similar, please feel free to chime in
>>>> with your thoughts Al.
>>>>
>>>> On 29/11/17 09:17, NeilBrown wrote:
>>>>> On Tue, Nov 28 2017, Mike Marion wrote:
>>>>>
>>>>>> On Tue, Nov 28, 2017 at 07:43:05AM +0800, Ian Kent wrote:
>>>>>>
>>>>>>> I think the situation is going to get worse before it gets better.
>>>>>>>
>>>>>>> On recent Fedora and kernel, with a large map and heavy mount activity
>>>>>>> I see:
>>>>>>>
>>>>>>> systemd, udisksd, gvfs-udisks2-volume-monitor, gvfsd-trash,
>>>>>>> gnome-settings-daemon, packagekitd and gnome-shell
>>>>>>>
>>>>>>> all go crazy consuming large amounts of CPU.
>>>>>>
>>>>>> Yep.  I'm not even worried about the CPU usage as much (yet, I'm sure 
>>>>>> it'll be more of a problem as time goes on).  We have pretty huge
>>>>>> direct maps and our initial startup tests on a new host with the link vs
>>>>>> file took >6 hours.  That's not a typo.  We worked with Suse engineering 
>>>>>> to come up with a fix, which should've been pushed here some time ago.
>>>>>>
>>>>>> Then, there's shutdowns (and reboots). They also took a long time (on
>>>>>> the order of 20+min) because it would walk the entire /proc/mounts
>>>>>> "unmounting" things.  Also fixed now.  That one had something to do in
>>>>>> SMP code as if you used a single CPU/core, it didn't take long at all.
>>>>>>
>>>>>> Just got a fix for the suse grub2-mkconfig script to fix their parsing 
>>>>>> looking for the root dev to skip over fstype autofs
>>>>>> (probe_nfsroot_device function).
>>>>>>
>>>>>>> The symlink change was probably the start, now a number of applications
>>>>>>> now got directly to the proc file system for this information.
>>>>>>>
>>>>>>> For large mount tables and many processes accessing the mount table
>>>>>>> (probably reading the whole thing, either periodically or on change
>>>>>>> notification) the current system does not scale well at all.
>>>>>>
>>>>>> We use Clearcase in some instances as well, and that's yet another thing
>>>>>> adding mounts, and its startup is very slow, due to the size of
>>>>>> /proc/mounts.  
>>>>>>
>>>>>> It's definitely something that's more than just autofs and probably
>>>>>> going to get worse, as you say.
>>>>>
>>>>> If we assume that applications are going to want to read
>>>>> /proc/self/mount* a log, we probably need to make it faster.
>>>>> I performed a simple experiment where I mounted 1000 tmpfs filesystems,
>>>>> copied /proc/self/mountinfo to /tmp/mountinfo, then
>>>>> ran 4 for loops in parallel catting one of these files to /dev/null 1000 times.
>>>>> On a single CPU VM:
>>>>>   For /tmp/mountinfo, each group of 1000 cats took about 3 seconds.
>>>>>   For /proc/self/mountinfo, each group of 1000 cats took about 14 seconds.
>>>>> On a 4 CPU VM
>>>>>   /tmp/mountinfo: 1.5secs
>>>>>   /proc/self/mountinfo: 3.5 secs
>>>>>
>>>>> Using "perf record" it appears that most of the cost is repeated calls
>>>>> to prepend_path, with a small contribution from the fact that each read
>>>>> only returns 4K rather than the 128K that cat asks for.
>>>>>
>>>>> If we could hang a cache off struct mnt_namespace and use it instead of
>>>>> iterating the mount table - using rcu and ns->event to ensure currency -
>>>>> we should be able to minimize the cost of this increased use of
>>>>> /proc/self/mount*.
>>>>>
>>>>> I suspect that the best approach would be implement a cache at the
>>>>> seq_file level.
>>>>>
>>>>> One possible problem might be if applications assume that a read will
>>>>> always return a whole number of lines (it currently does).  To be
>>>>> sure we remain safe, we would only be able to use the cache for
>>>>> a read() syscall which reads the whole file.
>>>>> How big do people see /proc/self/mount* getting?  What size reads
>>>>> does 'strace' show the various programs using to read it?
>>>>
>>>> Buffer size almost always has a significant impact on IO so that's
>>>> likely a big factor but the other aspect of this is notification
>>>> of changes.
>>>>
>>>> The risk is improving the IO efficiency might just allow a higher
>>>> rate of processing of change notifications and similar symptoms
>>>> to what we have now.
>>>
>>> That's an issue that we should be able to get empirical data on.
>>> Are these systems that demonstrate problems actually showing a high
>>> rate of changes to the mount table, or is the mount table being
>>> read frequently despite not changing?
>>> To find out you could use a program like one of the answers to:
>>>
>>> https://stackoverflow.com/questions/5070801/monitoring-mount-point-changes-via-proc-mounts
>>>
>>> or instrument the kernel to add a counter to 'struct mnt_namespace' and
>>> have mounts_open_common() increment that counter and report the value as
>>> well as ns->event.  The long term ratio of the two numbers might be
>>> interesting.
>>
>> One scenario is, under heavy mount activity, the CPU usage of processes
>> systemd, udisksd2, gvfs-udisks2-volume-monitor, gvfsd-trash,
>> gnome-settings-daemon and packagekitd (and possibly gnome-shell, might
>> be a false positive though) grow to consume all available CPU.
> 
> OK, that's pretty clearly caused by lots of changes happening in quick
> succession.
> The current poll support in the kernel is slightly non-optimal in that
> it could trigger more events than necessary, but it probably doesn't
> make a big difference.
> 
> The current code means that poll/select will report an event if there
> has been an event since the last time that poll/select reported an
> event.
> It is only necessary to report an event if these has been one since the
> last time that the first record in the file was read.
> So if there are a sequence of events, then the file is read, a
> subsequent poll will report another event where there isn't really one.
> This would only be noticed if there was a delay between the event being
> reported in the kernel, and the read happening.
> 
> You could test by removing
> 		m->poll_event = event;
> from mounts_poll() and adding something like:
>  if (*pos == 0) m->poll_event = p->ns->event;
> to m_start().
> 
> 
>>
>> The processes gvfs-udisks2-volume-monitor and gnome-settings-daemon 
>> (and possibly packagekitd, might be false positive) continue to use
>> excessive CPU when the mount table is large but there is no mount/umount
>> activity.
> 
> That is strange.  I wonder if something could be triggering phantom
> events in some way.. Do they eventually settle, or does this continue
> for hours.  Is there an easy way I could reproduce?

Any large direct mount map will do it, it's the mounting (and subsequent
umount) of the autofs direct mount triggers that see the problematic
behavior.

Something like (I've called it mkdmap.c) should be sufficient:

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>

char mount1[] = "gandalf:/usr/local/etc";
char dir1[] = "/direct/etc/";
char mount2[] = "gandalf:/usr/local/bin";
char dir2[] = "/direct/bin/";
char mount3[] = "gandalf:/usr/local/lib";
char dir3[] = "/direct/lib/";
char mount4[] = "gandalf:/usr/local/man";
char dir4[] = "/direct/man/";
char mount5[] = "gandalf:/usr/local/share";
char dir5[] = "/direct/share/";

void pmap(char p)
{
        char tem[80];
        char dir[100];
        int i;

        sprintf(tem, "%cXXXXXX", p);

        for (i=0; i < 1000; i++) {
                char *tname;

                strcpy(dir, dir1);
                strcat(dir, tem);
                tname = mktemp(dir);
                printf("%s\t%s\n", tname, mount1);

                strcpy(dir, dir2);
                strcat(dir, tem);
                tname = mktemp(dir);
                printf("%s\t%s\n", tname, mount2);

                strcpy(dir, dir3);
                strcat(dir, tem);
                tname = mktemp(dir);
                printf("%s\t%s\n", tname, mount3);

                strcpy(dir, dir4);
                strcat(dir, tem);
                tname = mktemp(dir);
                printf("%s\t%s\n", tname, mount4);

                strcpy(dir, dir5);
                strcat(dir, tem);
                tname = mktemp(dir);
                printf("%s\t%s\n", tname, mount5);
        }
}

int main(int argc, char **argv)
{
        pmap('a');
        pmap('b');
        pmap('c');
        pmap('d');
        pmap('e');
        pmap('f');
}

This will print 30,000 direct mount map entries to stdout.

It isn't necessary for the server (gandalf in this case) to be valid but
might be worth changing to something sensible for your environment.

My testing was done using F26, I'd be interested to know what happens
with other environments.

> 
>>
>> In this case heavy mount activity means starting autofs with a direct
>> mount map of 15k+ entries.
> 
> I'll try that tomorrow and see what happens.  Would bind mounts be
> enough?

It's not necessary to actually trigger mounts, as I say above.

Starting autofs with a large direct mount map, wait for a while to observe
which processes continue to consume resources when the mount table isn't
changing any more then shutdown autofs should be enough.

> 
>>
>> The shutdown can be a problem too but umount(2) is just too slow for it
>> to be as pronounced a problem as what we see at startup. The umount
>> slowness appears to be constant. I'm not sure if it's proportional in any
>> way to the number of mounts present on the system.
> 
> Changing synchronize_rcu() in namespace_unlock() to
> synchronize_rcu_expedited() makes umount much faster.  Al has the patch
> but hasn't responded.  Using "umount -c", which systemd now does, can
> also help I think.
> 
>>
>>>
>>>
>>>
>>>>
>>>> The suggestion is that a system that allows for incremental (diff
>>>> type) update notification is needed to allow mount table propagation
>>>> to scale well.
>>>>
>>>> That implies some as yet undefined user <-> kernel communication
>>>> protocol.
>>>
>>> I can almost conceive a mountinfo variant where new entries always
>>> appear at the end and deletions appear as just "$mnt_id".
>>> struct proc_mounts would contain a bitmap similar to mnt_id_ida which
>>> records which ids have been reported to this file.  When an event is
>>> noticed it checks for deletions and reports them before anything else.
>>> Keeping track of location in the ns->list list might be tricky.  It
>>> could be done with a new 64bit never-reused mnt id, though some other
>>> approach might be possible.
>>>
>>> An app would read to the end, then poll/select for exceptional events
>>> and keep reading.
>>
>> Keeping track of modifications is certainly one of the problems and this
>> sounds like a good start to resolving it ....
>>
>> I believe the current preferred delivery of this to be a shared library
>> interface available to user space that talks to the kernel to obtain the
>> needed information.
> 
> Any suggests at the sort of interface?  If I provided a pollable fd, and
> a function which given the fd and a 'struct mntent' (or similar) would
> fill in the mntent if info was available, would that be likely to suit?
> Not that I'm promising anything but having a framework helps guide
> thoughts.

One difficulty we face with this is the lack of a framework to build
ideas upon.

It's complicated by the need for what's done to be extensible to handling
general file system event notification.

That's hind of a contradiction in itself as getting mount table information,
notifications or otherwise, probably requires a call directly to the kernel
so that current->fs can be used to select the correct mounts list for the
requesting process namespace while general notification events imply a
disjoint system.

Ian
