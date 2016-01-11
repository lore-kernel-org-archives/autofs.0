From: Stanislav Kinsburskiy <skinsbursky@odin.com>
Subject: Re: [PATCH] autofs: show pipe inode in mount options
Date: Mon, 11 Jan 2016 12:33:51 +0100
Message-ID: <5693931F.9070101@odin.com>
References: <20151216120222.19097.54512.stgit@localhost.localdomain>
 <568E8840.3010801@odin.com> <1452237640.2973.19.camel@themaw.net>
 <568F9D85.6070601@odin.com> <1452257913.7030.25.camel@themaw.net>
 <568FD028.5090207@odin.com> <1452303110.3067.29.camel@themaw.net>
Reply-To: <skinsbursky@virtuozzo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1452303110.3067.29.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Ian Kent <raven@themaw.net>, skinsbursky@virtuozzo.com
Cc: criu@openvz.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, Stephen Rothwell <sfr@canb.auug.org.au>



09.01.2016 02:31, Ian Kent =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Fri, 2016-01-08 at 16:05 +0100, Stanislav Kinsburskiy wrote:
>> 08.01.2016 13:58, Ian Kent =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> On Fri, 2016-01-08 at 12:29 +0100, Stanislav Kinsburskiy wrote:
>>>> 08.01.2016 08:20, Ian Kent =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>> On Thu, 2016-01-07 at 16:46 +0100, Stanislav Kinsburskiy wrote:
>>>>>> Good day, gentlemen.
>>>>>>
>>>>>> Could you update, what's the status with this patch?
>>>>>> Without it it's impossible to match process pipe with kernel
>>>>>> pipe,
>>>>>> while
>>>>>> this is "must have" to be able to migrate AutoFS via CRIU.
>>>>> Right, I did mean to reply to this mail but have been
>>>>> distracted by
>>>>> family stuff.
>>>>>
>>>>> I don't know what CRIU is and people looking at changelog
>>>>> entries
>>>>> shouldn't need to do a web search to find out.
>>>>>
>>>>> Could you change it a little.
>>>> Fair enough. I'll resend with more descriptive message.
>>>> But first I would like to clarify to you the problem root and why
>>>> it's
>>>> done like this.
>>>>
>>>>> I'm also not sure whether to forward this (assuming the
>>>>> description
>>>>> is
>>>>> updated a little) to Al or to include it in the series to
>>>>> rename
>>>>> autofs4 to autofs that I'm hoping to ask be included in linux
>>>>> -next
>>>>> fairly soon.
>>>> Here I don't know, what's better. Of course Al can take it as
>>>> well.
>>>> But,
>>>> probably, first would be nice to make sure, that this solution is
>>>> the
>>>> best one.
>>>> Description of the problem is below.
>>>>
>>>>> Passing it on to Al will likely interfere with the series
>>>>> coming
>>>>> from
>>>>> linux-next so that could be bit of a hassle.
>>>>>
>>>>> Another thing I'm wondering about is the order this entry will
>>>>> appear
>>>>> at in the options. You order choice is sensible though and
>>>>> autofs
>>>>> shouldn't have a problem with the inserted option but other
>>>>> applications might.
>>>> I should put it at the end, probably?
>>>>
>>>>> Finally, and perhaps most importantly, I don't get what your
>>>>> trying
>>>>> to
>>>>> do, you also haven't given any clues to that in the patch
>>>>> dscription.
>>>>>
>>>>> IOW how do you expect to use this.
>>>>>
>>>>>> 16.12.2015 13:02, Stanislav Kinsburskiy =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
>>>>>>> This is required for CRIU to migrate a mount point, when
>>>>>>> write
>>>>>>> end
>>>>>>> in user
>>>>>>> space is closed.
>>>>> Like I said what does this mean.
>>>>>
>>>>> autofs doesn't need this when it re-constructs a mount tree
>>>>> from
>>>>> existing mounts on re-start or after a SIGKILL on the automount
>>>>> process.
>>>>>
>>>>> How is this different and how will it be used?
>>>>>
>>>>> The question to be answered here is "is this the best way to do
>>>>> it
>>>>> and
>>>>> will it work for the autofs mount types you expect it to"?
>>>> So, here is a brief description of the problem.
>>>> To migrate autofs mount, one have to reconstruct control pipe
>>>> between
>>>> kernel and autofs master.
>>>> There are two cases I'm wiling to support:
>>>> 1) Automount binary (autofs package). This program is very gentle
>>>> and
>>>> it
>>>> doesn't close write end of the pipe after mount.
>>>> 2) Systemd. This program closes write end of the pipe once the
>>>> mount
>>>> is
>>>> done.
>>> I must admit I'm having trouble understanding the description.
>>> Give me a little time with it.
>>>
>>> I don't know how systemd works with autofs mounts only that it uses
>>> the
>>> autofs direct mount type.
>> Systemd closes write end of the pipe after mount.
>>
>>> autofs uses both indirect and direct mounts and both can have
>>> offsets
>>> (from the kernel POV semantically direct mounts). So there is quite
>>> a
>>> bit to worry about beside the kernel pipe.
>> It's not about direct or indirects mounts.
>> It's about process state restore.
>> With CRIU migration, any task is frozen, then disassembled into
>> pieces
>> (dump files), which are used to assemble task exactly in the same
>> state
>> in was before dump.
>> The technology is very complex and uses a lot a different tricky
>> techniques to make this possible in userspace to describe all the
>> details here.
>>
>> But below is a bit more information, which, hopefully, will clarify
>> all
>> this a little bit more.
>> One of a process attributed to migrate is "opened files". Pipes also
>> belong to this attribute.
>>
>> To restore a pipe CRIU does the following (a very simplified
>> description):
>> 1) Creates a new pipe.
>> 2) Writes (previously stores in images) its contents via write end.
>> 3) Duplicate pipe descriptors to the fds of the process, which were
>> used
>> before dump, if required
>> 4) Send pipe descriptors to other processes, sharing it, via unix
>> socket.
>> 5) Close those pipe descriptors, which are not required (say, this
>> process had only read end, while it's child had write end).
>>
>> Thus in case of restoring and autofs mount of systemd (which, for
>> example, closed write end and has read end on fd 40), one have to
>> create
>> a pipe (say, appeared with fd 5 and fd 6), fill it with content via
>> fd
>> 6, duplicate fd 5 into fd 40, call mount with pipe fd 6 and then
>> close fd 6.
>> This is, yet again, a very simple explanation.
> Right, as said initially (more or less), if you need the patch you
> posted then it shouldn't cause a problem so it should be ok. Al hasn'=
t
> responded so I guess that means I should go the linux-next path
> possibly via pull request for the series I have to rename autofs4 to
> autofs (along with this one, to prevent merge conflicts).
>
> I haven't asked Steven about this yet so I'm not sure if a pull reque=
st
> is even the right thing to do.
>
> There is another case I was wondering about.
>
> That's when there is a direct mount that is covered by a real mount.
>
> autofs will have a file handle open to it (on the underlying mount
> point path) to use for control purposes like expires. I think you als=
o
> need to restore those file handles to restore process state and in th=
is
> case the mount point is covered.
>

This is covered: all the mount points first mounted somewhere to be abl=
e=20
to reopen files. Then mount order is restored.

>>> Anyway, it seems your only concern is the kernel pipe and I wonder
>>> why
>>> you can't just set the mount catatonic (in autofs speak) on save
>>> and
>>> open a new kernel pipe then set the pipefd on the autofs mount on
>>> restore.
>> I can't because of a bunch of reasons:
>> 1) It can be migration, thus I don't have autofs mount on destinatio=
n
>> node at all
>> 2) It can be a container, which is stopped after dump (thus mount
>> point
>> is destroyed).
>>
>>> But probably my suggestion is far to simplistic as I get the
>>> impression
>>> you have a process already in a given state which you want to
>>> restore.
>>>
>>> One thing to keep in mind is that if an autofs mount is not set
>>> catatonic any access other than the owner process (process group
>>> pid)
>>> will hang unless there is an actual user space process to service
>>> the
>>> callback.
>>>
>>> Although I don't know the flow of things that might be important at
>>> some point.
>>>
>>> And if the mount is set catatonic the process needs to set the
>>> pipefd
>>> to take "ownership" which also clears the mount catatonic flag.
>> The migration is already implemented and sent to CRIU mailing list.
>> Here is the list, if you are interesting (I use kernel with this
>> patch
>> applied):
>> https://lists.openvz.org/pipermail/criu/2016-January/024749.html
> ok, I'll try and have a look although I'm pressed for time so I'm not
> sure I'll spend much time on it.
>
> In any case the project needs to do what it thinks best so my only re=
al
> concern is to try and alert you to possible problems.

Thanks for the alerts.
Should I move this option to the end of the list to preserve the sequen=
ce?

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
