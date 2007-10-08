From: Matthias Koenig <mkoenig@suse.de>
Subject: Re: [PATCH] nested mounts with loop
Date: Mon, 08 Oct 2007 14:28:37 +0200
Message-ID: <n7xsl4l23ka.fsf@sor.suse.de>
References: <n7xir5ybts0.fsf@sor.suse.de>
	<1191819321.3129.12.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1191819321.3129.12.camel@raven.themaw.net> (Ian Kent's message
	of "Mon\, 08 Oct 2007 12\:55\:21 +0800")
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
Cc: autofs mailing list <autofs@linux.kernel.org>

Ian Kent <raven@themaw.net> writes:

> On Tue, 2007-09-25 at 18:21 +0200, Matthias Koenig wrote:
>> Hi,
>> 
>> we noticed a problem concerning loop mounts on locations that 
>> have to be mounted before. E.g. consider the following situation,
>> a NFS server exporting a cd image, which we want to loop mount
>> locally to get access to the content:
>> 
>> auto.master:
>> /cdimage        auto.cdimage
>> /cdcontent      auto.cdcontent
>> 
>> auto.cdimage:
>> foo             nfsserver:/cdimage/foo.img
>> 

Yes, sorry. It is nfsserver:/cdimage/foo of course.
I invented this testcase in place, because the original setup
was less readable.

>> auto.cdcontent:
>> foo             -fstype=auto,loop       :/cdimage/foo/foo.img
>> 
>> The access to /cdcontent/foo will fail, when /cdimage/foo is not 
>> mounted before, because spawn_mount does not use SPAWN_OPT_ACCESS
>> in this case.
>
> This test case seems broken to me.
> Can you check you've described this correctly please.
> Maybe even try this exact setup yourself.

I checked this again and adapt it to the testcase described here.
auto.master remaining as shown above.

giuliani:/ # cat /etc/auto.cdimage 
foo     dist:/dist/install/openSUSE-10.3-GM/

giuliani:/ # cat /etc/auto.cdcontent 
foo -fstype=auto,loop,ro :/cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso

> Even if the maps were correct the procedure you describe wouldn't call
> spawn_mount first, it would call spawn_bind_mount, which would then
> trigger the mount through the access call.

Hmm, with the above setup, I am only able to access the content after I
have triggered the mount of the image separately.

giuliani:/ # ls /cdcontent/foo
ls: cannot open directory /cdcontent/foo: No such file or directory
giuliani:/ # ls /cdimage/foo/
[...]
giuliani:/ # ls /cdcontent/foo
ARCHIVES.gz     dosutils                          INDEX.gz
[...]

Here is the log of the failure:
Oct  8 14:25:17 giuliani automount[16597]: lookup_mount: lookup(file): looking up foo
Oct  8 14:25:17 giuliani automount[16597]: lookup_mount: lookup(file): foo -> -fstype=auto,loop,ro :/cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso
Oct  8 14:25:17 giuliani automount[16597]: parse_mount: parse(sun): expanded entry: -fstype=auto,loop,ro :/cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso
Oct  8 14:25:17 giuliani automount[16597]: parse_mount: parse(sun): gathered options: fstype=auto,loop,ro
Oct  8 14:25:17 giuliani automount[16597]: parse_mount: parse(sun): dequote(":/cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso") -> :/cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso
Oct  8 14:25:17 giuliani automount[16597]: parse_mount: parse(sun): core of entry: options=fstype=auto,loop,ro, loc=:/cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso
Oct  8 14:25:17 giuliani automount[16597]: sun_mount: parse(sun): mounting root /cdcontent, mountpoint foo, what /cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso, fstype auto, options loop,ro
Oct  8 14:25:17 giuliani automount[16597]: open_mount: (mount):cannot open mount module auto (/usr/lib/autofs/mount_auto.so: cannot open shared object file: No such file or directory)
Oct  8 14:25:17 giuliani automount[16597]: do_mount: /cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso /cdcontent/foo type auto options loop,ro using module generic
Oct  8 14:25:17 giuliani automount[16597]: mount_mount: mount(generic): calling mkdir_path /cdcontent/foo
Oct  8 14:25:17 giuliani automount[16597]: mount_mount: mount(generic): calling mount -t auto -s -o loop,ro /cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso /cdcontent/foo
Oct  8 14:25:17 giuliani automount[16597]: >> /cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso: No such file or directory
Oct  8 14:25:17 giuliani automount[16597]: mount(generic): failed to mount /cdimage/foo/openSUSE-10.3-GM-DVD-i386.iso (type auto) on /cdcontent/foo
Oct  8 14:25:17 giuliani automount[16597]: send_fail: token = 61
Oct  8 14:25:17 giuliani automount[16597]: failed to mount /cdcontent/foo


Thanks,
Matthias
