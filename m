From: devnull@adc.idt.com
Subject: Re: unacceptable bug in autofs kernel module
Date: Mon, 21 Mar 2005 15:54:52 -0500 (EST)
Message-ID: <Pine.LNX.4.61.0503211425190.29378@pod.adc.idt.com>
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

> the problems on?  Direct map with/without ghosting?   Program map?  yp?
> ldap? etc..
Program Map, yp with ghosting.

I haven't bothered to turn ghosting off to see if that will help any. I 
need ghosting in any case.

The issue I am seeing is rather simple, easy to reproduce and happens 
every time.

Automount -V yields 4.1.2

4.1.4_beta2 has the problem too.

The job being run via "lsf" really has nothing to do with the problem, I 
can run the job locally on the machine and reproduce it.

The application I run creates a directory to store certain results, and to 
make sure that I am not looking at older results, my script deletes that 
directory at the very beginning of the job.

Somehow this causes a problem, the directory is always reported 
missing, however if i remove the directory by hand, then run the script, 
everything works great.

Where would I need to look to see what process is caching the contents of 
the directory.

Thanks.
