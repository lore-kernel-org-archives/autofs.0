From: "Kevin Muller" <k.muller@sideshowdigital.com>
Subject: autofs / davfs
Date: Mon, 21 May 2007 12:34:44 +0300
Message-ID: <4104f1cf0705210234o6bdbb7e9n2d485f2e9b609c@mail.gmail.com>
References: <4104f1cf0705170218ua2b6bbdu8f1456193741cd65@mail.gmail.com>
	<4104f1cf0705172308pdd3a3f9l4b4a558e290bebbc@mail.gmail.com>
	<x49zm428auy.fsf@segfault.boston.devel.redhat.com>
	<4104f1cf0705180737o4de54aa9wf2e73de733dc446b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4104f1cf0705180737o4de54aa9wf2e73de733dc446b@mail.gmail.com>
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

[rpm -q autofs]
autofs-5.0.1-0.rc2.43.0.2

[uname -r]
2.6.18-8.1.3.el5

[auto.master:]
/misc   /etc/auto.misc
/net    -hosts
/home/automount         autodav.auto --ghost --timeout=120 --debug

[autodav.auto:]
web.site.com          -fstype=autofs          http://192.168.200.40/repos

[nsswitch.conf:]
passwd:     files winbind
shadow:     files winbind
group:      files winbind
#hosts:     db files nisplus nis dns
hosts:      files dns
bootparams: nisplus [NOTFOUND=return] files
ethers:     files
netmasks:   files
networks:   files
protocols:  files
rpc:        files
services:   files
netgroup:   files
publickey:  nisplus
automount:  files
aliases:    files nisplus


[/etc/sysconfig.autofs:]
DEFAULT_TIMEOUT=300
DEFAULT_BROWSE_MODE="no"


[output from debug (when fstype=auto):]
May 14 15:55:44 devaccess automount[3575]: master_do_mount: mounting
/home/automount
May 14 15:55:44 devaccess automount[3575]: lookup_nss_read_map:
reading map files autodav.auto
May 14 15:55:51 devaccess automount[3575]: handle_packet: type = 3
May 14 15:55:51 devaccess automount[3575]:
handle_packet_missing_indirect: token 4, name web.site.com, request
pid 3586
May 14 15:55:51 devaccess automount[3575]: lookup_mount: lookup(file):
looking up web.site.com
May 14 15:55:51 devaccess automount[3575]: lookup_mount: lookup(file):
web.site.com -> -fstype=autofs           http://192.168.200.40/repos
May 14 15:55:51 devaccess automount[3575]: parse_mount: parse(sun):
expanded entry: -fstype=autofs
http://192.168.200.40/repos
May 14 15:55:51 devaccess automount[3575]: parse_mount: parse(sun):
gathered options: fstype=autofs
May 14 15:55:51 devaccess automount[3575]: parse_mount: parse(sun):
dequote(" http://192.168.200.40/repos") -> http://192.168.200.40/repos
May 14 15:55:51 devaccess automount[3575]: parse_mount: parse(sun):
core of entry: options=fstype=autofs, loc= http://192.168.200.40/repos
May 14 15:55:51 devaccess automount[3575]: sun_mount: parse(sun):
mounting root /home/automount, mountpoint web.site.com , what
http://192.168.200.40/repos, fstype autofs, options
May 14 15:55:51 devaccess automount[3575]: do_mount:
http://192.168.200.40/repos /home/automount/web.site.com type autofs
options  using module autofs
May 14 15:55:51 devaccess automount[3575]: mount_mount: mount(autofs):
fullpath=/home/automount/web.site.com what=
http://192.168.200.40/repos options=
May 14 15:55:51 devaccess automount[3575]: lookup_nss_read_map:
reading map http //192.168.200.40/repos
May 14 15:55:51 devaccess automount[3575]: open_lookup: cannot open
lookup module http (/usr/lib/autofs/lookup_http.so: cannot open shared
object file: No such file or directory)
May 14 15:55:51 devaccess automount[3575]: do_read_map: lookup module
http failed
May 14 15:55:51 devaccess automount[3575]: mount_autofs_indirect:
failed to read map for /home/automount/web.site.com
May 14 15:55:51 devaccess automount[3575]: handle_mounts: mount of
/home/automount/web.site.com failed!
May 14 15:55:51 devaccess automount[3575]: mount_mount: mount(autofs):
failed to create submount for /home/automount/web.site.com


