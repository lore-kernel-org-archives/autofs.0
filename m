From: Ian Kent <raven@themaw.net>
Subject: Re: unacceptable bug in autofs kernel module
Date: Thu, 30 Dec 2004 13:42:24 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0412301329510.2783@wombat.indigo.net.au>
References: <41D1106C.9070706@intraperson.com>
	<Pine.LNX.4.58.0412290843030.31988@wombat.indigo.net.au>
	<41D21C1E.8040407@intraperson.com>
	<Pine.LNX.4.58.0412291418160.8463@wombat.indigo.net.au>
	<41D28271.601@intraperson.com>
	<Pine.LNX.4.58.0412300842040.29368@wombat.indigo.net.au>
	<41D370E7.9080409@intraperson.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <41D370E7.9080409@intraperson.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ramana <ramana@intraperson.com>
Cc: autofs@linux.kernel.org

On Thu, 30 Dec 2004, ramana wrote:

> Ian Kent wrote:
> 
> >On Wed, 29 Dec 2004, ramana wrote:
> >
> >  
> >
> >>autofs 3 with Fdora core 1 but I suspect even autofs4 also will behave 
> >>similarly as code does not look different with ENOENT replies.
> >>    
> >>
> >
> >autofs 3 is not being developed any more.
> >
> >If you are testing you should use the latest autofs4. This can be done by 
> >using 2.6.10 or applying the appropriate patch.
> >
> >If want to try this out let me know and I will post the latest patches I 
> >have to kernel.org now. 
> >
> >Ian
> >
> >
> >  
> >
> I would like to test it using latest patches rather then going for 
> 2.6.10 as not everyone migrate to 2.6 right now.

I need to do a couple more small things so I'll get them done and upload 
the patches asap.

What kernel version will you use?

> 
> I know autofs 3 module not maintained anymore but I would like to 
> clarify one issue here. It is autofs3 module not maintained or autofs3 
> protocol. It is becuase autofs4 module supports autofs3 protocol as far 
> as my understanding.

I've tried to maintain compatability.

It's been a long time since I tested this at length and many changes have 
been made since without this compatibility testing.

So, yes autofs4 should be backward compatible and no I can't confirm how 
good or not it is now.

Ian
