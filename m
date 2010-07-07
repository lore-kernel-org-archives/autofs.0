From: Ian Kent <raven@themaw.net>
Subject: Re: two /net paths to the same local mount?
Date: Wed, 07 Jul 2010 12:22:34 +0800
Message-ID: <1278476554.5423.9.camel@localhost>
References: <4C1FBABF.5060207@oracle.com>
	<35D166B0274C8DB77A6BE435@[192.168.1.100]>
	<4C225338.8070008@oracle.com>
	<1277348429.2841.44.camel@localhost>  <4C2A1C03.1070908@oracle.com>
	<1277903577.2819.8.camel@localhost>  <4C2B5B4E.3010501@oracle.com>
	<1277950748.3137.2.camel@localhost>  <4C33CA03.2020904@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=GGTJlfbsieKuVqrKml5WmYz5G3s=;
	b=lBPmujHElq5b8rj5KZ0uTxUeRHRDhq0JmadQY9Jg5eDRkokiTBNCQzO4FBbHDicE2rZYZyP1A0aNBsiuDlvxslOWB5lBCjs5SkuFaqhDbYojBQq6Pv/kN9i3VVBo7UfSjfulSdiRC3BB8Wy5eFLEtkuMh5RHMk5n4pQg29U5ADI=
In-Reply-To: <4C33CA03.2020904@oracle.com>
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
To: Chris Quenelle <chris.quenelle@oracle.com>
Cc: autofs@linux.kernel.org

On Tue, 2010-07-06 at 17:27 -0700, Chris Quenelle wrote:
> Ian Kent wrote:
> > On Wed, 2010-06-30 at 07:57 -0700, Chris Quenelle wrote:
> >> On Wednesday June 30    6:12AM, Ian Kent wrote:
> >>> On Tue, 2010-06-29 at 09:14 -0700, Chris Quenelle wrote:
> >>>> Ian,
> >>>>
> >>>> Thanks again for your help.
> >>>> I have syslog-ng installed, and I can't figure out how to tell
> >>>> if "daemon.*" is being sent somewhere or not.  "daemon" doesn't
> >>>> appear anywhere in /etc/syslog-ng/syslog-ng.conf
> >>> Well, you need to consult the man page for the configuration file then
> >>> don't you.
> >> Sorry for sounding lazy there.  I've never used syslog-ng before, and
> >> I read the man page for a while without figuring how the old style
> >> of names/categories mapped to the new system.  I'll continue to fiddle
> >> around and see if I can find out what's going on.
> >>
> >> Thanks for helping me get started with the debugging output.
> >>
> >> My autofs map looks like this:
> >> % ypcat -k auto.master | grep /net
> >> /net -hosts -intr,nosuid,retrans=10,retry=3,nobrowse
> >>
> >> But I'm not sure that helps.
> > 
> > Is automount crashing, ie. does it show up in a ps listing after you see
> > it hang?
> 
> 
> Nope.  The ps command doesn't show any change in the status of the automount
> process.
> 
> In fact, when I attach strace to the automount process I don't see any
> sign of activity when I do an "ls" on the unhealthy path.
> It sounds like I would need to look at kernel tracing/debugging if I want
> to pursue this further.

strace output is often not very useful.

If you think there is some sort of deadlock going on get a sysreq-t dump
to syslog. We still haven't seen a debug log?

