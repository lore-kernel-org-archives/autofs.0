From: Ian Kent <raven@themaw.net>
Subject: Re: automount never umount
Date: Thu, 1 Dec 2005 21:45:59 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0512012142270.3272@donald.themaw.net>
References: <4381E865.4070908@bppiac.hu> <4382E835.3020904@bppiac.hu>
	<Pine.LNX.4.63.0511222054060.2600@donald.themaw.net>
	<438344F7.8020503@bppiac.hu>
	<17283.19512.49399.338448@segfault.boston.redhat.com>
	<43838CA9.40105@bppiac.hu>
	<17283.46783.748916.772469@segfault.boston.redhat.com>
	<438435EF.6080102@bppiac.hu>
	<Pine.LNX.4.63.0511232105320.3200@donald.themaw.net>
	<43846C1C.3050305@bppiac.hu>
	<17284.35467.301318.255602@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0511232334300.3253@donald.themaw.net>
	<17284.40834.559604.943290@segfault.boston.redhat.com>
	<4384A354.9040502@bppiac.hu>
	<17284.41971.660257.356263@segfault.boston.redhat.com>
	<43859055.3020508@bppiac.hu>
	<Pine.LNX.4.63.0511242003250.2069@donald.themaw.net>
	<17291.9542.484484.306141@segfault.boston.redhat.com>
	<438C4983.30504@bppiac.hu> <438EC2E8.6060602@bppiac.hu>
	<Pine.LNX.4.63.0512011902480.3189@donald.themaw.net>
	<438EE03B.5090601@bppiac.hu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <438EE03B.5090601@bppiac.hu>
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
To: Farkas Levente <lfarkas@bppiac.hu>
Cc: autofs@linux.kernel.org

On Thu, 1 Dec 2005, Farkas Levente wrote:

> Ian Kent wrote:
> > On Thu, 1 Dec 2005, Farkas Levente wrote:
> > 
> > 
> >>Farkas Levente wrote:
> >>
> >>>Jeff Moyer wrote:
> >>>
> >>>>Sure, you could enable debug.  I just didn't want to get too much
> >>>>information.  However, at this point, it's probably better that we get as
> >>>>much as possible so Farkas doesn't have to keep trying new patches.
> >>>>
> >>>>Farkas, please look at the output of dmesg and let us know what you find.
> >>>>You should see something like this:
> >>>
> >>>
> >>># dmesg |sort|uniq
> >>>
> >>>autofs4_revalidate: revalidate called on behalf of application "automount"
> >>>autofs4_revalidate: revalidate called on behalf of application
> >>>"multiload-apple"
> >>>
> >>>so what can i do? no longer use multiload-applet ? this is a standard
> >>>gnome applet included in fc4: "System Monitor 2.10.1"
> >>
> >>so what is the conclusion now?
> >>will autofs be modified to umount even in such case or ...?
> >>thnaks.
> > 
> > 
> > I'm not familiar with this applet.
> > Can someone help ot?
> 
> which kind of distro do you use? on fedora/redhat it's in gnome-applets
> package and anyway in:
> http://cvs.gnome.org/viewcvs/gnome-applets/multiload/

I'll have a look about.

Dev machine has Aurora 2.0, a Gentoo and a Debian install. Only the Aurora 
is really working.

Other machines have an FC3 and an FC4 (which is broken atm) and an 
old Debian install.

Ian
