From: Ian Kent <raven@themaw.net>
Subject: Re: autofs default behavior on syminks?
Date: Mon, 12 Apr 2004 11:36:15 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404121130360.4859@raven.themaw.net>
References: <Sea2-F17J09Z6e2iL550001e1f5@hotmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Sea2-F17J09Z6e2iL550001e1f5@hotmail.com>
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
To: "idiot)_) supreme" <ejw50@hotmail.com>
Cc: autofs@linux.kernel.org

On Sun, 11 Apr 2004, idiot)_) supreme wrote:

> 
> For the most part, we only see this error on the 2.6.5 with 4.1.0 and all of the
> kernel patches.  We do not really see this on 2.4.22/4.1.0 and kernel patches.  When
> all of the machines are running, we see it about 2x an hour.  I have tried raising
> the timeouts to 1 hour (so they never umount once mounted) but I won't know if this
> "works" until next week.  Our previous timeouts were 5 minutes.   I have also
> recently tried raising retry, timeo, and other variables, but don't know if will
> work unti next week.  I have not tried 4.1.2 yet.
> 
> We see this error in /var/log/messages
> 
> Apr  9 22:16:00 e232 automount[17404]: >> mount: RPC: Remote system error -
> Connection timed out
> Apr  9 22:16:00 e232 automount[17404]: mount(nfs): nfs: mount failure
> emc1.bbn.com:/u11 on /net/emc/u11
> Apr  9 22:16:00 e232 automount[17404]: failed to mount /net/emc/u11
> 
> I can correspond these /var/log/messages logs to error logs in our job running
> system

If there is in fact a problem mounting then this is expected behviour.
In fact correct behaviour. autofs calls mount and that's about all. So the 
big question is "why is the mount failing"?

> 
>  
> 
> 29763 K    *username*  @ e232        5  e200        racks5n6  
> "13022-SCTM_X-tr-GI-1-2-05"
> 22:16:00: can't open task output
> /d4m/ears/expts/13009/logfiles/13009-SCTM_NX-tr-GI-1-1-6.log: No such file or
> directory
> 22:16:04: reap pid 17403, task 29843, exit 0
> 22:16:04: syncing with db
> 
> The file it can't open is really a link to /net/emc/u11 (which is the what automount
> reports a failure on)
> 
> This is why I asked about autofs link behavior.

Yes. This should work fine.

Maybe a question on the NFS list is in order as well.

Ian
