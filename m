From: raven@themaw.net
Subject: Re: Replicated hosts in autofs v4.
Date: Tue, 12 Oct 2004 20:22:15 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410122020430.1778@donald.themaw.net>
References: <bf092570041010091873f86c2f@mail.gmail.com>
 <200410110053.40587.vda@port.imtp.ilyichevsk.odessa.ua>
 <16746.42133.679569.866410@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0410120935520.32308@wombat.indigo.net.au>
 <Pine.LNX.4.58.0410112111140.6187@xena.cft.ca.us> <416B9E9D.6010108@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <416B9E9D.6010108@sun.com>
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
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs@linux.kernel.org

On Tue, 12 Oct 2004, Mike Waychison wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Jim Carter wrote:
> > On Tue, 12 Oct 2004, Ian Kent wrote:
> > 
> >>On Mon, 11 Oct 2004, Jeff Moyer wrote:
> >>
> >>> Server proximity takes priority in the  selection  process.
> >>
> >>Mike, can we define "proximity" and "same network segment" as used in the 
> >>Solaris automounter please (if that's possible).
> > 
> > 
> > The desired behavior (and I think this is what our Sun boxes actually do)  
> > is that if the client has an interface such that (clientIP & netmask) ==
> > (serverIP & netmask) (using the client's same netmask for both), then that
> > server is preferred because the traffic goes direct, not through a router.  
> > The client might have multiple interfaces.
> > 
> 
> I believe this is the right interpretation of the 'weight override' bit
> that Jeff posted from the Solaris automount(1m) manpage.
> 
> However, I believe that algorithm uses some sort of traceroute/rpcping
> to figure out distances and weights are used to prioritize given equal
> distances.  I'll ask around to see what the actual method used is. (a
> tcpdump of this may prove useful ;)

OK. The traceroute idea is good but we have had people with port blocking 
so this would have to be quite smart.

Ian
