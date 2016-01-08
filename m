From: Stanislav Kinsburskiy <skinsbursky@odin.com>
Subject: Re: [PATCH] autofs: show pipe inode in mount options
Date: Fri, 8 Jan 2016 12:29:09 +0100
Message-ID: <568F9D85.6070601@odin.com>
References: <20151216120222.19097.54512.stgit@localhost.localdomain>
 <568E8840.3010801@odin.com> <1452237640.2973.19.camel@themaw.net>
Reply-To: <skinsbursky@virtuozzo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1452237640.2973.19.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Ian Kent <raven@themaw.net>, skinsbursky@virtuozzo.com
Cc: criu@openvz.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>



08.01.2016 08:20, Ian Kent =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Thu, 2016-01-07 at 16:46 +0100, Stanislav Kinsburskiy wrote:
>> Good day, gentlemen.
>>
>> Could you update, what's the status with this patch?
>> Without it it's impossible to match process pipe with kernel pipe,
>> while
>> this is "must have" to be able to migrate AutoFS via CRIU.
> Right, I did mean to reply to this mail but have been distracted by
> family stuff.
>
> I don't know what CRIU is and people looking at changelog entries
> shouldn't need to do a web search to find out.
>
> Could you change it a little.

=46air enough. I'll resend with more descriptive message.
But first I would like to clarify to you the problem root and why it's=20
done like this.

> I'm also not sure whether to forward this (assuming the description i=
s
> updated a little) to Al or to include it in the series to rename
> autofs4 to autofs that I'm hoping to ask be included in linux-next
> fairly soon.

Here I don't know, what's better. Of course Al can take it as well. But=
,=20
probably, first would be nice to make sure, that this solution is the=20
best one.
Description of the problem is below.

> Passing it on to Al will likely interfere with the series coming from
> linux-next so that could be bit of a hassle.
>
> Another thing I'm wondering about is the order this entry will appear
> at in the options. You order choice is sensible though and autofs
> shouldn't have a problem with the inserted option but other
> applications might.

I should put it at the end, probably?

> Finally, and perhaps most importantly, I don't get what your trying t=
o
> do, you also haven't given any clues to that in the patch dscription.
>
> IOW how do you expect to use this.
>
>>
>> 16.12.2015 13:02, Stanislav Kinsburskiy =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:
>>> This is required for CRIU to migrate a mount point, when write end
>>> in user
>>> space is closed.
> Like I said what does this mean.
>
> autofs doesn't need this when it re-constructs a mount tree from
> existing mounts on re-start or after a SIGKILL on the automount
> process.
>
> How is this different and how will it be used?
>
> The question to be answered here is "is this the best way to do it an=
d
> will it work for the autofs mount types you expect it to"?

So, here is a brief description of the problem.
To migrate autofs mount, one have to reconstruct control pipe between=20
kernel and autofs master.
There are two cases I'm wiling to support:
1) Automount binary (autofs package). This program is very gentle and i=
t=20
doesn't close write end of the pipe after mount.
2) Systemd. This program closes write end of the pipe once the mount is=
=20
done.

The autofs restore concept is the following:
1) Mount autofs from some process with some dummy pipe.
2) Fix it's pgrp, pipe fd, timeout, etc on top of existent mount in the=
=20
right master later (this is because of implementation of CRIU mounts=20
restore, where all of them are created by one process).
What is the most important here, is that during pipe reconstruction,=20
read end of it have to be placed _exactly_ on the file descriptor, whic=
h=20
process has before, thus allowing to autofs master still can play it's=20
role after migration.

To be able to reconstruct control pipe, one must know _exactly_ on=20
_dump_ stage, which descriptor in autofs master corresponds to read end=
=20
of the pipe, because this pipe have to be empty, because we can't (and=20
don't want to) transfer some interim state in the kernel via userspace=20
migration solution.
In case of systemd, this write end is already closed, so searching for=20
the read end is not possible.
In case of automount write end is still there (with the same fd as in=20
mount options), but one can't be sure, that this descriptor is connecte=
d=20
to file structure, which is used by kernel. There can be another pipe=20
end (for example, in case of systemd).

Thus, to be able to find read end of the pipe in autofs master, some=20
other mark is required.
The best solution is to use pipe inode number, which allows to match=20
opened pipes in a process with 100% reliability.
And the easies solution I found is to expose this number is autofs moun=
t=20
options.
If you have another better solution, I would be glad to implement it.

Hope, the above explains the problem clearly.

>>> To be able to migrate such mount, read end of the pipe have to be
>>> searched
>>> within autofs master process, and pipe inode will be used as a key.
>>>
>>> Signed-off-by: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
>>> ---
>>>    fs/autofs4/inode.c |    4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
>>> index a3ae0b2..16f875a 100644
>>> --- a/fs/autofs4/inode.c
>>> +++ b/fs/autofs4/inode.c
>>> @@ -77,6 +77,10 @@ static int autofs4_show_options(struct seq_file
>>> *m, struct dentry *root)
>>>    		return 0;
>>>   =20
>>>    	seq_printf(m, ",fd=3D%d", sbi->pipefd);
>>> +	if (sbi->pipe)
>>> +		seq_printf(m, ",pipe_ino=3D%ld", sbi->pipe->f_inode
>>> ->i_ino);
>>> +	else
>>> +		seq_printf(m, ",pipe_ino=3D-1");
>>>    	if (!uid_eq(root_inode->i_uid, GLOBAL_ROOT_UID))
>>>    		seq_printf(m, ",uid=3D%u",
>>>    			from_kuid_munged(&init_user_ns,
>>> root_inode->i_uid));
>>>

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
