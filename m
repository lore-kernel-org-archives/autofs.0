From: Ian Kent <raven@themaw.net>
Subject: Re: autofs and 2.6.x
Date: Fri, 7 May 2004 09:54:02 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405070951550.6274@wombat.indigo.net.au>
References: <Pine.LNX.4.44.0405061146430.1165-100000@who.adc.idt.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0405061146430.1165-100000@who.adc.idt.com>
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
To: devnull@adc.idt.com
Cc: AutoFS on Linux Kernel <autofs@linux.kernel.org>

On Thu, 6 May 2004 devnull@adc.idt.com wrote:

> Has anyone gotten autofs-4.1.x ghosting to work on 2.6.x on x86_64 ?
> 
> I have FC1 running on a dual opteron machine and have patched
> 2.6.4 with
> 
> http://www.kernel.org/pub/linux/kernel/people/raven/autofs4-2.6/2.6.4/
> 
> all 8 files.
> 
> automount works, but ghosting doesnt. I have added --ghost to the startup 
> script. 2.4.26 seems to work, but i need to use 2.6.4
> 
> Any help is much appreciated. 

I don't have a 64 bit x86 machine but presumably an Ultra sparc would give 
similar results. I will try that when I get time.

Ian
