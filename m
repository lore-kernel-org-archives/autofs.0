From: Ian Kent <raven@themaw.net>
Subject: Re: automount never umount
Date: Thu, 1 Dec 2005 23:02:07 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0512012300390.6390@donald.themaw.net>
References: <4381E865.4070908@bppiac.hu> <438344F7.8020503@bppiac.hu>
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
	<17294.62252.248439.850231@segfault.boston.redhat.com>
	<438EFD96.7020903@bppiac.hu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <438EFD96.7020903@bppiac.hu>
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

> Jeff Moyer wrote:
> >>>>># dmesg |sort|uniq
> >>>>>
> >>>>>autofs4_revalidate: revalidate called on behalf of application
> >>>>>"automount" autofs4_revalidate: revalidate called on behalf of
> >>>>>application "multiload-apple"
> >>>>>
> >>>>>so what can i do? no longer use multiload-applet ? this is a standard
> >>>>>gnome applet included in fc4: "System Monitor 2.10.1"
> >>>>
> >>>>so what is the conclusion now?  will autofs be modified to umount even
> >>>>in such case or ...?  thnaks.
> >>>
> >>>
> >>>I'm not familiar with this applet.  Can someone help ot?
> > 
> > 
> > lfarkas> which kind of distro do you use? on fedora/redhat it's in
> > lfarkas> gnome-applets package and anyway in:
> > lfarkas> http://cvs.gnome.org/viewcvs/gnome-applets/multiload/
> > 
> > I'm not convinced it's the culprit.  As Ian mentioned earlier in this
> > thread, there is no flurry of mount/umount activity.  The file system gets
> > mounted, and then never unmounted, right?  If that is the case, and lsof
> 
> right.
> 
> > shows no users, then this is likely an autofs bug.
> 
> no users.
> so i also assume it's an autofs bug, that's why i wrote my first post.
> since i'm sure there is not any file on the nfs partition which is used
> for hours. the given nfs partition is our mirror server of centos,
> fedora, dag, etc.. so we only use it to manualy install new packages.
> even the daily updates run through ftp in order not use this nfs.

Then I must be able to duplicate it.
The kernel includes the latest patch we have in test right Jeff?

Ian
