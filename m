From: Ian Kent <raven@themaw.net>
Subject: Re: umount fails with NFS mounts
Date: Wed, 15 Sep 2004 09:17:31 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0409150914150.20157@wombat.indigo.net.au>
References: <Pine.LNX.4.44.0409142055270.2455-100000@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0409142055270.2455-100000@maggie.lkpg.cendio.se>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Astrand <peter@cendio.se>
Cc: autofs@linux.kernel.org

On Tue, 14 Sep 2004, Peter Astrand wrote:

> > > We are running autofs-3.1.7-36 on RedHat 9, with kernel 2.4.20-30.9smp.  
> > > The mount version is 2.11y. The NFS server is Novell Netware 6.0sp3. Our
> > > auto.master looks like:
> > 
> > Can you upgrade to autofs-4.1.x?  
> 
> Perhaps. Can I expect it to work good on a standard RH9 kernel?

I strongly recommend applying the autofs4 kernel patch (release 20040508).
It is included in the distribution or on kernel.org.

> 
> 
> > attributable to the kernel.  Does Red Hat have a new release with the
> > new kernel?
> 
> Fedora Core contains autofs-4, but I haven't seen such packages for RH9. 

That's not going to change.

You can build from the SRPMS provided by Jeff Moyer at

http://people.redhat.com/jmoyer

Ian
