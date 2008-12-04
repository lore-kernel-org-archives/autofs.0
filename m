From: Martin Vogt <vogt@itwm.fraunhofer.de>
Subject: Re: more than 1024 mounts ==>hangs
Date: Thu, 04 Dec 2008 17:01:22 +0100
Message-ID: <4937FED2.2040603@itwm.fraunhofer.de>
References: <4937D794.6040908@itwm.fraunhofer.de>
	<1228403765.3038.118.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1228403765.3038.118.camel@zeus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


Hello Ian,

Ian Kent wrote:
> On Thu, 2008-12-04 at 14:13 +0100, Martin Vogt wrote:
>>
>> I'm currently experimenting with autofs on SuSE 11.1 rc1
>>
>> -autofs-5.0.3-82.19
> 
> I don't know what this means in terms of patches applied, but ok.

Just checked the source rpm from suse:

autofs-5.0.3.tar.bz2

patches:
autofs-5.0.3-upstream-patches-20080806.bz2
autofs-5.0.1-mount_xdr_no_strict_aliasing.patch
autofs-5.0.2-use_local_cflags.patch
autofs-5.0.3-link_kerberos.patch

But I can use an offical release, if you think this is usefull...

> So a direct map?
> With many active real mounts, is that what you're saying?

Yes.
I have a bunch of fileservers here, which I like to have
mounted under /net/fileserver<XYZ>/

Upon this I have a "virtual filesystem"

/homes/auser0001
/homes/buser0001
...
/homes/yuser1999
/homes/zvogt2000

(which holds all users from all fileserver ~500)

Then I have another virtual filesytem, which groups the
users by departments.

eg
/dep/foo/auser0001
/dep/foo/buser0002
[..]
/dep/bar/yuser1999
/dep/bar/zvogt2000

Thus I hit 1000 mounts (500 in homes and 500 grouped in departements--
all bind mounts from /net)

==> 1000 mounts in the case a user issuses a find / for example

Then I have some other fileservers etc... Jumping over 1024 mounts easily...

The mount maps are all direct:
auto.master:

/-      /etc/auto.user
/-      /etc/auto.homes
/-      /etc/auto.deps
/-      /etc/auto.misc

sample auto.homes:

/homes/vogt -fstype=bind,ro :/net/fs42/home/user/vogt

and auto.deps is

/dep/it/vogt -fstype=bind,ro :/net/fs42/home/user/vogt

I didnt find out how to make it without bind mounts.

==> dont know if there is a more elegant solution :(

Around the 1024 mounts I then hit the problem.

>> The 1024 really looks like some limit, which is hit by the automount
>> process.
> 
> Quite possibly, but I don't think there is anything autofs can do about
> it since in autofs we see:
> ...
> #define MAX_OPEN_FILES          10240

Yes. I think autofs has enough FDs, but the 1024 looks suspicious,
I simply have no clue how to debug it.

> 
> Unless I've not got this correct in some way the open file limit should
> be much higher. But there are ways the OS configuration can limit this.
> 
The proc entry for the automount process should give the real constrains
for the process:

>>
>>
>> The I checked ulimit under /proc:
>>
>> pxe1:/proc/5111 # cat limits
>> Limit                     Soft Limit           Hard Limit           Units
>> Max cpu time              unlimited            unlimited
>> Max file size             unlimited            unlimited
>> Max data size             unlimited            unlimited
>> Max stack size            8388608              unlimited
>> Max core file size        unlimited            unlimited
>> Max resident set          1758904320           unlimited
>> Max processes             16117                16117
>> Max open files            10240                10240
>> Max locked memory         65536                262144
>> Max address space         2514452480           unlimited
>> Max file locks            unlimited            unlimited
>> Max pending signals       16117                16117
>> Max msgqueue size         819200               819200
>> Max nice priority         0                    0
>> Max realtime priority     0                    0
>> Max realtime timeout      unlimited            unlimited
>>


> So maybe mount(8) and its relatives are the problem, not sure I can do
> much about that either.

The mount process which gets the exec from automount is a zombie process
when it hangs.

>root      9541  0.0  0.0      0     0 pts/0    Z+   13:31   0:00
>[mount] <defunct>


When the compo autofs/mount hangs, I can still issue a bind mount
on the command line, with success.

eg:

mount -t bind /net/fs42/home/user/vogt /mnt/tmp1

works.

(Because of this still working, I think that the problem is more on the
autofs side)

Do you think the source for "mount" could be helpfull?
(Maybe adding some syslogs/printfs to the mount code?)


regards,

Martin
