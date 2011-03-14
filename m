From: Ian Kent <raven@themaw.net>
Subject: Re: autofs problem
Date: Mon, 14 Mar 2011 22:59:29 +0800
Message-ID: <1300114769.6620.2.camel@perseus>
References: <000501cbdd83$5e9a35d0$1bcea170$@admin@uea.ac.uk>
	<1299979760.2906.3.camel@perseus>
	<000101cbe22f$df5d3900$9e17ab00$@admin@uea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=Qyij2DUJ5IUIk1fMGPp3yNYWHvk=;
	b=s+KhieZl5Q3S2ABI6M9yR7oKFVa5QZ/Z+APPUKb1WOehydBYxHGPggQ3cGhXhIBjidCX0YkaZ7ADT3YIFTa22lonT4vIJuAvxQr4Qas7tgH7iW6S8s5la9S3jz9SYcX4IwZw9smuAbM31nVb0t1YEfDYkCOWknIIXb0iwXCWVrM=
In-Reply-To: <000101cbe22f$df5d3900$9e17ab00$@admin@uea.ac.uk>
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
To: hpc.admin@uea.ac.uk
Cc: autofs@linux.kernel.org

On Mon, 2011-03-14 at 10:09 +0000, hpc.admin@uea.ac.uk wrote:
> Hello Ian,
> 
> Thank you for your reply. The contents of /etc/sysconfig/autofs are:
> 
> [root@head00 ~]# grep -v '^#' /etc/sysconfig/autofs
> TIMEOUT=300
> BROWSE_MODE="no"
> USE_MISC_DEVICE="yes"
> [root@head00 ~]#
> 
> When the machine boots up, it completely fails to mount /home/<username>; it
> just complains that /home/<username> doesn't exist. The contents of
> /var/log/messages then show the message given below, thus I assume that they
> are related. Do let me know if you require further information. Googling
> around for the error message hasn't been very successful :-( 

Failing to open a control file handle on an automount is fatal.
I don't know why that's happening.

We would probably need to add some log prints to get more information.

> 
> Thanks for your help,
> Wadud.
> 
> >-----Original Message-----
> >From: hpc.admin-bounces@uea.ac.uk [mailto:hpc.admin-bounces@uea.ac.uk] On
> >Behalf Of Ian Kent
> >Sent: Sunday, March 13, 2011 1:29 AM
> >To: hpc.admin@uea.ac.uk
> >Cc: autofs@linux.kernel.org
> >Subject: Re: [autofs] autofs problem
> >
> >On Tue, 2011-03-08 at 11:24 +0000, hpc.admin@uea.ac.uk wrote:
> >> Hello,
> >>
> >> I am experiencing autofs problems with my Centos 5.5 system. Upon boot,
> the
> >> mount fails with the following error messages (created by passing the -d
> >> option in the automount):
> >>
> >> Mar  8 10:38:19 cn024 automount[6395]: do_notify_state: signal 15
> >> Mar  8 10:38:19 cn024 automount[6395]: master_notify_state_change: sig 15
> >> switching /home from 1 to 5
> >> Mar  8 10:38:19 cn024 automount[6395]: st_prepare_shutdown: state 1 path
> >> /home
> >> Mar  8 10:38:19 cn024 automount[6395]: expire_proc: exp_proc = 1090562368
> >> path /home
> >> Mar  8 10:38:19 cn024 automount[6395]: expire_cleanup: got thid
> 1090562368
> >> path /home stat 0
> >> Mar  8 10:38:19 cn024 automount[6395]: expire_cleanup: sigchld: exp
> >> 1090562368 finished, switching from 5 to 7
> >> Mar  8 10:38:19 cn024 automount[6395]: st_shutdown: state 5 path /home
> >> Mar  8 10:38:19 cn024 smartd[7258]: smartd has fork()ed into background
> >> mode. New PID=7258.
> >> Mar  8 10:38:19 cn024 automount[6395]: umount_multi: path /home incl 0
> >> Mar  8 10:38:19 cn024 automount[6395]: umounted indirect mount /home
> >> Mar  8 10:38:19 cn024 automount[6395]: automount_path_to_fifo: fifo name
> >> /var/run/autofs.fifo-home
> >> Mar  8 10:38:19 cn024 automount[6395]: shut down path /home
> >> Mar  8 10:38:19 cn024 automount[6395]: autofs stopped
> >> Mar  8 10:38:28 cn024 automount[7334]: Starting automounter version
> >> 5.0.1-0.rc2.143.el5, master map auto.master
> >> Mar  8 10:38:28 cn024 automount[7334]: using kernel protocol version 5.01
> >> Mar  8 10:38:28 cn024 automount[7334]: lookup_nss_read_master: reading
> >> master files auto.master
> >> Mar  8 10:38:28 cn024 automount[7334]: parse_init: parse(sun): init
> gathered
> >> global options: (null)
> >> Mar  8 10:38:28 cn024 automount[7334]: lookup_read_master: lookup(file):
> >> read entry /home
> >> Mar  8 10:38:28 cn024 automount[7334]: master_do_mount: mounting /home
> >> Mar  8 10:38:28 cn024 automount[7334]: automount_path_to_fifo: fifo name
> >> /var/run/autofs.fifo-home
> >> Mar  8 10:38:28 cn024 automount[7334]: lookup_nss_read_map: reading map
> file
> >> /etc/auto.home
> >> Mar  8 10:38:28 cn024 automount[7334]: parse_init: parse(sun): init
> gathered
> >> global options: rw,intr
> >> Mar  8 10:38:28 cn024 automount[7334]: do_mount_autofs_indirect: failed
> to
> >> create ioctl fd for autofs path /home
> >> Mar  8 10:38:28 cn024 automount[7334]: handle_mounts: mount of /home
> failed!
> >> Mar  8 10:38:28 cn024 automount[7334]: master_do_mount: failed to startup
> >> mount
> >> Mar  8 10:38:28 cn024 automount[7334]: no mounts in table
> >>
> >> The error messages to note are the last four lines. When I restart the
> >> daemon, the automount works, but fails after a day or two. The version of
> >> autofs I am using is:
> >
> >What makes you think these are the same problem?
> >Did you check to see if /home was already mounted when it failed?
> >What is in your /etc/sysconfig/autofs?
> >
> >>
> >> Name        : autofs                       Relocations: (not relocatable)
> >> Version     : 5.0.1                        Vendor: CentOS
> >> Release     : 0.rc2.143.el5_5.6
> >>
> >> Any help will be greatly appreciated. Thanks in advance.
> >>
> >> ----------
> >> Wadud Miah
> >> High Performance Computing Systems Developer
> >> Research Computing Services, University of East Anglia
> >> Telephone: 01603 593856
> >>
> >> Information Services
> >> ----------
> >>
> >>
> >>
> >> _______________________________________________
> >> autofs mailing list
> >> autofs@linux.kernel.org
> >> http://linux.kernel.org/mailman/listinfo/autofs
> >
> >
> >
> >_______________________________________________
> >Hpc.admin mailing list
> >Hpc.admin@uea.ac.uk
> >http://www.uea.ac.uk/mailman21/listinfo/hpc.admin
> 
