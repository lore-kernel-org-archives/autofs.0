From: Ian Kent <raven@themaw.net>
Subject: Re: Handling mount attempts to down NFS servers
Date: Thu, 13 Jan 2011 15:45:00 +0800
Message-ID: <1294904700.2757.40.camel@perseus>
References: <Pine.LNX.4.62.1101111244350.5250@gate.nmr.mgh.harvard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=QmFsemTre0yhHiFNt3iiaa0H1ss=;
	b=Jpuzi4hFhQOWkkelL2zaakgeryrTroEifFcb0FD8UD0UdkDiQXkmt+jqAe8NX/FovADQg/dVWiRuBzn6h1Zc/EknAtfcAlnr0Cz2lXfxFwjHgrvg6lFdhE4fJFVTEVi9aaQKNcXzckN84DWZqNi6zoKiinDFvgT+kuHuuYCBs/k=
In-Reply-To: <Pine.LNX.4.62.1101111244350.5250@gate.nmr.mgh.harvard.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Paul Raines <raines@nmr.mgh.harvard.edu>
Cc: autofs@linux.kernel.org

On Tue, 2011-01-11 at 12:51 -0500, Paul Raines wrote:
> I found many users asking this on google search, but no solutions.
> 
> Is there a way to make the '/bin/mount -t nfs' calls autofs makes
> timeout faster when the server being accessed is down?
> 
> Barring that, is there a way to make it such that when there is
> '/bin/mount -t nfs' attempt going on that is hung, other mount attempts
> to perfectly working servers during that time do not also hang?
> This is what is really a killer.
> 
> One thought I had is to add 'bg' to the mount options in the map files
> but I am scared that might cause 100s of hung mount attempts to pile up.
> 
> I am using a mix of CentOS4.8 (autofs-4.1.4-2) and CentOS5.5
> (autofs-5.0.1-0.rc2.143.el5_5.6) boxes.

Did you look in /etc/sysconfig/autofs for the CentOS5 boxes.

# MOUNT_WAIT - time to wait for a response from umount(8).
#              Setting this timeout can cause problems when
#              mount would otherwise wait for a server that
#              is temporarily unavailable, such as when it's
#              restarting. The defailt of waiting for mount(8)
#              usually results in a wait of around 3 minutes.
#
#MOUNT_WAIT=-1

Admittedly there is a typo, umount(8) should be mount(8). This has been
present since revision 133. It isn't the best as it is difficult to
locate the actual mount process so it is left to timeout, but it does
allow autofs to continue.

I don't think your chances are very good of getting anything into
CentOS4.

Ian
