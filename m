From: Dannie Stanley <dannie.stanley@gmail.com>
Subject: autofs timeout and large map
Date: Mon, 31 Oct 2005 12:04:45 -0500
Message-ID: <89e9feae0510310904u389dc003mc311a1f0a1058168@mail.gmail.com>
References: <20051028163028.75072c9b.akpm@osdl.org>
	<Pine.LNX.4.63.0510291032450.2075@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0510291032450.2075@donald.themaw.net>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org
Cc: Ian Kent <raven@themaw.net>

Ian Kent has pointed me to this list.  I have included my original
message thread posted to linux-kernel (sorry for the incorrect
posting).  Here are my answers to Ian's specific questions:

> Distribution?
$ cat /etc/redhat-release
Red Hat Enterprise Linux AS release 3 (Taroon Update 6)

> Your version of autofs?
$ rpm -q autofs
autofs-4.1.3-154

> Kernel version?
$ uname -a
Linux ... 2.4.21-37.EL #1 Wed Sep 7 13:35:21 EDT 2005 i686 i686 i386 GNU/Linux

> Have any autofs4 patches been applied to your kernel?
Standard packaged RedHat kernel, no patches.

> What do you have in your master map?
$ cat /etc/auto.master
#/- /etc/auto.virtual --ghost
/- /etc/auto.virtual

> Then you have 1345 offset mount (multi-mount) entries similar to the
> one above. Each with two offsets. Correct?
True.

> How many automount processes end up running after starting autofs?
Two...
$ ps -fC automount |cut -c49-200
CMD
/usr/sbin/automount --timeout=86400 /- file /etc/auto.virtual
/usr/sbin/automount --submount --timeout=86400 /virtual file /etc/auto.virtual


Thanks for your help!
Dannie



---------- Forwarded message ----------
From: Ian Kent <raven@themaw.net>
Date: Oct 28, 2005 10:13 PM
Subject: Re: Fw: autofs timeout and large map
To: Dannie Stanley <dannie.stanley@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>



Thanks for forwarding this Andrew.

On Fri, 28 Oct 2005, Andrew Morton wrote:

>
> fyi..
>
> Begin forwarded message:
>
> Date: Fri, 28 Oct 2005 15:28:05 -0500
> From: Dannie Stanley <dannie.stanley@gmail.com>
> To: linux-kernel@vger.kernel.org
> Subject: autofs timeout and large map

Hi Dannie.

The best place for this query is the autofs list at:
http://linux.kernel.org/mailman/listinfo/autofs

We probably don't need to clutter Andrews inbox further with this thread.
I'm sure he has more than enough to deal with.

>
>
> I think I may have discovered a bug.  But perhaps I overlooked
> something -- looking for advice.

Perhaps but lets work through it and see.

I some more information about your environment.

Distribution?
Your version of autofs?
Kernel version?
Have any autofs4 patches been applied to yuor kernel?

>
> I have generated a DIRECT map file and defined it in /etc/auto.master.
>  My direct mappings look like this (located in /etc/auto.virtual):
>
>    /virtual/USERNAME \
>       /public --bind 127.0.0.1:/usr/local/files/public \
>       /private --bind 127.0.0.1:/usr/local/files/USERNAME
>
> My /etc/auto.virtual file has 1345 entries very similar to the example
> provided  (not wrapped like the example above).  Everything works like
> expected for the first mount.  When the mount timeout expires,  the
> mount will not auto remount.  When I try to `ls`, it gives the error:

First, the handling of the --bind option might not parse very well.
I think that the option will end up being specified twice for the mount
command. Likely not a problem but it is not needed as autofs checks if
the mount is local and should automatically call mount with the bind
option.

I'd like to understand you automount maps a little more clearly.

What do you have in your master map?
I guess a line that starts with "/-" and specifies "auto.virtual" as the
map file. Correct me if I'm wrong.

Then you have 1345 offset mount (multi-mount) entries similar to the
one above. Each with two offsets. Correct?

How many automount processes end up running after starting autofs?
If I'm correct there should one process handling the /virtual directory.

I know that's not the way it should work but that's being addressed.

>
>    "No such file or directory"
>
> When --ghost is enabled most directories look like this when autofs
> first starts:
>
>    drwxrwxr-x    2 virtual  virtual      4096 Oct 28 14:45 private
>
> However after the timeout they look like this:
>
>    dr-xr-xr-x    2 root root      0 Oct 28 14:45 private

Nothing wrong with this.

When a filesystem is mounted on a directory you should see the attributes
of the mounted filesystem.

When the mount goes away you will see the attributes of the directory as
it is within the autofs pseudo filesystem.

>
> Once I restart autofs it mounts again fine the first time.  For now I
> have set my timeout to 24 hours which functions as a work-around but
> clutters up my mounted filesystems.
>
> My system is in production and I can't recreate the problem right now
> lest I interrupt users.  I have done my best to recreate the actual
> directory listings and error messages that I saw but they may not 100%
> accurate as they are from memory.

That's cool but we will need to collect a debug log. I'll be able to offer
more advice when I know what version of autofs you are running.

Perhaps we can duplicate this on another non production system.

>
> "The Feynman Problem-Solving Algorithm: (1) write down the problem;
> (2) think very hard; (3) write down the answer." - Murray Gell-Mann

I wish I could do that.

Ian



--
Dannie M. Stanley

"The Feynman Problem-Solving Algorithm: (1) write down the problem;
(2) think very hard; (3) write down the answer." - Murray Gell-Mann
