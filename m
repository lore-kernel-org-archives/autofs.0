From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: Loopback mounting seems to fail
Date: Tue, 8 Jun 2010 21:03:31 +0200 (CEST)
Message-ID: <alpine.LSU.2.01.1006082101080.10826@obet.zrqbmnf.qr>
References: <alpine.LSU.2.01.1006081456230.26148@obet.zrqbmnf.qr>
	<1276012109.2486.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1276012109.2486.2.camel@localhost>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Tuesday 2010-06-08 17:48, Ian Kent wrote:
>On Tue, 2010-06-08 at 14:59 +0200, Jan Engelhardt wrote:
>> 
>> I have here an openSUSE 11.2 with 2.6.33.5 and autofs-5.0.4-6.2.1.x86_64
>> 
>> /etc/auto.master:
>> +auto.master
>> /-	auto.direct
>> 
>> /etc/auto.direct:
>> /data/repository/sles11/x64/dvd1	-fstype=iso9660,loop,ro	/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso
>
>This is an invalid entry.
>A mount location can't start with "/", you need to use a ":" escape in
>this case.
>
>/data/repository/sles11/x64/dvd1 -fstype=iso9660,loop,ro :/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso

I thought I've done this before, but apparently only now it succeeded.

Ah I figure. If fstype=iso9660 is omitted, it starts to fail again:


# cd /data/repository/sles11/x64/dvd1
handle_packet: type = 5
handle_packet_missing_direct: token 179, name /data/repository/sles11/x64/dvd1, request pid 13790
attempting to mount entry /data/repository/sles11/x64/dvd1
lookup_mount: lookup(file): looking up /data/repository/sles11/x64/dvd1
lookup_mount: lookup(file): /data/repository/sles11/x64/dvd1 -> -loop,ro       :/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso
parse_mount: parse(sun): expanded entry: -loop,ro       :/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso
parse_mount: parse(sun): gathered options: loop,ro
parse_mount: parse(sun): dequote(":/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso") -> :/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso
parse_mount: parse(sun): core of entry: options=loop,ro, loc=:/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso
sun_mount: parse(sun): mounting root /data/repository/sles11/x64/dvd1, mountpoint /data/repository/sles11/x64/dvd1, what :/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso, fstype nfs, options loop,ro
mount_mount: mount(nfs): root=/data/repository/sles11/x64/dvd1 name=/data/repository/sles11/x64/dvd1 what=:/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso, fstype=nfs, options=loop,ro
mount_mount: mount(nfs): nfs options="loop,ro", nosymlink=0, ro=1
mount_mount: mount(nfs): calling mkdir_path /data/repository/sles11/x64/dvd1
mount_mount: mount(nfs): /data/repository/sles11/x64/dvd1 is local, attempt bind mount
mount_mount: mount(bind): calling mkdir_path /data/repository/sles11/x64/dvd1
mount_mount: mount(bind): calling mount --bind -s  -o ro /data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso /data/repository/sles11/x64/dvd1
>> mount: Not a directory
mount(nfs): nfs: mount failure :/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso on /data/repository/sles11/x64/dvd1
lookup_mount: lookup(yp): looking up /data/repository/sles11/x64/dvd1
ioctl_send_fail: token = 179
failed to mount /data/repository/sles11/x64/dvd1
handle_packet: type = 5
handle_packet_missing_direct: token 180, name /data/repository/sles11/x64/dvd1, request pid 13790
attempting to mount entry /data/repository/sles11/x64/dvd1
lookup_mount: lookup(file): looking up /data/repository/sles11/x64/dvd1
lookup_mount: lookup(yp): looking up /data/repository/sles11/x64/dvd1
ioctl_send_fail: token = 180
failed to mount /data/repository/sles11/x64/dvd1
bash: cd: /data/repository/sles11/x64/dvd1: No such file or directory

This is a bit odd, given normal mount(8) can do it with the
implicit fstype=auto.
