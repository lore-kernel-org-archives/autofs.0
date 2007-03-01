From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with /net and dropped mounts in 2.6.17.11
Date: Thu, 01 Mar 2007 16:49:57 +0900
Message-ID: <1172735397.3377.9.camel@raven.themaw.net>
References: <CECD6E8A589E8447BC6E836C8369AFF50C784AE0@us-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <CECD6E8A589E8447BC6E836C8369AFF50C784AE0@us-email.terastack.bluearc.com>
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
To: Martin Dorey <mdorey@bluearc.com>
Cc: autofs@linux.kernel.org

On Tue, 2007-02-27 at 18:55 -0800, Martin Dorey wrote:
> > >> /sbin/showmount: can't get address for cvl-xp1/mnt/xp1b
> 
>  
> 
> That's one of the symptoms I recently saw twice but couldn't
> reproduce.  In the email thread ("[autofs] automounted symlink to
> automountsometimesfails,doingDNS query of partial path"), Ian Kent
> said:
> 
>  
> 
> >> This may not be related to your problem but Jeff Moyer and I are
> working
> 
> >> on a resolving a race between mount and expire involving symlinks
> right
> 
> >> now.

But this is a different problem.

> 
> -------------------------------------
> Martin's Outlook, BlueArc Engineering
> 
> 
>                                    
> ______________________________________________________________________
> From: autofs-bounces@linux.kernel.org
> [mailto:autofs-bounces@linux.kernel.org] On Behalf Of Brian Weaver
> Sent: Monday, February 26, 2007 7:21
> To: autofs@linux.kernel.org
> Subject: [autofs] Problem with /net and dropped mounts in 2.6.17.11
> 
> 
>  
> 
> Greetings,
> 
> We recently moved one of our projects from 2.6.12 up to 2.6.17.11 for
> some hardware enablement reasons, but now we are seeing mounts
> consistently drop.
> 
> We have a dedicated NFS fileserver with 9 exported mount points. Our
> Linux clients 
> are using /etc/auto.net to mount these on /net.  Everything works fine
> on initial
> startup, all of the mounts show up fine, but then after a while, one
> of the mounts
> disappears, is no longer mounted or in /etc/mtab, and automounter logs
> the following 
> to syslog whenever we try to access the mount:
> 
> Feb 26 08:01:08 fclw436 automount[25387]: >> /sbin/showmount: can't
> get address for cvl-xp1/mnt/xp1b 
> Feb 26 08:01:08 fclw436 automount[25387]: lookup(program): lookup for
> cvl-xp1/mnt/xp1b failed 
> Feb 26 08:01:08 fclw436 automount[25387]: failed to
> mount /net/cvl-xp1/mnt/xp1b 
> 
> 
> 
> So it looks like showmount is actually failing.. It shouldn't be
> looking up host cvl-xp1/mnt/xp1b.. 
> 
> Am I just running into an old showmount bug? 
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
