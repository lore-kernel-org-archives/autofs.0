From: "Kevin Muller" <k.muller@sideshowdigital.com>
Subject: Re: autofs / davfs
Date: Mon, 21 May 2007 15:52:14 +0300
Message-ID: <4104f1cf0705210552j866818yf0188c2c5d5e584a@mail.gmail.com>
References: <4104f1cf0705170218ua2b6bbdu8f1456193741cd65@mail.gmail.com>
	<4104f1cf0705172308pdd3a3f9l4b4a558e290bebbc@mail.gmail.com>
	<x49zm428auy.fsf@segfault.boston.devel.redhat.com>
	<4104f1cf0705180737o4de54aa9wf2e73de733dc446b@mail.gmail.com>
	<x49sl9u8a3k.fsf@segfault.boston.devel.redhat.com>
	<4104f1cf0705210043y66c2ff79qd1f39792c49e0e6@mail.gmail.com>
	<m34pm6qrcy.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <m34pm6qrcy.fsf@redhat.com>
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

May 21 15:48:29 devaccess automount[32396]: st_expire: state 1 path
/home/automount
May 21 15:48:29 devaccess automount[32396]: expire_proc: exp_proc =
3078335376 path /home/automount
May 21 15:48:29 devaccess automount[32396]: expire_cleanup: got thid
3078335376 path /home/automount stat 0
May 21 15:48:29 devaccess automount[32396]: expire_cleanup: sigchld:
exp 3078335376 finished, switching from 2 to 1
May 21 15:48:29 devaccess automount[32396]: st_ready: st_ready():
state = 2 path /home/automount
May 21 15:48:35 devaccess automount[32396]: handle_packet: type = 3
May 21 15:48:35 devaccess automount[32396]:
handle_packet_missing_indirect: token 1, name web.site.com, request
pid 32419
May 21 15:48:35 devaccess automount[32396]: lookup_mount:
lookup(file): looking up web.site.com
May 21 15:48:35 devaccess automount[32396]: lookup_mount:
lookup(file): web.site.com -> http://v6.muglets.com.dev/repos
May 21 15:48:35 devaccess automount[32396]: parse_mount: parse(sun):
expanded entry: http://v6.muglets.com.dev/repos
May 21 15:48:35 devaccess automount[32396]: parse_mount: parse(sun):
gathered options:
May 21 15:48:35 devaccess automount[32396]: parse_mount: parse(sun):
dequote("http://v6.muglets.com.dev/repos") ->
http://v6.muglets.com.dev/repos
May 21 15:48:35 devaccess automount[32396]: parse_mount: parse(sun):
core of entry: options=, loc=http://v6.muglets.com.dev/repos
May 21 15:48:35 devaccess automount[32396]: sun_mount: parse(sun):
mounting root /home/automount, mountpoint web.site.com, what
http://v6.muglets.com.dev/repos, fstype nfs, options (null)
May 21 15:48:35 devaccess automount[32396]: mount_mount: mount(nfs):
root=/home/automount name=web.site.com
what=http://v6.muglets.com.dev/repos, fstype=nfs, options=(null)
May 21 15:48:35 devaccess automount[32396]: add_host_addrs: host http:
lookup failure 1
May 21 15:48:35 devaccess automount[32396]: mount_mount: mount(nfs):
no hosts available
May 21 15:48:59 devaccess automount[32396]: st_expire: state 1 path
/home/automount

---------------------------------------------------------------------

that is the debug log when I remove that from the map file.
 - kevin

On 5/21/07, jmoyer@redhat.com <jmoyer@redhat.com> wrote:
> ==> Regarding Re: [autofs] autofs / davfs; "Kevin Muller" <k.muller@sideshowdigital.com> adds:
>
> k.muller> Hi There!  Thank you for your response. I have tried it with
> k.muller> fs=davfs, and fs=autofs, just to make sure that it was not a type
> k.muller> setting.
>
> k.muller> The mount command to mount would be: mount -t davfs <weburl>
> k.muller> <mountpoint>
>
> k.muller> so in my case it would be: mount -t davfs
> k.muller> http://192.168.200.40/repos/ home/automount/web.site.com
>
> k.muller> or alternativly, if a fstab entry is created, then just: mount -t
> k.muller> davfs <mountpoint>
>
> Try it without the -fstype option.
>
> -Jeff
>
