From: Ian Kent <raven@themaw.net>
Subject: Re: rm hangs on symlinks to down mount points
Date: Wed, 31 Dec 2003 22:54:32 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0312312252130.4678-100000@raven.themaw.net>
References: <Pine.LNX.4.44.0312310919320.24097-100000@gate.nmr.mgh.harvard.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312310919320.24097-100000@gate.nmr.mgh.harvard.edu>
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
To: Paul Raines <raines@nmr.mgh.harvard.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Wed, 31 Dec 2003, Paul Raines wrote:

> 
> I believe I made a mistake and feel pretty stupid now.  I think the hung
> automount subprocesses are not hanging on the mount but on the umount.  
> Does autofs ever call umount with the -f option after the first (few)
> regular umount's fail. If autofs has made a mount, the server dies, then
> the mount times out from no use so autofs wants to umount it, how does
> autofs handle the situation?
> 

No. It never uses the -f option.

I think the -f option is safe enough though. It probably should do 
something like that. But the -l option sounds like it could lead to 
strife.

Ian
