From: Ian Kent <raven@themaw.net>
Subject: Re: Infinite loop when trying to access nonexistent
	directory (auto.home '&' substitution)
Date: Tue, 19 Oct 2004 11:48:10 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410191147320.7757@wombat.indigo.net.au>
References: <Pine.LNX.4.61.0410151425360.7091@orion.arlut.utexas.edu>
 <Pine.LNX.4.58.0410161143240.8831@donald.themaw.net>
 <Pine.LNX.4.61.0410161825450.10308@orion.arlut.utexas.edu>
 <Pine.LNX.4.58.0410171433160.9440@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410171433160.9440@donald.themaw.net>
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
To: Robert Giles <rgiles@arlut.utexas.edu>
Cc: autofs@linux.kernel.org

On Sun, 17 Oct 2004, Ian Kent wrote:

> On Sat, 16 Oct 2004, Robert Giles wrote:
> 
> > On Sat, 16 Oct 2004 raven@themaw.net wrote:
> > > And at least 2 hunks in the patch failed, right?
> > > One against fs/namei.c.
> >
> > Right, and the other failed portion was against a configuration text file
> > (Documentation/something).
> 
> That confirms it's 2.4.27. That's correct behaviour as those particular
> hunks are included in the vanila source now.
> 
> >
> > I haven't explicitly tested 2.4.25 for the same problem, but over the
> > course of several months I never had a 2.4.25 machine fill up
> > /var/log/syslog with these automount errors (with 2.4.27, the disk fills
> > up so rapidly that folks regularly ask me why their machine doesn't have
> > any space on /...   basically have to "/etc/init.d/syslog stop" on these
> > hosts until I can correct the problem).
> 
> I'm building a 2.4.27 kernel now on my Sparc Ultra 1 (yep it's going to
> take all day).
> 
> I'll see what I can find out.

Still having a bit of trouble with my build. Should be sorted tonight.

> 
> As a side note.
> 
> >From 2.4.27 you can use the kernel module build kit without having to
> rebuild your kernel. You do however need a set of kernel headers that
> correspond to the running kernel. Using this you can build, install and
> uninstall the updated module.
> 
> That would be the autofs4-2.4-module-20040508.tar.gz on kernel.org. Ignore
> the mandatory patches as they are the ones already in 2.4.27.
> 
> Ian
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
