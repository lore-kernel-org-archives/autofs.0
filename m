From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: basic SOHO NFS/autofs setup for noob help
Date: Wed, 02 Jan 2008 13:58:12 -0500
Message-ID: <x49lk7812d7.fsf@segfault.boston.devel.redhat.com>
References: <9b72f9a90801021042m65d350ak5467b4c500d94933@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <9b72f9a90801021042m65d350ak5467b4c500d94933@mail.gmail.com>
	(Jerzy Jalocha N.'s message of "Wed\,
	2 Jan 2008 12\:42\:14 -0600")
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
To: Jerzy Jalocha N <jjalocha@gmail.com>
Cc: autofs@linux.kernel.org

"Jerzy Jalocha N" <jjalocha@gmail.com> writes:

> Hi, I am trying to set-up the following (simple?) configuration:
>  * one server which has a mounted partition (/shared) exported with
> NFS. This holds some files (office, etc) which will be shared by all
> users.
>  * a few (4) clients which should autofs this partition as '/shared'.
>
> I am able to manually mount the partition on the clients:
>  $ sudo mount 192.168.1.20:/shared /shared
> And I am able to mount with fstab. (That's how it's running now.)
>
> But I am unable to automount. Whatever the combinations of options I
> try ('ls /shared/', or 'ls /shared/subdir', or 'cd /shared : ls'), it
> shows nothing.
>
> I guess, It has to do with the combination of
> mounting/exporting/autofs options, but I don't really know how to
> debug this part.
>
> This is how I've set it up right now:
>
>  * server:/etc/fstab
>  /dev/sdb1 /shared ext3 rw,sync,suid,nodev,exec,auto,nouser 0 3
>
>  * server:/etc/exports
>  /shared 192.168.1.0/24(rw,sync,no_root_squash,no_subtree_check)
>
>  * client:/etc/auto.master
>  shared 192.168.1.20:/shared --ghost --timeout=60

Try:

auto.master:
/shared	/etc/auto.shared

/etc/auto.shared:
*	-hard,intr	192.168.1.20:/shared/&

Cheers,

Jeff