[output from debug (when fstype=davfs):]
May 14 15:59:01 devaccess automount[3619]: handle_packet: type = 3
May 14 15:59:01 devaccess automount[3619]:
handle_packet_missing_indirect: token 5, name web.site.com, request
pid 3630
May 14 15:59:01 devaccess automount[3619]: lookup_mount: lookup(file):
looking up web.site.com
May 14 15:59:01 devaccess automount[3619]: lookup_mount: lookup(file):
web.site.com -> -fstype=davfs            http://192.168.200.40/repos
May 14 15:59:01 devaccess automount[3619]: parse_mount: parse(sun):
expanded entry: -fstype=davfs
http://192.168.200.40/repos
May 14 15:59:01 devaccess automount[3619]: parse_mount: parse(sun):
gathered options: fstype=davfs
May 14 15:59:01 devaccess automount[3619]: parse_mount: parse(sun):
dequote("http://192.168.200.40/repos") -> http://192.168.200.40/repos
May 14 15:59:01 devaccess automount[3619]: parse_mount: parse(sun):
core of entry: options=fstype=davfs, loc=http://192.168.200.40/repos
May 14 15:59:01 devaccess automount[3619]: sun_mount: parse(sun):
mounting root /home/automount, mountpoint web.site.com, what
http://192.168.200.40/repos, fstype davfs, options
May 14 15:59:01 devaccess automount[3619]: open_mount: (mount):cannot
open mount module davfs (/usr/lib/autofs/mount_davfs.so: cannot open
shared object file: No such file or directory)
May 14 15:59:01 devaccess automount[3619]: do_mount:
http://192.168.200.40/repos /home/automount/web.site.com type davfs
options  using module generic
May 14 15:59:01 devaccess automount[3619]: mount_mount:
mount(generic): calling mkdir_path /home/automount/web.site.com
May 14 15:59:01 devaccess automount[3619]: mount_mount:
mount(generic): calling mount -t davfs http://192.168.200.40/repos
/home/automount/web.site.com
May 14 15:59:40 devaccess automount[3619]: st_expire: state 1 path
/home/automount
May 14 15:59:40 devaccess automount[3619]: expire_proc: exp_proc =
3077438352 path /home/automount
May 14 15:59:40 devaccess automount[3619]: expire_proc_indirect:
expire /home/automount/web.site.com
May 14 15:59:41 devaccess automount[3619]: expire_proc_indirect: 1
remaining in /home/automount
May 14 15:59:41 devaccess automount[3619]: expire_cleanup: got thid
3077438352 path /home/automount stat 2
May 14 15:59:41 devaccess automount[3619]: expire_cleanup: sigchld:
exp 3077438352 finished, switching from 2 to 1
May 14 15:59:41 devaccess automount[3619]: st_ready: st_ready(): state
= 2 path /home/automount
May 14 16:00:11 devaccess automount[3619]: st_expire: state 1 path
/home/automount
May 14 16:00:11 devaccess automount[3619]: expire_proc: exp_proc =
3077438352 path /home/automount
May 14 16:00:11 devaccess automount[3619]: expire_proc_indirect:
expire /home/automount/web.site.com
May 14 16:00:13 devaccess automount[3619]: expire_proc_indirect: 1
remaining in /home/automount
May 14 16:00:13 devaccess automount[3619]: expire_cleanup: got thid
3077438352 path /home/automount stat 2
May 14 16:00:13 devaccess automount[3619]: expire_cleanup: sigchld:
exp 3077438352 finished, switching from 2 to 1
May 14 16:00:13 devaccess automount[3619]: st_ready: st_ready(): state
= 2 path /home/automount
May 14 16:00:43 devaccess automount[3619]: st_expire: state 1 path
/home/automount
May 14 16:00:43 devaccess automount[3619]: expire_proc: exp_proc =
3077438352 path /home/automount
May 14 16:00:43 devaccess automount[3619]: expire_proc_indirect:
expire /home/automount/web.site.com
May 14 16:00:44 devaccess automount[3619]: expire_proc_indirect: 1
remaining in /home/automount
May 14 16:00:44 devaccess automount[3619]: expire_cleanup: got thid
3077438352 path /home/automount stat 2
May 14 16:00:44 devaccess automount[3619]: expire_cleanup: sigchld:
exp 3077438352 finished, switching from 2 to 1
May 14 16:00:44 devaccess automount[3619]: st_ready: st_ready(): state
= 2 path /home/automount

I had that in the original message, which made a massive appearance in
/dev/null due to it been in html. The resend did not have take out the
details from the /dev/null void.

Thank you,

Kevin

On 5/18/07, Jeff Moyer <jmoyer@redhat.com> wrote:
> ==> On Fri, 18 May 2007 09:08:00 +0300, "Kevin Muller" <k.muller@sideshowdigital.com> said:
>
> Kevin> autofs / davfs
> Kevin> Im having a problem automounting a davfs share.
> Kevin> The share is setup, and works perfect without the automount.
> Kevin> but as soon as a 'ls' is done on the automount directory, and the
> Kevin> autofs tries to mount it, it hangs for a while, then if ctrl-c's out
> Kevin> of it, the next ls on that directory shows the files correctly.
>
> Kevin> The idea is to have the files available through Samba, and as soon as
> Kevin> samba tries to access the folder it will be a webdav share that gets
> Kevin> mounted at that point.
>
> Kevin> Any suggestions at this point will be helpful.
>
> See the section entitled, "Filing bug reports," at the following URL:
>   http://people.redhat.com/jmoyer
>
> Please provide the information requested therein.
>
> Thanks!
>
> Jeff
>
