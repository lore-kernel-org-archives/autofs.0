From: devnull@adc.idt.com
Subject: autofs and 2.6.x
Date: Thu, 6 May 2004 11:53:08 -0400 (EDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0405061146430.1165-100000@who.adc.idt.com>
Reply-To: devnull@adc.idt.com
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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
To: AutoFS on Linux Kernel <autofs@linux.kernel.org>

Has anyone gotten autofs-4.1.x ghosting to work on 2.6.x on x86_64 ?

I have FC1 running on a dual opteron machine and have patched
2.6.4 with

http://www.kernel.org/pub/linux/kernel/people/raven/autofs4-2.6/2.6.4/

all 8 files.

automount works, but ghosting doesnt. I have added --ghost to the startup 
script. 2.4.26 seems to work, but i need to use 2.6.4

Any help is much appreciated. 

Thanks

-- 
/dev/null

devnull@adc.idt.com
