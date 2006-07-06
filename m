From: =?utf-8?B?5aec5Zu95Lyf?= <jianggw@bsw.net.cn>
Subject: Re: about mainboard driver
Date: Thu, 6 Jul 2006 13:28:45 +0800
Message-ID: <018f01c6a0bd$0cfc1cf0$4d74a8c0@jiangguowei2>
References: <04cd01c69fe2$d2044bc0$4d74a8c0@jiangguowei2>
	<Pine.LNX.4.64.0607051137470.24272@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org

Thank you for your reply,Jim.

> Suggestion, in the messages printed by the kernel during booting, look at 
> the message for the behavior you're doing research on, and use recursive 
> "grep" in the kernel sources to find files containing a word or phrase in 
> that message.  I was going to do that for you, for some representative 
> subsystems, but I'm on my work machine which doesn't have the sources 
> installed.  
>
You can get kernel source codes in http://www.kernel.org/pub/linux/kernel/v2.6/ .


> I don't think Linux has a specific "mainboard driver" like Windows does; 

But I found many in http://www.treiberupdate.de/treiber-download/treiber-Mainboard/Motherboard-linux-0.html 
> hardware initialization is done with the subsystems (e.g. memory 
> management) to which it's relevant, and where necessary the actions are 
> conditional on the chipset, with both run-time tests and the possibility to 
> exclude a whole class of processors/chipsets at compile time.
> 
> For autofs the kernel's generic filesystem code cooperates with a userspace 
> daemon, and this is all happening at a hardware independent level.
> 
> James F. Carter          Voice 310 825 2897    FAX 310 206 6673
> UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
> Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)


Regards,

Victor
