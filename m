From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: rm hangs on symlinks to down mount points
Date: Tue, 30 Dec 2003 15:09:23 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FF205A3.7000609@zytor.com>
References: <Pine.LNX.4.44.0312301639450.24097-100000@gate.nmr.mgh.harvard.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312301639450.24097-100000@gate.nmr.mgh.harvard.edu>
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
To: Paul Raines <raines@nmr.mgh.harvard.edu>
Cc: autofs@linux.kernel.org

Paul Raines wrote:
> 
> If you try to delete linkfile, it hangs forever.  Seems to never timeout
> or work.   Doing a strace shows it hanging to a system stat() call
> on the pointed to file.
> 
> First, it seems fundamentally wrong that doing an unlink() on a symlink
> causes a stat() call on the pointed to file.  Seems a huge waste.
> 

It doesn't; however rm(1) apparently does.

	-hpa
