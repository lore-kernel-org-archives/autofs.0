From: Ian Kent <raven@themaw.net>
Subject: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port 
	usage problems
Date: Tue, 18 Jan 2005 09:31:20 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0501180922310.32570@wombat.indigo.net.au>
References: <200501142238.j0EMcbOT002214@jetcar.spd.analog.com>
	<Pine.LNX.4.61.0501151035230.1597@donald.themaw.net>
	<16875.53538.836665.652032@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16875.53538.836665.652032@segfault.boston.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@sun.com>, David Meleedy <david.meleedy@analog.com>

On Mon, 17 Jan 2005, Jeff Moyer wrote:

> ==> Regarding Re: [autofs] BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port  usage problems; raven@themaw.net adds:
> 
> raven> On Fri, 14 Jan 2005, David Meleedy wrote:
> >> Ian, I have installed the multi-over patch into our version of the
> >> automounter 4.1.3-67 (with updated large-program-map patch) and so far
> >> everything looks great!  I am going to test our machines for a longer
> >> period of time and make sure everything looks stable, but so far, so
> >> good!
> 
> raven> That sounds very encouraging. Great!
> 
> Very encouraging indeed.  Good catch, Ian!
> 
> >> It seems to have eliminated the "BUG" message in the messages file, and
> >> it seems as though the automounter can unmount /net/aflac which it was
> >> not able to do in the past during a reboot.  I suspect that this means
> >> it will use a lot less ports, and I might not even need the kernel patch
> >> (given the small amount of mounts we actually use) -- I am testing this
> >> as well.
> 
> raven> The BUG messages were placed there to identify this happening as
> raven> this problem has come up in various forms several times.
> 
> raven> In this case it appears to be caused by the order in which the
> raven> mounts are done (ie. received from auto.net). Given that current
> raven> autofs implementation of multi-mounts must handle them as a single
> raven> unit, nested filesystem mounts, made in the wrong order, cause
> raven> overmounting which caused the umount problem.
> 
> raven> Perhaps.
> 
> raven> Depends on whether the mount program has the patch which probes the
> raven> NFS server. The port usage problem still remains and I expect it
> raven> will continue to cause problems for us one way or another. Hopefully
> raven> it will be addressed in the near future.
> 
> Hmm, I wonder what probing it actually does.  I'll have a look and see if
> we can change the probe code to use non-reserved ports.

I looked at the code in an FC2 mount and found that it did quite a bit 
of probing.

In itself this is probably a good thing as it's more comprehensive than 
what I do for replicated server mount entries and it may be a precursor to 
providing that functionality in mount. This just means that we need to get 
a handle on the objections to RPC transport multiplexing and get it done.

Using non-priveledged ports has other dependencies. For example, on Debian 
with 2.4.27 mountd rejects connections from non-priveledged ports. I 
didn't spend much time to find out if I could work around it but never the 
less it likely will generate a bit of noise.

Ian
