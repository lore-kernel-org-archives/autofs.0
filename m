From: Paul Raines <raines@nmr.mgh.harvard.edu>
Subject: Re: rm hangs on symlinks to down mount points
Date: Tue, 30 Dec 2003 18:37:29 -0500 (EST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0312301833520.24097-100000@gate.nmr.mgh.harvard.edu>
References: <3FF208E2.2000304@zytor.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FF208E2.2000304@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org

On Tue, 30 Dec 2003, H. Peter Anvin wrote:
> > It would be nice if one could configure a timeout in autofs for
> > mounting though separate from something like 'timeo' in the nfs options.
>  >
> 
> s/autofs/mount(8)/.
> 
> Not autofs' job.
> 

Maybe not, but it could be done through autofs. There would probably be
alot more resistance to getting mount's API changed for support of separate
timeout value just for the mount side of things.

The master automount process could just kill the automount subprocess
spawned to do a mount if it doesn't complete in X number of seconds.

> > I am often getting automount processes that are hung and don't die
> > with a simple kill.  I can "kill -9" them but that leaves things in 
> > a bad state usually (though sometimes I will just hand edit /etc/mtab
> > so I can get something done).
> 
> That's why they don't die with a simple kill.

Which is a pain.  Just because some remote server went down I had 
automounted should not force me into a reboot of the client.
