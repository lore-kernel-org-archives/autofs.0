From: Greg Wooledge <wooledg@eeg.ccf.org>
Subject: Re: [RFC] Towards a Modern Autofs
Date: Wed, 7 Jan 2004 09:05:25 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040107140525.GE20597@eeg.ccf.org>
References: <6AB920CC10586340BE1674976E0A991D0C6BE4@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <6AB920CC10586340BE1674976E0A991D0C6BE4@slexch2.sugarland.unocal.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>

On Tue, Jan 06, 2004 at 04:28:59PM -0600, Ogden, Aaron A. wrote:
> On those occasions where the autofs daemon gets confused
> (loses track of mountpoints, gets corruption in its internal
> representation of NIS maps, etc.) we could shut down the autofs daemon,
> kill any remaining processes, and restart it from scratch.  In most
> cases restarting the daemon fixes the problem.  It's worth noting that I
> have seen this happen on Solaris 2.6 as well but it is extremely rare.

I do it on HP-UX 10.20 all the time.  Lots of stale NFS handles, or
something just isn't working right?  Stop and restart the automount
daemons (/sbin/init.d/nfs.client), and that usually fixes it.  The one
or two times I made the mistake of trying that on Linux, I had to reboot
the box to get it to work again.
