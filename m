From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs and 2.6.x
Date: Tue, 11 May 2004 16:19:51 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16545.13671.458946.559520@segfault.boston.redhat.com>
References: <Pine.LNX.4.44.0405061146430.1165-100000@who.adc.idt.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"
To: devnull@adc.idt.com
Cc: AutoFS on Linux Kernel <autofs@linux.kernel.org>

==> Regarding [autofs] autofs and 2.6.x; devnull@adc.idt.com adds:

devnull> Has anyone gotten autofs-4.1.x ghosting to work on 2.6.x on x86_64
devnull> ?  I have FC1 running on a dual opteron machine and have patched
devnull> 2.6.4 with

devnull http://www.kernel.org/pub/linux/kernel/people/raven/autofs4-2.6/2.6.4/

devnull> all 8 files.

devnull> automount works, but ghosting doesnt. I have added --ghost to the
devnull> startup script. 2.4.26 seems to work, but i need to use 2.6.4

devnull> Any help is much appreciated.

I just installed autofs4 on a dual x86_64, and ghosting works just fine.
Could you be a bit more specific about your configuration?  You said you
added --ghost to the startup script.  Where in the script?  $daemonoptions?
Would it be okay to post your config files?

Note, I'm using FC2 with Ian's patches, and autofs-4.1.2-6 from my people
page.

Thanks!

Jeff
