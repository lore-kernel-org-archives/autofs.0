From: raven@themaw.net
Subject: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port 
	usage problems
Date: Sat, 15 Jan 2005 10:50:59 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501151035230.1597@donald.themaw.net>
References: <200501142238.j0EMcbOT002214@jetcar.spd.analog.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200501142238.j0EMcbOT002214@jetcar.spd.analog.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@sun.com>

On Fri, 14 Jan 2005, David Meleedy wrote:

>
> Ian,
> 	I have installed the multi-over patch into our version
> of the automounter 4.1.3-67 (with updated large-program-map patch)
> and so far everything looks great!  I am going to test our machines
> for a longer period of time and make sure everything looks stable,
> but so far, so good!

That sounds very encouraging. Great!

>
> It seems to have eliminated the "BUG" message in the messages file,
> and it seems as though the automounter can unmount /net/aflac
> which it was not able to do in the past during a reboot.  I suspect
> that this means it will use a lot less ports, and I might not
> even need the kernel patch (given the small amount of mounts we actually
> use) -- I am testing this as well.

The BUG messages were placed there to identify this happening as this 
problem has come up in various forms several times.

In this case it appears to be caused by the order in which the mounts are 
done (ie. received from auto.net). Given that current autofs 
implementation of multi-mounts must handle them as a single unit, nested 
filesystem mounts, made in the wrong order, cause overmounting which 
caused the umount problem.

Perhaps.

Depends on whether the mount program has the patch which probes the 
NFS server. The port usage problem still remains and I expect it will 
continue to cause problems for us one way or another. Hopefully it will be 
addressed in the near future.

Regards
Ian
