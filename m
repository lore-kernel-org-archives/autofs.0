From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: AutoFS5
Date: Tue, 14 Aug 2007 16:48:31 -0400
Message-ID: <x49ir7h971c.fsf@segfault.boston.devel.redhat.com>
References: <46C2005D.1090907@cs.ou.edu>
	<x498x8daovy.fsf@segfault.boston.devel.redhat.com>
	<x49vebh98nd.fsf@segfault.boston.devel.redhat.com>
	<46C212FA.7030201@cs.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46C212FA.7030201@cs.ou.edu> (Jim Summers's message of "Tue\,
	14 Aug 2007 15\:39\:22 -0500")
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
To: jsummers@bachman.cs.ou.edu
Cc: autofs@linux.kernel.org, steved@redhat.com

Jim Summers <jsummers@bachman.cs.ou.edu> writes:

> Jeff Moyer wrote:
>> Jeff Moyer <jmoyer@redhat.com> writes:
>>
>>> Jim Summers <jsummers@bachman.cs.ou.edu> writes:
>>>
>>>> Hello All,
>>>>
>>>> Just hit a hiccup with autofs5.  Everything was going along fine
>>>> and then had a user call and say they could not get their home on
>>>> a machine.  I did some quick checking and some mounts were working
>>>> and others not.  below is a bit of the debug log and some other
>>>> info.  the user, gerardo is the one who called me.  entries in the
>>>> debug log for him are the same as the tmac user.  in that it get
>>>> his ldap info tries to mount but then says it is already mounted
>>>> and then fails????
>>>>
>>>> client machine is FC6 hand compiled autofs version:
>>>> autofs-5.0.1-20
>>>> autofs-debuginfo-5.0.1-20
>>>> with a patch from Ian.
>>> What is the kernel version on the client?
>
> 2.6.22.1-32.fc6
>
>>
>> I'm guessing that you have 2.6.22.1-13.fc6 or later installed.  These
>> kernels include the "nosharecache" patch for NFS.  This patch can
>> cause some mounts to fail with -EBUSY.  You can revert the
>> nosharecache patch to get the old behaviour back.
>
> is this accomplished with boot option similar to 'noacpi' or something like that?

Oh, yeah, if you update nfs-utils, you should get access to the
nosharecache mount option.  You can probably specify this globally in
your /etc/sysconfig/autofs file.  OPTIONS="-nosharecache", I think.

>> Could you let us know what nfs mount options are used for your maps,
>> though, as this should only bite you if you try to mount from the same
>> server file system with different sets of mount options.  In other
>> words, your first mount from the server should succeed, successive
>> mount attempts of the same file system with differring options will
>> fail.
>
> options:
>
> amarak:
> -rw,rsize=4096,wsize=4096
> here is tmac:
>  -rw,actimeo=60,rsize=32768,wsize=32768,nocto
> here is gerardo:
> -rw,rsize=8192,wsize=8192
> here is granville:
> -rw,rsize=4096,wsize=4096
> jsummers:
> -rw,actimeo=60,rsize=32768,wsize=32768,nocto

So, these days superblocks are shared when mounting the same remote
file system.  As such, when you mount the first export it defines the
mount options that will be used for subsequent mounts that come from
the same file system.

This is a change in behaviour from what we've had in the past, and
there is still ongoing discussion as to how we should resolve the
issue.

> some results:
> [root@saturn ~]# su - jsummers
> [jsummers@saturn ~]$ exit
> logout
> [root@saturn ~]# su - tmac
> su: warning: cannot change directory to /home/tmac: No such file or directory
> -bash-3.1$ exit
> logout

Interesting.  I thought that this one would have worked.  If you can
provide a debug log, we can probably get to the bottom of this.  It
would also be interesting to know what the contents of /proc/mounts
was before each of these commands was run.

For information on collecting a debug log, you can consult my people
page:
  http://people.redhat.com/jmoyer/

> [root@saturn ~]# su - granville
> saturn@~> logout
> [root@saturn ~]# su - amarack
> saturn@~> logout
> [root@saturn ~]# su - gerardo
> su: warning: cannot change directory to /home/gerardo: No such file or directory
> -bash-3.1$ logout
>
> weird, huh?

Definitely.  Try the nosharecache mount option.  If that resolves the
problem, I'm not quite as interested in looking at the debug log.

Thanks!

Jeff
