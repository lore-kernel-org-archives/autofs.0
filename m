From: Ian Kent <raven@themaw.net>
Subject: Re: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port
	usage problems
Date: Tue, 30 Aug 2005 09:16:59 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0508300844110.24684@wombat.indigo.net.au>
References: <20050825221428.GC1867@robsims.com>
	<Pine.LNX.4.58.0508261141230.2586@wombat.indigo.net.au>
	<20050826161454.GA3465@robsims.com>
	<Pine.LNX.4.63.0508271125440.2069@donald.themaw.net>
	<20050829152050.GA28102@robsims.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050829152050.GA28102@robsims.com>
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
Cc: autofs mailing list <autofs@linux.kernel.org>

On Mon, 29 Aug 2005, Rob Sims wrote:

> On Sat, Aug 27, 2005 at 11:34:09AM +0800, Ian Kent wrote:
> > The attempt to remount on umount fail has always been a contentious in my 
> > opinion, however I`ve yet to see a situation that hasn't been caused by 
> > something else that needs to be fixed.
> 
> I agree - remounting something that is already mounted should be a no-op
> in the nfs system.
> 
> > I thought I asked for versions?
> > Can we have`em.
> 
> Sorry - locally-compiled kernel 2.4.23, using autofs4 as a module.
> Debian packaging of autofs, 3.9.99-4.0.0pre10-1.  Have unconfirmed
> sightings on kernel 2.6.8, autofs 4.1.3+4.1.4beta2-10.  I don't think
> these sightings are credible.  No reports since dropping the number of
> exports.

Have you patched your 2.4 kernel with the autofs kernel patch?
As the versions of autofs increase it's more likely not to work properly.

There are kernel patches for 2.4 and 2.6. There are a couple of unreleased 
bug fixes in addition to these.

Try http://www.kernel.org/pub/linux/daemons/autofs/v4.

This version of user space autofs is way old.

The fix for the problem you describe was introduced late in 4.1.3 before 
going to 4.1.4 and I believe it is included in the Sarge version.

4.1.3+4.1.4beta2-10 was included in 3.1. Steinar Gunderson has put in 
quite a bit of effort on this. It should, almost certainly, be better 
than the version you are running now.

> 
> > If neccessary looking at the code will tell if you have what's needed to 
> > avoid this. Send me a copy of parse_sun.c from the source you are using 
> > and I'll check.
> 
> I'm using the Debian woody package.  The following is from the source
> package after unpacking and building (which applies any patches).
> http://www.robsims.com/parse_sun.c
> 

Thanks but I don't think I need to look at it now.

> I'll poke around the source some more.  What I want to know is:
> 1) Are all the child mounts unmounted before unmounting the parent?
> 2) If not, were the system calls successful?
> 3) If the system calls failed, what were the error codes?
> 4) If all child mounts were in fact unmounted, why is the parent busy?
> 

Don't waste your time. Your version is to old.

The only thing I would say about the questions above is that autofs takes 
advantage of mounts ability to mount stuff. So to some extent mounting is 
a pass or fail activity. OTOH autofs seems to get buy well enough using 
this and the pain of keeping up with new filesystems and mount options is 
.

Ian
