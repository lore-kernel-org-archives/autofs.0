From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: rm hangs on symlinks to down mount points
Date: Tue, 30 Dec 2003 15:57:58 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FF21106.4000907@zytor.com>
References: <Pine.LNX.4.44.0312301833520.24097-100000@gate.nmr.mgh.harvard.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312301833520.24097-100000@gate.nmr.mgh.harvard.edu>
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
> Maybe not, but it could be done through autofs. There would probably be
> alot more resistance to getting mount's API changed for support of separate
> timeout value just for the mount side of things.
> 
> The master automount process could just kill the automount subprocess
> spawned to do a mount if it doesn't complete in X number of seconds.
> 

People constantly ask for various kinds of NFS support crap in autofs, 
and it's *ALWAYS* wrong.  There is really no excuse for a feature 
working from within autofs and not when mounted normally.

None.

> 
>>>I am often getting automount processes that are hung and don't die
>>>with a simple kill.  I can "kill -9" them but that leaves things in 
>>>a bad state usually (though sometimes I will just hand edit /etc/mtab
>>>so I can get something done).
>>
>>That's why they don't die with a simple kill.
> 
> Which is a pain.  Just because some remote server went down I had 
> automounted should not force me into a reboot of the client.
> 

OK... clue call... *AUTOFS ISN'T INVOLVED.*  Autofs *CANNOT* help you 
when an in-use filesystem has its server removed from underneath it. 
All autofs does is mount and unmount filesystems... it's not involved in 
any shape, way or form with the running thereof.  All autofs can see is 
that the filesystem is still in use, and there is nothing it can do 
about it.

If this sort of things happen to you often you may want to consider soft 
mounts.  Of course, you take the risk of data loss, but that is the only 
possible choice -- if the server cannot be accessed, the only options 
are to wait (hard mount) or return failure and throw the data away (soft 
mount.)

	-hpa
