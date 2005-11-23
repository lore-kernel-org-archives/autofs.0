From: Ian Kent <raven@themaw.net>
Subject: Re: automount never umount
Date: Wed, 23 Nov 2005 23:38:07 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511232334300.3253@donald.themaw.net>
References: <4381E865.4070908@bppiac.hu>
	<Pine.LNX.4.58.0511220822410.16196@wombat.indigo.net.au>
	<4382E835.3020904@bppiac.hu>
	<Pine.LNX.4.63.0511222054060.2600@donald.themaw.net>
	<438344F7.8020503@bppiac.hu>
	<17283.19512.49399.338448@segfault.boston.redhat.com>
	<43838CA9.40105@bppiac.hu>
	<17283.46783.748916.772469@segfault.boston.redhat.com>
	<438435EF.6080102@bppiac.hu>
	<Pine.LNX.4.63.0511232105320.3200@donald.themaw.net>
	<43846C1C.3050305@bppiac.hu>
	<17284.35467.301318.255602@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17284.35467.301318.255602@segfault.boston.redhat.com>
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
Cc: autofs@linux.kernel.org

On Wed, 23 Nov 2005, Jeff Moyer wrote:

> ==> Regarding Re: [autofs] automount never umount; Farkas Levente <lfarkas@bppiac.hu> adds:
> 
> lfarkas> Ian Kent wrote:
> >> On Wed, 23 Nov 2005, Farkas Levente wrote:
> >>> Jeff Moyer wrote: output of dmesg or /var/log/daemon? there is nothing
> >>> in dmesg.  i'm running this kernel currently and mount nfs and smbfs
> >>> servers.
> >>> ---------------------------
> >>> root 1974 0.0 0.0 1788 736 ?  Ss 10:05 0:00 /usr/sbin/automount
> >>> --timeout=60 --debug /smb program /etc/auto.smb root 1976 0.0 0.0 1788
> >>> 736 ?  Ss 10:05 0:00 /usr/sbin/automount --timeout=60 --debug /net
> >>> program /etc/auto.net
> >>> ---------------------------
> >>> how long should i wait? as the timeout is 1 minute, they should have to
> >>> be umounted, but not. here is the relevant part of daemon log which
> >>> don't tell me too much:-(
> >> 
> >> 
> >> You've waited long enough. Your timeout was 60 seconds.
> >> 
> >> This is really strange. We didn't catch any activity from the patch so I
> >> don't know why it isn't expiring. Come to think of it we we should have
> >> at least got some kernel messages?
> >> 
> >> What version was the kernel you originally saw this on?
> 
> lfarkas> # rpm -q kernel kernel-2.6.14-1.1637_FC4
> lfarkas> kernel-2.6.14-1.1641_FC4.jmoyertest.1
> 
> 
> >> Jeff, I'm wondering if this is a regression from the latest patch.  Was
> >> that in the above kernel?
> >> 
> >> Farkas, if your willing the next step in this process is likely to
> >> generate even more output but hopefully will give us more info.
> 
> lfarkas> what should i do?
> 
> Well, I shouldn't be rolling kernels so late in the day.  I didn't even
> apply the patch!  I'll roll another for you to try.  ;)

The interesting thing about the log is that there was no timeout and 
instant remount activity which is characteristic of the GUI scaning 
problem. AFAICT the reason that this happens is because the GUI 
scaning springs into life when it sees the umount activity.

Ian
