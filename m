From: raven@themaw.net
Subject: Re: Replicated hosts in autofs v4.
Date: Tue, 12 Oct 2004 20:44:53 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410122040060.1813@donald.themaw.net>
References: <bf092570041010091873f86c2f@mail.gmail.com>
 <200410110053.40587.vda@port.imtp.ilyichevsk.odessa.ua>
 <16746.42133.679569.866410@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0410120935520.32308@wombat.indigo.net.au>
 <Pine.LNX.4.58.0410112111140.6187@xena.cft.ca.us>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410112111140.6187@xena.cft.ca.us>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org

On Mon, 11 Oct 2004, Jim Carter wrote:

> On Tue, 12 Oct 2004, Ian Kent wrote:
> > On Mon, 11 Oct 2004, Jeff Moyer wrote:
> > >  Server proximity takes priority in the  selection  process.
> > 
> > Mike, can we define "proximity" and "same network segment" as used in the 
> > Solaris automounter please (if that's possible).
> 
> The desired behavior (and I think this is what our Sun boxes actually do)  
> is that if the client has an interface such that (clientIP & netmask) ==
> (serverIP & netmask) (using the client's same netmask for both), then that
> server is preferred because the traffic goes direct, not through a router.  
> The client might have multiple interfaces.
>

Yes, I thought of that but it occured to me that we may not want to use a 
server on the the same subnet. For example, on a multiple subnet gigabit 
network we might want to find the least loaded server. So this approach 
might be unreliable.

> If there are multiple servers and one is down, another can be tried after a
> brief timeout.  But what really interests me is hot failover:  you already
> mounted server "A", which dies.  The automounter is magically aware of
> this, and mounts server "B".  Can of worms: Processes with open files
> (readonly of course) in the dead filesystem, you would like to transfer
> them transparently to presumably identical files from the other server. 
> In a map row with multiple servers, all share the same mount point, so how
> do you dispose of the corpse so you can mount the other server on the 
> same-named mount point?  None of this will be easy.

Mmmm. NFS kernel land I think.
We'll have to be extra polite to the NFS gents!

Ian
