From: devnull@adc.idt.com
Subject: Re: autofs and 2.6.x
Date: Tue, 11 May 2004 17:02:27 -0400 (EDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0405111654280.7668-100000@who.adc.idt.com>
References: <16545.13671.458946.559520@segfault.boston.redhat.com>
Reply-To: devnull@adc.idt.com
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16545.13671.458946.559520@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: AutoFS on Linux Kernel <autofs@linux.kernel.org>

Apologies for not sending this out earlier. 

autofs4 + ghosting + FC1 WORKS on X86_64

I recompiled the kernel again this morning and everything works fine. 

I do get a few warnings about 
nfs warning: mount version older than kernel

I am using FC1 (mount-2.11y)

Thanks, 

BTW: Is FC2 for x86_64 out ?

> I just installed autofs4 on a dual x86_64, and ghosting works just fine.
> Could you be a bit more specific about your configuration?  You said you
> added --ghost to the startup script.  Where in the script?  $daemonoptions?
> Would it be okay to post your config files?
> 
> Note, I'm using FC2 with Ian's patches, and autofs-4.1.2-6 from my people
> page.
> 
> Thanks!
> 
> Jeff
> 

-- 
/dev/null

devnull@adc.idt.com
