From: Ian Kent <raven@themaw.net>
Subject: Re: autofs and 2.6.x
Date: Tue, 11 May 2004 09:49:05 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405110941010.9132@wombat.indigo.net.au>
References: <Pine.LNX.4.44.0405101332190.27883-100000@who.adc.idt.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0405101332190.27883-100000@who.adc.idt.com>
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

On Mon, 10 May 2004 devnull@adc.idt.com wrote:

> > Use the patches for your kernel at 
> > http://www.kernel.org/pub/linux/kernel/people/raven
> > 
> > and add this patch for the ioctls. It applies with a small offset but 
> > achieves the desired result. This fixes the problem for me on sparc64 but 
> > I'm not sure avout x86_64. Let me know.
> 
> Doesnt seem to fix the problem. 
> 
> autofs seems to work fine, but ghosting doesnt. 
> 
> Is there anything else i can do on the machine to help debug the problem ?
> 

Yep.

What OS do you have?
Version?
Does your OS use 64-bit exes?
Evidence of that?

> I am applying all the patches(the ones from /people/raven and this one) to 
> the 2.6.4 tree.

So you had to rebuild your kernel and reboot so it must be using the 
update, right?
 
> 
> Should i be trying 2.6.6 instead ?

No need.

Ian
