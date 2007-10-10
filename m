From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] nested mounts with loop
Date: Wed, 10 Oct 2007 12:19:47 +0800
Message-ID: <1191989987.3151.6.camel@raven.themaw.net>
References: <n7xir5ybts0.fsf@sor.suse.de>
	<1191819321.3129.12.camel@raven.themaw.net>
	<n7xsl4l23ka.fsf@sor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <n7xsl4l23ka.fsf@sor.suse.de>
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
To: Matthias Koenig <mkoenig@suse.de>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Mon, 2007-10-08 at 14:28 +0200, Matthias Koenig wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> Hmm, with the above setup, I am only able to access the content after I
> have triggered the mount of the image separately.
> 
> giuliani:/ # ls /cdcontent/foo
> ls: cannot open directory /cdcontent/foo: No such file or directory
> giuliani:/ # ls /cdimage/foo/
> [...]
> giuliani:/ # ls /cdcontent/foo
> ARCHIVES.gz     dosutils                          INDEX.gz
> [...]

Yep, reproduced and verified our approach fixes the problem.

> 
> Here is the log of the failure:
> Oct  8 14:25:17 giuliani automount[16597]: lookup_mount: lookup(file): looking up foo
> Oct  8 14:25:17 giuliani automount[16597]: lookup_mount: lookup(file): foo -> -fstype=auto,loop,ro :/cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso
> Oct  8 14:25:17 giuliani automount[16597]: parse_mount: parse(sun): expanded entry: -fstype=auto,loop,ro :/cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso
> Oct  8 14:25:17 giuliani automount[16597]: parse_mount: parse(sun): gathered options: fstype=auto,loop,ro
> Oct  8 14:25:17 giuliani automount[16597]: parse_mount: parse(sun): dequote(":/cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso") -> :/cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso
> Oct  8 14:25:17 giuliani automount[16597]: parse_mount: parse(sun): core of entry: options=fstype=auto,loop,ro, loc=:/cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso
> Oct  8 14:25:17 giuliani automount[16597]: sun_mount: parse(sun): mounting root /cdcontent, mountpoint foo, what /cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso, fstype auto, options loop,ro
> Oct  8 14:25:17 giuliani automount[16597]: open_mount: (mount):cannot open mount module auto (/usr/lib/autofs/mount_auto.so: cannot open shared object file: No such file or directory)
> Oct  8 14:25:17 giuliani automount[16597]: do_mount: /cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso /cdcontent/foo type auto options loop,ro using module generic
> Oct  8 14:25:17 giuliani automount[16597]: mount_mount: mount(generic): calling mkdir_path /cdcontent/foo
> Oct  8 14:25:17 giuliani automount[16597]: mount_mount: mount(generic): calling mount -t auto -s -o loop,ro /cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso /cdcontent/foo

Aaha .. now I get it!

This type of request calls the generic mount module which, in turn calls
spawn_mount which leads to the problem.

> Oct  8 14:25:17 giuliani automount[16597]: >> /cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso: No such file or directory
> Oct  8 14:25:17 giuliani automount[16597]: mount(generic): failed to mount /cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso (type auto) on /cdcontent/foo
> Oct  8 14:25:17 giuliani automount[16597]: send_fail: token = 61
> Oct  8 14:25:17 giuliani automount[16597]: failed to mount /cdcontent/foo

I will need to do more testing before committing the change but it
should be fine.

Thanks
Ian
