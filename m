From: raven@themaw.net
Subject: Re: automount doesn't expire nested nfs mounts for certain
 kernel configs
Date: Mon, 10 May 2004 21:29:07 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405102123390.19425@donald.themaw.net>
References: <409E4AB5.6A3CCEB1@wm7d.net>
	<Pine.LNX.4.58.0405100913350.14283@wombat.indigo.net.au>
	<Pine.LNX.4.58.0405100504440.7687@www.wm7d.net>
	<Pine.LNX.4.58.0405102051180.19425@donald.themaw.net>
	<Pine.LNX.4.58.0405100605110.10734@www.wm7d.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405100605110.10734@www.wm7d.net>
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
To: Joseph Mack NA3T <jmack@wm7d.net>
Cc: autofs@linux.kernel.org

On Mon, 10 May 2004, Joseph Mack NA3T wrote:

> 
> > With autofs-4.1.2 add a -d to the master map line and send the log
> > fragment.
> 
> OK, not knowing where to add the -d, I'd put it in the autofs init.d
> script with daemonoptions and it seemed to work

That should work fine.

> 
> Let me set it up here and I'll post some logs (in another posting)
> 
> > What is in your master map then?
> 
> /nfs	/etc/auto.nfs.machine_name	-bg,intr,suid,nodev
> 
> > And the map your trying to load?
> 
> I sent a line with my first posting. It was

Saw that afterward.

I'll check this out but I've been working on this multi mount 
stuff recently and it seemed OK.

Do you have anything running that may be scanning the directories?

The compaq stuff has done this in the past or sometimes gnome destops have 
this problem.

You might like to apply the 4.1.2 patches at the same location you got the 
tar.

> 
> server	-fstype=nfs,soft	/ server:/ \
> 				/usr server:/usr \
> 				/src server:/src
> 
