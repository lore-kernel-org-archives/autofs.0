From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: Read-only map
Date: Thu, 30 Oct 2008 18:28:18 +0100
Message-ID: <4909EEB2.8040100@s3group.cz>
References: <49087C73.6080502@s3group.cz>	
	<3ddb09290810291711k1c3980bfjb65dcd2f517c9d48@mail.gmail.com>	
	<x49prliyzrb.fsf@segfault.boston.devel.redhat.com>
	<3ddb09290810301023h4cf0e769w9b9ad8e396e3df0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3ddb09290810301023h4cf0e769w9b9ad8e396e3df0d@mail.gmail.com>
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
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

I tried on RHEL 5.2 and it works, too.
But it still does not work with the automounter - still does the mount
--bind (probably)....
Ondrej


Steve Linn wrote:
> Interesting.  I tried it on a Suse 9,3, Open Suse 10.3 kernel and
> an earlier RHEL and they failed.  Opensuse 11 works though.
>
> root@fid1 ~]$ mount -o ro lid40:/etc /mnt/test1
> [root@fid1 ~]$ mount -o rw lid40:/etc /mnt/test2
> [root@fid1 ~]$ touch /mnt/test2/passwd
> touch: cannot touch `/mnt/test2/passwd': Read-only file system
> [root@fid1 ~]$ cat /proc/version
> Linux version 2.6.9-34.0.1.EL.ADSKsmp (root@strasbourg) (gcc version
> 3.4.4 20050721 (Red Hat 3.4.4-2)) #1 SMP Tue Aug 12 21:24:17 EDT 2008
> [root@fid1 ~]$ cat /etc/redhat-release
> Red Hat Enterprise Linux WS release 4 (Nahant Update 3)
>
>
> suse11build /root# mount -o ro lid40:/etc /mnt/test1
> suse11build /root# mount -o rw lid40:/etc /mnt/test2
> suse11build /root# touch /mnt/test2/passwd
> suse11build /root# cat /proc/version
> Linux version 2.6.25.9-0.2-pae (geeko@buildhost) (gcc version 4.3.1
> 20080507 (prerelease) [gcc-4_3-branch revision 135036] (SUSE Linux) )
> #1 SMP 2008-06-28 00:00:07 +0200
>
> suse11build /root# cat /etc/SuSE-release
> openSUSE 11.0 (i586)
> VERSION = 11.0
>
> Sorry about that,
> Steve
>
> On Thu, Oct 30, 2008 at 6:32 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
>   
>> "Steve Linn" <steve.linn@gmail.com> writes:
>>
>>     
>>> We had the same problem.  The kernel we were running had a
>>> "feature" where if the client mounts the same server and directory
>>> it would bind them together.  You would get RO or RW depending
>>>       
>> The RHEL 5.2 kernel does not have that issue.
>>
>> Cheers,
>>
>> Jeff
>>
>>     
