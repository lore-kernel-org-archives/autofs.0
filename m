From: "Kevin Muller" <k.muller@sideshowdigital.com>
Subject: Re: autofs / davfs
Date: Mon, 21 May 2007 16:09:05 +0300
Message-ID: <4104f1cf0705210609s6d6f3f9cxca8c32f47fc27ef@mail.gmail.com>
References: <4104f1cf0705170218ua2b6bbdu8f1456193741cd65@mail.gmail.com>
	<4104f1cf0705172308pdd3a3f9l4b4a558e290bebbc@mail.gmail.com>
	<x49zm428auy.fsf@segfault.boston.devel.redhat.com>
	<4104f1cf0705180737o4de54aa9wf2e73de733dc446b@mail.gmail.com>
	<x49sl9u8a3k.fsf@segfault.boston.devel.redhat.com>
	<4104f1cf0705210043y66c2ff79qd1f39792c49e0e6@mail.gmail.com>
	<m34pm6qrcy.fsf@redhat.com>
	<4104f1cf0705210552j866818yf0188c2c5d5e584a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4104f1cf0705210552j866818yf0188c2c5d5e584a@mail.gmail.com>
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
To: autofs@linux.kernel.org

The weird part is that the filesystem driver actually loads correctly,
then autofs hangs when control is returned.

I purposely set the davfs to use the coda device, and the coda device
is not functional, so it falls back to the fuse device. The advantage
of that, is that is gives some feedback to what is happening.

extract from log:

May 21 15:56:21 devaccess automount[32663]: lookup_mount:
lookup(file): looking up web.site.com
May 21 15:56:21 devaccess automount[32663]: lookup_mount:
lookup(file): web.site.com -> -fstype=davfs
http://v6.muglets.com.dev/repos
May 21 15:56:21 devaccess automount[32663]: parse_mount: parse(sun):
expanded entry: -fstype=davfs      http://v6.muglets.com.dev/repos
May 21 15:56:21 devaccess automount[32663]: parse_mount: parse(sun):
gathered options: fstype=davfs
May 21 15:56:21 devaccess automount[32663]: parse_mount: parse(sun):
dequote("http://v6.muglets.com.dev/repos") ->
http://v6.muglets.com.dev/repos
May 21 15:56:21 devaccess automount[32663]: parse_mount: parse(sun):
core of entry: options=fstype=davfs,
loc=http://v6.muglets.com.dev/repos
May 21 15:56:21 devaccess automount[32663]: sun_mount: parse(sun):
mounting root /home/automount, mountpoint web.site.com, what
http://v6.muglets.com.dev/repos, fstype davfs, options
May 21 15:56:21 devaccess automount[32663]: open_mount: (mount):cannot
open mount module davfs (/usr/lib/autofs/mount_davfs.so: cannot open
shared object file: No such file or directory)
May 21 15:56:21 devaccess automount[32663]: do_mount:
http://v6.muglets.com.dev/repos /home/automount/web.site.com type
davfs options  using module generic
May 21 15:56:21 devaccess automount[32663]: mount_mount:
mount(generic): calling mkdir_path /home/automount/web.site.com
May 21 15:56:21 devaccess automount[32663]: mount_mount:
mount(generic): calling mount -t davfs http://v6.muglets.com.dev/repos
/home/automount/web.site.com
May 21 15:56:22 devaccess automount[32663]: >> /sbin/mount.davfs: no
free coda device to mount
May 21 15:56:22 devaccess automount[32663]: >> /sbin/mount.davfs:
trying fuse kernel file system
May 21 15:56:22 devaccess automount[32663]: >> /sbin/mount.davfs: fuse
device opened successfully

From this I deduce that the modules load, and the file system is put
in place, and the autofs hangs before control is returned.

- kevin