> 
> 
> 
> 
> 
> 
> > 
> >> --chris
> >>
> >>
> >>
> >>> For me, when syslog was in use and now with rsyslog, I just add a new
> >>> line to send all the facility daemon output to a log file.
> >>>
> >>> I add the line:
> >>>
> >>> daemon.*                                /var/log/debug
> >>>
> >>> to the configuration and then
> >>>
> >>> touch /var/log/debug
> >>>
> >>> and finally restart logging service.
> >>>
> >>> You probably should post your autofs maps as well.
> >>>
> >>>> But when I grep /var/log/messages I see:
> >>>>
> >>>> % grep automount messages
> >>>> Jun 29 02:41:14 carabas automount[11786]: lookup_mount: lookup(yp): key "Codemgr_wsdata" not found in map
> >>>> Jun 29 02:41:14 carabas automount[11786]: lookup_mount: lookup(yp): key "Codemgr_wsdata" not found in map
> >>>> Jun 29 03:17:45 carabas automount[11786]: lookup_mount: lookup(yp): key "opt" not found in map
> >>>> Jun 29 03:24:27 carabas automount[11786]: lookup_mount: lookup(yp): key "Codemgr_wsdata" not found in map
> >>>> Jun 29 03:24:27 carabas automount[11786]: lookup_mount: lookup(yp): key "Codemgr_wsdata" not found in map
> >>>> Jun 29 09:04:46 carabas automount[11786]: Debug logging set for /net
> >>>> Jun 29 09:09:22 carabas automount[11786]: get_pkt: message pending on control fifo.
> >>>> Jun 29 09:09:22 carabas automount[11786]: Basic logging set for /net
> >>>>
> >>>> I didn't get the get_pkg message until I turned off debug logging.
> >>>>
> >>>> While logging was set to debug, I tried the hanging ls command again, and
> >>>> I also tried listing a different file system that was actually remote.
> >>>> I didn't see any log messages for those operations.
> >>>>
> >>>> Notes:
> >>>>
> >>>> 1. /etc/host.conf says only:
> >>>>        order hosts, bind
> >>>>        multi on
> >>>>
> >>>> 2. No mount.nfs processes are running when the ls command hangs
> >>>>     on the local mount.
> >>>>
> >>>>
> >>>> Ian Kent wrote:
> >>>>> On Wed, 2010-06-23 at 11:32 -0700, Chris Quenelle wrote:
> >>>>>> Thanks for your time guys!
> >>>>>>
> >>>>>> It turns out it's not a general bug.  I was just applying
> >>>>>> a pessimistic interpretation without checking.
> >>>>>>
> >>>>>> After more testing, it turns out it's just problem
> >>>>>> on one machine, for two mount points under one
> >>>>>> host alias.
> >>>>>>
> >>>>>> I'm interested in knowing more about how I could
> >>>>>> debug the situation without just rebooting and
> >>>>>> hoping it doesn't happen again.
> >>>>>>
> >>>>>> Here's my scenario:
> >>>>>>
> >>>>>> I have three exported filesystems.
> >>>>>> I can use three host aliases to refer to my own machine.
> >>>>>> (carabas, carabas.sfbay, carabas.sfbay.sun.com)
> >>>>>>
> >>>>>> /etc/hosts says:
> >>>>>> [IP addr]     carabas.sfbay.sun.com carabas
> >>>>>>
> >>>>>>
> >>>>>> All filesystems work under all /net/foo aliases
> >>>>>> except two of them hang when accessed via one
> >>>>>> of the host aliases.
> >>>>> Are you sure the address lookup is returning what you think it does?
> >>>>> What's in /etc/host.conf?
> >>>>>
> >>>>>> % showmount -e localhost
> >>>>>> Export list for localhost:
> >>>>>> /export/home3 *
> >>>>>> /export/home2 *
> >>>>>> /export/home1 *
> >>>>>>
> >>>>>>
> >>>>>> % df -kl
> >>>>>> Filesystem           1K-blocks      Used Available Use% Mounted on
> >>>>>> /dev/sda2             69575344   3408900  66166444   5% /
> >>>>>> udev                   8222568       148   8222420   1% /dev
> >>>>>> /dev/sdb1             71671728  26507132  45164596  37% /export/home1
> >>>>>> /dev/sdc1             71671728   8545196  63126532  12% /export/home2
> >>>>>> /dev/sdd1             71671728   5375672  66296056   8% /export/home3
> >>>>>> /export/home1         71671728  26507128  45164600  37% /net/carabas/export/home1
> >>>>>> /export/home2         71671728   8545196  63126532  12% /net/carabas.sfbay/export/home2
> >>>>>> /export/home1         71671728  26507128  45164600  37% /net/carabas.sfbay/export/home1
> >>>>>> /export/home3         71671728   5375672  66296056   8% /net/carabas.sfbay/export/home3
> >>>>>> /export/home1         71671728  26507128  45164600  37% /net/carabas.sfbay.sun.com/export/home1
> >>>>>> /export/home2         71671728   8545196  63126532  12% /net/carabas.sfbay.sun.com/export/home2
> >>>>>> /export/home3         71671728   5375672  66296056   8% /net/carabas.sfbay.sun.com/export/home3
> >>>>>>
> >>>>>>
> >>>>>> % strace ls /net/carabas/export/home2
> >>>>>> ...
> >>>>>> ...
> >>>>>> mmap(NULL, 217016, PROT_READ, MAP_SHARED, 4, 0) = 0x2b2388370000
> >>>>>> close(4)                                = 0
> >>>>>> close(3)                                = 0
> >>>>>> open("/net/carabas/export/home2", O_RDONLY|O_NONBLOCK|O_DIRECTORY<unfinished ...>
> >>>>> What does a ps listing give you when it is blocked?
> >>>>> Any mount.nfs processes?
> >>>>>
> >>>>> That's sign that automount thinks that the mount isn't local and is
> >>>>> probably trying to mount from a possibly non-existent ip address.
> >>>>>
> >>>>>> I hit ctrl-C when the ls command hangs.  Above is the tail of the strace output.
> >>>>>> It doesn't tell you much, the interesting stuff happens in the automounter.
> >>>>>>
> >>>>>> Is there a error log file for the automounter that is enabled by default?
> >>>>>> Is there an easy recipe for restarting the automounter with debugging output on?
> >>>>> You need to ensure that debug logging is being recorded in syslog.
> >>>>> Ensure you are sending daemon.* somewhere.
> >>>>>
> >>>>> Then
> >>>>>
> >>>>> automount -l debug /net
> >>>>>
> >>>>> will start the debug logging and
> >>>>>
> >>>>> automount -l err /net
> >>>>>
> >>>>> will set it back to no logging.
> >>>>>
> >>>>> That is depending on the version of autofs you are using.
> >>>>>
> >>>>> If you don't see this option in the automount(8) man page you don't have
> >>>>> this option and all you can do is enable debug logging in the
> >>>>> configuration.
> >>>>>
> >>>>> Ian
> >>>>>
> >>>>>
> >>>
> > 
> > 
> 
