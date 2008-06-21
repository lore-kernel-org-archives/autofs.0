From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Fri, 20 Jun 2008 18:02:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0806201713350.13828@xena.cft.ca.us>
References: <20080423185018.122C53C3B1@xena.cft.ca.us> 
	<1213414942.18072.26.camel@raven.themaw.net>
	<1213845274.2971.11.camel@raven.themaw.net>
	<20080619183446.532D82111B1@simba.math.ucla.edu>
	<1213934961.2971.69.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1213934961.2971.69.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Fri, 20 Jun 2008, Ian Kent wrote:

> So here is autofs-5.0.3-submount-shutdown-recovery-8.patch.
> Please try it instead of revision 7.

The patch went on cleanly.  However, there was a problem in execution.
The output was:

17:00:14 --                   #1, chkd 0, run 0, OK 570, mtd 2, of 570

Jun 20 17:00:22 serval automount[2799]: unexpected pthreads error: -1 at 
901 in master.c

After patching this is in:
void master_signal_submount(struct autofs_point *ap, unsigned int action)
        status = pthread_barrier_wait(&ap->submount_barrier);
        if (status)
                fatal(status);

I'm not sure what's frozen; the machine responds to ping, but I can't do 
ssh to it, and I'm not at work.  I would have expected needed NFS resources 
to already be mounted, from the session that started up the test program.

Any ideas what went wrong?  I can commandeer another machine for the next 
test, since the owner is also not at work.

About setting up a test environment: We have 133 Linux boxes (a few of 
these are down), so you would need a lot of hosts.  I was thinking how to 
do this.  How about lots of UML or Xen virtual machines, each exporting 
maybe 2 NFS filesystems.  

I'm most familiar with UML.  I have some rather old notes on UML here:
http://www.math.ucla.edu/~jimc/documents/uml-install-suse.html

I think your best bet is to create a COW (copy on write) file with the 
standard configuration, then cover it with a writeable image file for each 
virtual guest; the latter would occupy only a few hundred Kb each since 
most of the material would be in the COW (readonly).  Allow at most 16 Mb 
"physical" memory per guest, and perhaps even forget the swap file.  This 
lets you pack 64 UML instances per Gb of physical memory on the host 
(except allow some uncommitted physical memory for the host kernel and 
daemons).  This will keep the host CPU hopping, but in reality the guest 
systems will only be giving out and cancelling mounts from the test 
machine, one at a time, so the host CPU load should be manageable.

On the guest image you can ease your life by creating a small file, maybe 
64 Kb of zeroes, assign it to a loopback device, and put a filesystem on 
it.  In one application I used Minix because it's compact yet supports 
normal UNIX semantics.  Mount it, create a single file with a unique ID,
and export it.  From the contained file you can verify which host and which 
of its 2 filesystems you actually mounted.  The UML guest can do the 
loopback thing if it was given a complete set of modules (SuSE's UML has 
it).  

If you actually go ahead with this, tell me and I'll send you the test 
program.  The automount maps go like this:

auto.master:
/net            /etc/auto.net

auto.net: (backslash is not really there)
*       -rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&    \
						file:/etc/auto.net.generic

auto.net.generic:
*       ${SERVER}:/&


Good luck, you're going to need it :-)

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
