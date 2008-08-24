From: Ian Kent <raven@themaw.net>
Subject: Re: something changed from 4 to 5
Date: Sun, 24 Aug 2008 12:32:37 +0800
Message-ID: <48B0E465.80701@themaw.net>
References: <alpine.LRH.1.10.0808120940350.4317@q7.q7.com>	<1218596289.3148.8.camel@raven.themaw.net>
	<alpine.LRH.1.10.0808230743560.25167@q7.q7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LRH.1.10.0808230743560.25167@q7.q7.com>
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
To: Joe Pruett <joey@clean.q7.com>
Cc: autofs@linux.kernel.org

Joe Pruett wrote:
> i had one of my servers get into the mode where automount is hung up doing 
> something.  i started attaching to each one and doing the gdb stack trace 
> you asked for.  here are the results.  after looking at the third one, 
> things cleared up.  hopefully we can figure something out on this.
>
> Script started on Fri 22 Aug 2008 01:11:35 PM PDT
> [root@titan ~]# ps axf | grep auto
>   1741 ?        Ssl  116:45 automount
> 16772 ?        S      0:00  \_ automount
> 16777 ?        S      0:00  \_ automount
> 20963 ?        S      0:00  \_ automount
> 21865 ?        S      0:00  \_ automount
> 23136 ?        S      0:00  \_ automount
> 25322 pts/0    S+     0:00                  \_ grep auto
> [root@titan ~]# gdb -p 1741 /usr/sbin/automount
>   
snip ..

> 0x002ba402 in __kernel_vsyscall ()
> (gdb) thr a a bt
>   

Took me a while to work out what you had done here.
To get the backtrace you need only connect to the main thread (in this 
case 1741) and do the "thr a a bt".
That gives backtrace info for all the sub-threads at once, which is what 
we need.

Ian
