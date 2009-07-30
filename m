From: Lukas Haase <lukashaase@gmx.at>
Subject: Bind mount on indirect mount OR script for direct mount
Date: Fri, 31 Jul 2009 00:40:36 +0200
Message-ID: <h4t7h5$l8h$1@ger.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Hi,

I have the following problem: I have an external media USB drive which I 
want to automatically power on and mount it into a virtual environment 
(OpenVZ). Something similar like to mounting into chroot.

On the host, the drive should be mounted to 
/var/lib/vz/root/500/media/media which correspondents /media/media 
inside the virtual OpenVZ container.

The USB drive is connected to a powerhub which can be switched from a 
script. The drive should only be switched on when it is needed and 
switched off again afterwards. As a solution I would have the following 
ideas (both are not yet working :-( ):

1.) Defining a direct mount:
# cat /etc/auto.master
/-	auto.misc	--timeout=5
# cat /etc/auto.misc
/var/lib/vz/root/500/media/media   -fstype=vfat,defaults   :/dev/media

But I see no way here to execute a script in order to power on the 
drive. Is there a way?

2.) By using indirect mounts I can use a script. But unfortunately I do 
*not* want to have an indirect mount inside the VE. So my idea would be 
to first mount the drive indirectly to /media/auto/*:

# cat /etc/auto.master
/media/auto     /usr/local/sbin/autofs-mount.sh --timeout=5 --ghost

The script powers on the drive, waits until the device node exists and 
returns the options. This works quite good. But now I want the content 
to appear in /var/lib/vz/root/500/media/media. Normally I would just 
take a symlink and everything would be fine. But due to the nature of 
the OpenVZ container ("chroot") I rather need a bind mount. So I tried:

# cat /etc/auto.master
/-	auto.misc	--timeout=5
# cat /etc/auto.misch
/var/lib/vz/root/500/media/media -fstype=none,bind   :/media/auto/media

But unfortunately this does not seem to work:

# ls -la /media/auto/media/
(directory content - works)
# ls -la /var/lib/vz/root/500/media/media/
ls: cannot open directory /var/lib/vz/root/500/media/media/: No such 
file or directory

And this is the debug output:

[...]
lookup_mount: lookup(file): looking up /var/lib/vz/root/500/media/media
lookup_mount: lookup(file): /var/lib/vz/root/500/media/media -> 
-fstype=none,bind       :/media/auto/media
parse_mount: parse(sun): expanded entry: -fstype=none,bind 
:/media/auto/media
parse_mount: parse(sun): gathered options: fstype=none,bind
parse_mount: parse(sun): dequote(":/media/auto/media") -> :/media/auto/media
parse_mount: parse(sun): core of entry: options=fstype=none,bind, 
loc=:/media/auto/media
sun_mount: parse(sun): mounting root /-, mountpoint 
/var/lib/vz/root/500/media/media, what /media/auto/media, fstype none, 
options bind
do_mount: /media/auto/media /var/lib/vz/root/500/media/media type none 
options bind using module generic
mount_mount: mount(generic): calling mkdir_path 
/var/lib/vz/root/500/media/media
mount_mount: mount(generic): warning: /var/lib/vz/root/500/media/media 
is already mounted
send_ready: token = 174
mounted /var/lib/vz/root/500/media/media
[...]

Is there any way to solve my problem? I have Debian lenny with the 
autofs5 package.

Thank you very much.

Best regards,
Luke
