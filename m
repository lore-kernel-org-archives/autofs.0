From: raven@themaw.net
Subject: Re: autofs default behavior on syminks?
Date: Sun, 11 Apr 2004 14:14:17 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404111359050.25415@donald.themaw.net>
References: <Sea2-F21JTYxUARaYlF0005b05e@hotmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Sea2-F21JTYxUARaYlF0005b05e@hotmail.com>
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

On Sat, 10 Apr 2004, idiot)_) supreme wrote:

> Hi all
> 
> We are running autofs4.1.0 with 2.4.22 on about 100 machines, and 2.6.5 on 
> about 100 machines with all of the the kernel patches for both.

Cool. I'm keen to hear how things go. Especially with 2.6.
A note to the list from time to time would be appreciated.

> 
> 
> What is autofs's behavior trying to cross symlinks when you type 'ls'?  
> autofs seems to time out a lot faster than AMD for example.
> 
> We are occasionally seeing problems timeouts trying to cross symlinks.  If I 
> type 'ls' it might show
> 
> abc -> /net/emc/u11
> 
> as a broken symlink
> 
> but if I type 'ls /net/emc/u11'
> the symlink comes back.
> 

In this case autofs doesn't do anything special with symlinks.
The colour ls does the 'stat'ing and the results are shown.

This does sound like an autofs bug or lilitation perhaps.
Indeed 'stat'ing the mountpoint itself should not mount it, otherwise we 
would get undesired mounts, so autofs lies and gives the stat of 
the autofs directory instead of the mounted. Actually autofs just doesn't 
do anything.

It's interesting that the symlink shows broken occasionally and not all 
the time. There must be a bad return coming back for some reason. So 
how occasionally?

Perhaps the 'stat' occurs during an expire sometimes. That could cause a 
fail return.

Ian
