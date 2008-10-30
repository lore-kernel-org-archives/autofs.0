From: "Steve Linn" <steve.linn@gmail.com>
Subject: Re: Read-only map
Date: Wed, 29 Oct 2008 17:11:45 -0700
Message-ID: <3ddb09290810291711k1c3980bfjb65dcd2f517c9d48@mail.gmail.com>
References: <49087C73.6080502@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49087C73.6080502@s3group.cz>
Content-Disposition: inline
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

We had the same problem.  The kernel we were running had a
"feature" where if the client mounts the same server and directory
it would bind them together.  You would get RO or RW depending
on which directory was mounted first.  You might be able to
trick the client by making multiple addresses on the server
and mounting one IP address for reads and one for writes
or TCP and UDP?

I think that this "feature" was added because of machines
running out of reserved ports.  BTW, I have a patch for the reserved
ports.  Anyways, I guess you could verify that you are
seeing the same behavior by doing something like:

Mount the same thing twice first time RO
# mkdir  -p /mnt/test1 /mnt/test2
# mount -o ro lid40:/etc /mnt/test1
# mount -o rw lid40:/etc /mnt/test2

Both appear RO.
# touch /mnt/test1/passwd
touch: cannot touch `/mnt/test1/passwd': Read-only file system
# touch /mnt/test2/passwd
touch: cannot touch `/mnt/test2/passwd': Read-only file system

Remount them again RW first and see that they both are RW.
# umount /mnt/test1 /mnt/test2
# mount -o rw lid40:/etc /mnt/test1
# mount -o ro lid40:/etc /mnt/test2
# touch /mnt/test1/passwd
# touch /mnt/test2/passwd

This problem does not appear to be caused at all by autofs.
It seems to be a problem/feature of the NFS client.

Steve

On Wed, Oct 29, 2008 at 8:08 AM, Ondrej Valousek <webserv@s3group.cz> wrote:
> Hi List,
>
> I have a problem:
> My system (client, server) RHEL 5.2, latest updates.
> 1. NFS server is exporting read/write share
> 2. NIS automount map point to that share, but in read only like "key -ro
> nfsserver:/share/key"
>
> Now, the "strange" thing is that on clients that share is mounted read
> only, fine, but when I go to the nfsserver itself, the share is mounted
> read write. I understand this is because mount --bind is used instead of
> nfs for performance reasons, but this way we lose the -ro flag.
> Is there any simple solution to this?
> Thanks,
>
>
> Ondrej
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
