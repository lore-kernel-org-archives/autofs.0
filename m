From: Bruce Man <BurgessKo2@gmail.com>
Subject: Re: Is Autofs 5 Slower Than 4
Date: Fri, 26 Apr 2013 18:04:32 +0000 (UTC)
Message-ID: <loom.20130426T193612-644@post.gmane.org>
References: <241046.64511.qm@web54306.mail.re2.yahoo.com> <x4963pvybdk.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org

Jeff Moyer <jmoyer <at> redhat.com> writes:

> 
> Thanh Tran <ttran7700 <at> yahoo.com> writes:
> 
> > I upgraded my entire OS from Fedora 5 to 8.  By slow, I mean around 20
> > seconds to detect and mount.  There are too many variables.  I was
> > hoping it would be a simple polling flag that could be switched in
> > autofs.  I can live with the slower time.  I did notice that it took a
> > long time only when I physically removed the drive and re-inserted the
> > drive.  When I use the "umount" command and not remove the drive, I
> > can quickly change directory back to drive and it mounts in like 2
> > seconds at most.  Thanks for the help.
> 
> I'm still a little unclear on your use case.  Are you sure you're using
> autofs to mount your (usb?) drive?  This is typically handled by hal in
> newer distributions.
> 
> Cheers,
> 
> Jeff
> 

I met the same problem. My linux is CentOS 6.4 and installed AutoFS 1.9.2.
When I un-plug my USB disk and plug it back, it take a long time (about 20
seconds) to mount the USB drive.

But .... if doing the following step
1. Manually umount the USB drive by command line
2. Un-plug it
3. Plug USB drive back to the PC
4. AutoFS will recognize fast (Within 2 seconds)

Would someone tell me why??

The following is my configuration about AutoFS
#-----------<< auto.master >>-----------------------------
/mnt           /etc/auto.usb     --timeout 1
/net           -host
+auto.master
#-----------<< EndOfFile >>-------------------------------

#-----------<< auto.usb >>--------------------------------
usb_disk       -fstype=vfat      UUID="ECA3-7F95"
#-----------<< EndOfFile >>-------------------------------

Cheers,
Bruce Man

