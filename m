From: Ian Kent <raven@themaw.net>
Subject: Re: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port
	usage problems
Date: Sat, 27 Aug 2005 11:34:09 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0508271125440.2069@donald.themaw.net>
References: <20050825221428.GC1867@robsims.com>
	<Pine.LNX.4.58.0508261141230.2586@wombat.indigo.net.au>
	<20050826161454.GA3465@robsims.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050826161454.GA3465@robsims.com>
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
To: Rob Sims <robsims@robsims.com>
Cc: autofs@linux.kernel.org

On Fri, 26 Aug 2005, Rob Sims wrote:

> On Fri, Aug 26, 2005 at 11:44:21AM +0800, Ian Kent wrote:
> > On Thu, 25 Aug 2005, Rob Sims wrote:
>  
> > > > THE PROBLEM DESCRIPTION:
> 
> > > > Autofs hangs and refuses to mount any directories for a period of time
> > > > after cd'ing to /net/<Netapp>/vol/vol[0-3] and waiting a while.
> > > > The only way to clear this is to reboot the client.
> 
> > > I didn't see a resolution to this in the archive - was it resolved?
> > > How?
>  
> > This has come up several times and as far as I know we can resolve or 
> > work around these problems.
>  
> > If you have a problem then we need to establish versions and symptoms to 
> > know what needs to be done to resolve it.
>  
> What we're seeing is very similar to the original poster's description.
> Netapp, 2.4 kernel, hierarchical mounts like:
> vol0
> vol0/a
> vol0/b
> vol1
> vol1/c
> etc.
> 
> The problem seems to have disappeared when we dropped the number of
> exports to under 32.  The log indicates that vol2 couldn't be unmounted
> because it was busy.  My guess is that 33+ unmount requests were issued
> for the children, at least one failed due to lack of resources, and then
> the parent unmount failed because of the failed child unmount.  The
> parent directory is then mounted mupltiple times (one extra per
> expiration?)

Or perhaps the order the export list is returned is no longer a problem.

The attempt to remount on umount fail has always been a contentious in my 
opinion, however I`ve yet to see a situation that hasn't been caused by 
something else that needs to be fixed.

I thought I asked for versions?
Can we have`em.

If neccessary looking at the code will tell if you have what's needed to 
avoid this. Send me a copy of parse_sun.c from the source you are using 
and I'll check.

Ian
