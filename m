From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: rm hangs on symlinks to down mount points
Date: Tue, 30 Dec 2003 15:23:14 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FF208E2.2000304@zytor.com>
References: <Pine.LNX.4.44.0312301814510.24097-100000@gate.nmr.mgh.harvard.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312301814510.24097-100000@gate.nmr.mgh.harvard.edu>
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
> Yes, so I guess it is mostly rm's fault.  I have already complained to
> the fileutils package writers about df which will do a stat on every
> mount even if you pass df a specific mount point.  So on my central
> system which often has over 50 automounts going at once with one of
> the servers almost always offline, df never works.  quota never works
> either.
> 
> It would be nice if one could configure a timeout in autofs for
> mounting though separate from something like 'timeo' in the nfs options.
 >

s/autofs/mount(8)/.

Not autofs' job.

> I am often getting automount processes that are hung and don't die
> with a simple kill.  I can "kill -9" them but that leaves things in 
> a bad state usually (though sometimes I will just hand edit /etc/mtab
> so I can get something done).

That's why they don't die with a simple kill.

	-hpa
