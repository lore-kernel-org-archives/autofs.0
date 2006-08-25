From: Piete Brooks <Piete.Brooks--autofs@cl.cam.ac.uk>
Subject: Re: What is the syntax for bind mounts under autofs 5 ?
Date: Fri, 25 Aug 2006 06:20:19 +0100
Message-ID: <E1GGU7A-0004GD-00@mta2.cl.cam.ac.uk>
References: <E1GGEUO-0004FJ-00@mta2.cl.cam.ac.uk>
	<Pine.LNX.4.64.0608250919030.6382@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: Message from Ian Kent <raven@themaw.net> of "Fri,
	25 Aug 2006 09:21:55 +0800."
	<Pine.LNX.4.64.0608250919030.6382@raven.themaw.net> 
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
Cc: autofs@linux.kernel.org

>> I used to be able to use:	foo	:/usr/local/foo
>> to cause autofs to do a bind mount of "foo" to the local directory 
>> /usr/local/foo but under autofs 5 it fails. With "automount -d -v" I get:
> Your not getting all the log info.

Ta.

I now get:

Aug 25 06:06:51 pbtest8 automount[2287]: handle_packet: type = 3
Aug 25 06:06:51 pbtest8 automount[2287]: handle_packet_missing_indirect: token 
2, name rf10, request pid 31696
Aug 25 06:06:51 pbtest8 automount[2287]: attempting to mount entry 
/auto/homes/rf10
Aug 25 06:06:51 pbtest8 automount[2287]: lookup_mount: lookup(file): looking 
up rf10
Aug 25 06:06:51 pbtest8 automount[2287]: lookup_mount: lookup(file): rf10 -> 
-fstype=bind :/auto/userfiles/&/unix_home
Aug 25 06:06:51 pbtest8 automount[2287]: parse_mount: parse(sun): expanded 
entry: -fstype=bind :/auto/userfiles/rf10/unix_home
Aug 25 06:06:51 pbtest8 automount[2287]: parse_mount: parse(sun): gathered 
options: fstype=bind
Aug 25 06:06:51 pbtest8 automount[2287]: parse_mount: parse(sun): 
dequote(":/auto/userfiles/rf10/unix_home") -> :/auto/userfiles/rf10/unix_home
Aug 25 06:06:51 pbtest8 automount[2287]: parse_mount: parse(sun): core of 
entry: options=fstype=bind, loc=:/auto/userfiles/rf10/unix_home
Aug 25 06:06:51 pbtest8 automount[2287]: sun_mount: parse(sun): mounting root 
/auto/homes, mountpoint rf10, what /auto/userfiles/rf10/unix_home, fstype 
bind, options
Aug 25 06:06:51 pbtest8 automount[2287]: mount_init: mount(bind): bind_works = 
1
Aug 25 06:06:51 pbtest8 automount[2287]: do_mount: 
/auto/userfiles/rf10/unix_home /auto/homes/rf10 type bind options  using 
module bind
Aug 25 06:06:51 pbtest8 automount[2287]: mount_mount: mount(bind): calling 
mkdir_path /auto/homes/rf10
Aug 25 06:06:51 pbtest8 automount[2287]: mount_mount: mount(bind): calling 
mount --bind -s  -o defaults /auto/userfiles/rf10/unix_home /auto/homes/rf10
Aug 25 06:06:51 pbtest8 automount[2287]: >> mount: special device 
/auto/userfiles/rf10/unix_home does not exist
Aug 25 06:06:51 pbtest8 automount[2287]: send_fail: token = 2
Aug 25 06:06:51 pbtest8 automount[2287]: failed to mount /auto/homes/rf10
Aug 25 06:06:51 pbtest8 automount[2287]: handle_packet: type = 3
Aug 25 06:06:51 pbtest8 automount[2287]: handle_packet_missing_indirect: token 
3, name rf10, request pid 31696
Aug 25 06:06:51 pbtest8 automount[2287]: attempting to mount entry 
/auto/homes/rf10
Aug 25 06:06:51 pbtest8 automount[2287]: lookup_mount: lookup(file): looking 
up rf10
Aug 25 06:06:51 pbtest8 automount[2287]: send_fail: token = 3
Aug 25 06:06:51 pbtest8 automount[2287]: failed to mount /auto/homes/rf10


so it looks like the "mount: special device /auto/userfiles/rf10/unix_home 
does not exist" is the problem :-(

However, a manual mount appears to work OK:

pbtest8:~: ls -ld /auto/userfiles/rf10/unix_home
drwxr-xr-x 103 rf10 rf10 65536 Aug 25 05:59 /auto/userfiles/rf10/unix_home
pbtest8:~: sudo mount --bind -s  -o defaults /auto/userfiles/rf10/unix_home 
/mnt
pbtest8:~: ls -ld /mnt
drwxr-xr-x 103 rf10 rf10 65536 Aug 25 05:59 /mnt
pbtest8:~: 
