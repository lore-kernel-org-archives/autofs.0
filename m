From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "simultaneous" mounts causing weird behavior
Date: Tue, 04 Nov 2003 09:02:43 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FA7DBB3.1020904@zytor.com>
References: <1067956957.2208.13.camel@aluminum>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1067956957.2208.13.camel@aluminum>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Matthew Mitchell <matthew@geodev.com>
Cc: autofs@linux.kernel.org

Matthew Mitchell wrote:
> Hello,
> 
> On some SMP processing nodes we have in our cluster we are noticing the
> following odd behavior.  It seems like there might be a race condition
> somewhere in automount that results in the same (in this case NFS)
> device mounted twice on the same mountpoint.
> 
> In our case we have a (closed-source, vendor provided) data processing
> app that runs 2-4 processes at a time on each of these nodes.  The
> processes communicate via MPI.  What ends up happening is that each of
> them tries to read data from these NFS-mounted volumes at exactly the
> same time, and sometimes (about one node out of every 10) we get unlucky
> and the disk gets double-mounted.
> 
> Here is the entry from the messages file where the disks are getting
> mounted:
> Nov  2 16:52:53 fir32 automount[674]: attempting to mount entry
> /etvf/data0
> Nov  2 16:52:53 fir32 automount[674]: attempting to mount entry
> /etvf/data0
> 
> (Yes, there are two of them.)
> 

This happens because mount silently changed behaviour -- autofs relies 
on mount only allowing one thing to be mounted on each mount point, but 
that was suddenly changed without warning.

	-hpa
