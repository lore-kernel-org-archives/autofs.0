From: devnull@adc.idt.com
Subject: Re: autofs and 2.6.x
Date: Mon, 10 May 2004 09:49:02 -0400 (EDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0405100948310.23174-100000@who.adc.idt.com>
References: <Pine.LNX.4.58.0405100936500.14861@wombat.indigo.net.au>
Reply-To: devnull@adc.idt.com
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405100936500.14861@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: AutoFS on Linux Kernel <autofs@linux.kernel.org>

> Had a look at this. This is due to the ioctl 32 bit emulation layer not 
> being told yet about the added ioctls in the latest autofs4.
> 
> This is also true on 2.4 and 64 bit archs.
> 
> If I make a patch can you test it for me on your arch. I can only test on 
Most definitely. 

Thanks for your help!!
