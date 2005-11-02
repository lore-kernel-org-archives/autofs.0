From: Ian Kent <raven@themaw.net>
Subject: Re: Re: autofs timeout and large map
Date: Wed, 2 Nov 2005 09:19:20 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0511020912090.6481@wombat.indigo.net.au>
References: <20051028163028.75072c9b.akpm@osdl.org>
	<Pine.LNX.4.63.0510291032450.2075@donald.themaw.net>
	<89e9feae0510310904u389dc003mc311a1f0a1058168@mail.gmail.com>
	<Pine.LNX.4.63.0511012358320.3040@donald.themaw.net>
	<17255.42731.371939.845427@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17255.42731.371939.845427@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Dannie Stanley <dannie.stanley@gmail.com>, autofs@linux.kernel.org

On Tue, 1 Nov 2005, Jeff Moyer wrote:

> ==> Regarding [autofs] Re: autofs timeout and large map; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Mon, 31 Oct 2005, Dannie Stanley wrote:
> >> Ian Kent has pointed me to this list.  I have included my original
> >> message thread posted to linux-kernel (sorry for the incorrect posting).
> >> Here are my answers to Ian's specific questions:
> >> 
> >> > Distribution?  $ cat /etc/redhat-release Red Hat Enterprise Linux AS
> >> release 3 (Taroon Update 6)
> >> 
> >> > Your version of autofs?  $ rpm -q autofs autofs-4.1.3-154
> 
> raven> That's good.
> 
> >> > Kernel version?  $ uname -a Linux ... 2.4.21-37.EL #1 Wed Sep 7
> >> 13:35:21 EDT 2005 i686 i686 i386 GNU/Linux
> 
> raven> The RHEL kernel should be fine also.
> 
> >> > Have any autofs4 patches been applied to your kernel?  Standard
> >> packaged RedHat kernel, no patches.
> 
> raven> Yep. Shouldn't need any with RHEL.
> 
> >> > What do you have in your master map?  $ cat /etc/auto.master #/-
> >> /etc/auto.virtual --ghost /- /etc/auto.virtual
> >> 
> >> > Then you have 1345 offset mount (multi-mount) entries similar to the >
> >> one above. Each with two offsets. Correct?  True.
> >> 
> >> > How many automount processes end up running after starting autofs?
> >> Two...  $ ps -fC automount |cut -c49-200 CMD /usr/sbin/automount
> >> --timeout=86400 /- file /etc/auto.virtual /usr/sbin/automount --submount
> >> --timeout=86400 /virtual file /etc/auto.virtual
> >> 
> 
> raven> Now about the debug log we need to discover what's going on.
> 
> raven> Please add --debug to your master map entry and forward the
> raven> resulting log.
> 
> raven> You need to check that your syslog configuration includes priority
> raven> debug.
> 
> This is quite easy to reproduce.  Basically, after the expire event,
> accesses to the /virtual/USERNAME directory do not trigger callouts to the
> daemon.  Here is the expiry message from the logs:

OK. I'll have a go at reproducing it.

I don't have the exact versions but hopefully the problem will be evident 
in other versions as well.

Would it be possible for you the put the source rpm into your people area 
please.

> 
> automount[2495]: sigchld: exp 2513 finished, switching from 2 to 1
> automount[2495]: get_pkt: state 2, next 1
> automount[2495]: st_ready(): state = 2 
> automount[2495]: sig 14 switching from 1 to 2
> automount[2495]: get_pkt: state 1, next 2
> automount[2495]: st_expire(): state = 1 
> automount[2495]: expire_proc: exp_proc=2515
> automount[2495]: handle_packet: type = 2 
> automount[2495]: handle_packet_expire_multi: token 22, name jmoyer/private 
> automount[2516]: expiring path /virtual/jmoyer/private
> automount[2516]: umount_multi: path=/virtual/jmoyer/private incl=1 
> automount[2516]: umount_multi: unmounting dir=/virtual/jmoyer/private 
> automount[2516]: expired /virtual/jmoyer/private
> automount[2495]: handle_child: got pid 2516, sig 0 (0), stat 0
> automount[2495]: sig_child: found pending iop pid 2516: signalled 0 (sig 0), exit status 0
> automount[2495]: send_ready: token=22 
> automount[2495]: handle_packet: type = 2 
> automount[2495]: handle_packet_expire_multi: token 23, name jmoyer/public 
> automount[2518]: expiring path /virtual/jmoyer/public
> automount[2518]: umount_multi: path=/virtual/jmoyer/public incl=1 
> automount[2518]: umount_multi: unmounting dir=/virtual/jmoyer/public 
> automount[2518]: expired /virtual/jmoyer/public
> automount[2495]: handle_child: got pid 2518, sig 0 (0), stat 0
> automount[2495]: sig_child: found pending iop pid 2518: signalled 0 (sig 0), exit status 0
> automount[2495]: send_ready: token=23 
> automount[2495]: handle_child: got pid 2515, sig 0 (0), stat 0
> automount[2495]: sigchld: exp 2515 finished, switching from 2 to 1
> 
> What you are left with is a directory hierarchy that looks like this:
> 
> /virtual
>         /jmoyer
>                /private
>                /public
> 
> Clearly the private and public directories should be gone!  As mentioned,
> an ls -l in the /virtual/jmoyer directory will look like so:
> 
> # ls -l /virtual/jmoyer/
> total 0
> dr-xr-xr-x    2 root     root            0 Nov  1 07:16 private
> dr-xr-xr-x    2 root     root            0 Nov  1 07:16 public

If the --ghost option is used these directories should be creted when the 
map is first loaded and remain.

The fact that they are empty should be the mount trigger.
This might be another example of the kernel problem we are currently 
working on.

A debug trace of the subsequent mount failure should confirm that one way 
or the other.

Ian
