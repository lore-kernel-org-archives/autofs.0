From: devnull@adc.idt.com
Subject: Autofs 4.1.4_beta2 + NetApp Filer + missing dir
Date: Tue, 1 Mar 2005 14:06:32 -0500 (EST)
Message-ID: <Pine.LNX.4.61.0503011049350.25092@pod.adc.idt.com>
Reply-To: devnull@adc.idt.com
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: AutoFS on Linux Kernel <autofs@linux.kernel.org>

Hello All,

This is an extension to the "unacceptable bug in autofs kernel module" 
sent by mmarion at qualcomm

http://linux.kernel.org/pipermail/autofs/2005-February/001889.html

Our situation

/usr/sbin/automount -V
Linux automount version 4.1.4_beta2
(4.1.2 didnt work either)

We are submitting jobs to machines via LSF, the data being stored on 
NetApp filers, running OnTap 6.5.2

We run a perl script from

/home/user/workarea called test.pl

test.pl basically does


1. setup a bunch of stuff for our runs, including versions etc.

2. rmtree "DirectoryNeeded" (to make sure we remove cached data from older
    runs)

3. bsub the job, wait for completion(this job has now created a new copy 
of "DirectoryNeeded")

4. Once the bsub completes, we then try to do an "opendir" on
    "DirectoryNeeded" and it doesnt work. Just says not found.


To make the script work I can

1. Take out Step 2(the rmtree part), remove the dir manually and run the 
script and it works great.

2. Move the rmtree part as part of the bsub command submitted and it works 
fine.

3. Do a touch on "DirectoryNeeded" just before reading it and everything 
works.


Almost as if the contents of the dir are still in the
rmtree DirectoryNeeded state and hasnt been updated.

Ofcourse, all of this works on Solaris.

Many thanks,

Please let me know if you would like to see more information.

Thanks,
Ram.
