From: Ian Kent <raven@themaw.net>
Subject: Re: automounted symlink to automount	sometimesfails,
	doingDNS query of partial path
Date: Sat, 03 Feb 2007 10:46:38 +0900
Message-ID: <1170467198.28994.27.camel@raven.themaw.net>
References: <CECD6E8A589E8447BC6E836C8369AFF50C4BB949@us-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <CECD6E8A589E8447BC6E836C8369AFF50C4BB949@us-email.terastack.bluearc.com>
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
To: Martin Dorey <mdorey@bluearc.com>
Cc: autofs@linux.kernel.org

On Fri, 2007-02-02 at 08:25 -0800, Martin Dorey wrote:
> > I just wanted to know if typing mount<ret> showed a mount present
> on 
> 
> > /net/us-titan.us.dev.bluearc.com/ARCHIVE
> 
>  
> 
> I found the output from cat /proc/mounts while "wide" (the machine
> with the older kernel) had the problem.  It alleges three mounts from
> that server while the problem was happening:

This may not be related to your problem but Jeff Moyer and I are working
on a resolving a race between mount and expire involving symlinks right
now.

I have seen this "upercasing" before but that was an NFS problem related
in some way to a failed NFS lookup, so perhaps you could wait till we
have a patch and then test again.

> 
>  
> 
> us-titan.us.dev.bluearc.com:/CALLHOME /net/us-titan.us.dev.bluearc.com/CALLHOME nfs rw,nosuid,nodev,v3,rsize=32768,wsize=32768,hard,intr,lock,proto=tcp,addr=us-
> 
> titan.us.dev.bluearc.com 0 0
> 
> us-titan.us.dev.bluearc.com:/ARCHIVE /net/us-titan.us.dev.bluearc.com/ARCHIVE nfs rw,nosuid,nodev,v3,rsize=32768,wsize=32768,hard,intr,lock,proto=tcp,addr=us-ti
> 
> tan.us.dev.bluearc.com 0 0
> 
> us-titan.us.dev.bluearc.com:/Install /net/us-titan.us.dev.bluearc.com/Install nfs rw,nosuid,nodev,v3,rsize=32768,wsize=32768,hard,intr,lock,proto=tcp,addr=us-ti
> 
> tan.us.dev.bluearc.com 0 0
> 
>  
> 
> ("Install" is the right case but "CALLHOME" and "ARCHIVE" should both
> be all lower-case.)
> 
>  
> 
> That matches my recollection of the symptom of duezer, though I'm
> having a hard time proving it from the console logs.
> 
> -------------------------------------
> 
> Martin's Outlook, BlueArc Engineering
> 
>  
> 
> 
