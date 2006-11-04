From: Ian Kent <raven@themaw.net>
Subject: Re: automount errors under high load
Date: Sat, 04 Nov 2006 10:04:03 +0800
Message-ID: <1162605843.25017.19.camel@localhost>
References: <200611032327.kA3NRBRG018474@cs.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200611032327.kA3NRBRG018474@cs.utexas.edu>
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
To: Fletcher Mattox <fletcher+autofs@cs.utexas.edu>
Cc: autofs@linux.kernel.org

On Fri, 2006-11-03 at 15:22 -0600, Fletcher Mattox wrote:

> I have also noticed corruption of /etc/mtab.  Sometimes static mounts
> just disappear from it during busy times.  I assume this is some type
> of race condition where file locking fails.  I do not know if this is
> the same problem or a different problem, but I thought I would mention it.

If you see this type of corruption then you need to check if mount(8)
locking is broken or not and if the autofs package you are using has the
locking at mount time disabled.

Have a look at
http://www.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4-configureable-locking.patch
for more information.

> 
> I do not know what causes such a high load of mount requests.  But I see
> them in the accounting files.  Nothing obvious is going on when the errors
> occur.  They happen for several seconds at a time, 6-8 times per day.
> 
> The NFS client is ubuntu 6.06 (dapper), kernel 2.6.17.4, automount 4.1.4.
> The NFS server is a Network Appliances filer.
> 
> Thanks,
> Fletcher
> 
> Nov  2 08:41:09 smtp automount[3862]: handle_child: got pid 15301, sig 0 (0), stat 0 
> Nov  2 08:41:09 smtp automount[3862]: sig_child: found pending iop pid 15301: signalled 0 (sig 0), exit status 0
> Nov  2 08:41:09 smtp automount[3862]: send_ready: token=4324 
> Nov  2 08:41:11 smtp automount[3862]: handle_packet: type = 0 
> Nov  2 08:41:11 smtp automount[3862]: handle_packet_missing: token 4325, name v2q007 
> Nov  2 08:41:11 smtp automount[3862]: attempting to mount entry /v/filer3/v2q007
> Nov  2 08:41:11 smtp automount[15326]: lookup(yp): looking up v2q007
> Nov  2 08:41:11 smtp automount[15326]: ret = 1
> Nov  2 08:41:11 smtp automount[15326]: lookup(yp): v2q007 -> -intr,grpid,quota,retry=2^Ifiler3:/vol/vol2/v2q007
> Nov  2 08:41:11 smtp automount[15326]: parse(sun): expanded entry: -intr,grpid,quota,retry=2^Ifiler3:/vol/vol2/v2q007
> Nov  2 08:41:11 smtp automount[15326]: parse(sun): dequote("intr,grpid,quota,retry=2") -> intr,grpid,quota,retry=2
> Nov  2 08:41:11 smtp automount[15326]: parse(sun): gathered options: tcp,rsize=8192,wsize=8192,intr,grpid,quota,retry=2
> Nov  2 08:41:11 smtp automount[15326]: parse(sun): dequote("filer3:/vol/vol2/v2q007") -> filer3:/vol/vol2/v2q007
> Nov  2 08:41:11 smtp automount[15326]: parse(sun): core of entry: options=tcp,rsize=8192,wsize=8192,intr,grpid,quota,retry=2, loc=filer3:/vol/vol2/v2q007
> Nov  2 08:41:11 smtp automount[15326]: parse(sun): mounting root /v/filer3, mountpoint v2q007, what filer3:/vol/vol2/v2q007, fstype nfs, options tcp,rsize=8192,wsize=8192,intr,grpid,quota,retry=2 
> Nov  2 08:41:11 smtp automount[15326]: mount(nfs): root=/v/filer3 name=v2q007 what=filer3:/vol/vol2/v2q007, fstype=nfs, options=tcp,rsize=8192,wsize=8192,intr,grpid,quota,retry=2
> Nov  2 08:41:11 smtp automount[15326]: mount(nfs): nfs options="tcp,rsize=8192,wsize=8192,intr,grpid,quota,retry=2", nosymlink=0, symlink=0, ro=0
> Nov  2 08:41:11 smtp automount[15326]: mount(nfs): is_local_mount: filer3:/vol/vol2/v2q007
> Nov  2 08:41:11 smtp automount[15326]: mount(nfs): from filer3:/vol/vol2/v2q007 elected filer3:/vol/vol2/v2q007
> Nov  2 08:41:11 smtp automount[15326]: mount(nfs): calling mkdir_path /v/filer3/v2q007
> Nov  2 08:41:11 smtp automount[15326]: mount(nfs): calling mount -t nfs -s  -o tcp,rsize=8192,wsize=8192,intr,grpid,quota,retry=2 filer3:/vol/vol2/v2q007 /v/filer3/v2q007
> Nov  2 08:41:11 smtp automount[15326]: >> mount: filer3:/vol/vol2/v2q007: can't read superblock

A message from mount, probably caused by the port exhaustion you
described elsewhere.

> Nov  2 08:41:11 smtp automount[15326]: mount(nfs): nfs: mount failure filer3:/vol/vol2/v2q007 on /v/filer3/v2q007
> Nov  2 08:41:11 smtp automount[15326]: failed to mount /v/filer3/v2q007
> Nov  2 08:41:11 smtp automount[15326]: umount_multi: path=/v/filer3/v2q007 incl=1 
> Nov  2 08:41:11 smtp automount[15326]: umount_multi: no mounts found under /v/filer3/v2q007
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
