From: Ian Kent <raven@themaw.net>
Subject: Re: Re: unacceptable bug in autofs kernel module
Date: Tue, 22 Mar 2005 09:04:10 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0503220858230.4244@wombat.indigo.net.au>
References: <Pine.LNX.4.61.0503211425190.29378@pod.adc.idt.com>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.61.0503211425190.29378@pod.adc.idt.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devnull@adc.idt.com
Cc: AutoFS on Linux Kernel <autofs@linux.kernel.org>

On Mon, 21 Mar 2005 devnull@adc.idt.com wrote:

> > the problems on?  Direct map with/without ghosting?   Program map?  yp?
> > ldap? etc..
> Program Map, yp with ghosting.
> 
> I haven't bothered to turn ghosting off to see if that will help any. I 
> need ghosting in any case.
> 
> The issue I am seeing is rather simple, easy to reproduce and happens 
> every time.
> 
> Automount -V yields 4.1.2
> 
> 4.1.4_beta2 has the problem too.
> 
> The job being run via "lsf" really has nothing to do with the problem, I 
> can run the job locally on the machine and reproduce it.
> 
> The application I run creates a directory to store certain results, and to 
> make sure that I am not looking at older results, my script deletes that 
> directory at the very beginning of the job.

Interesting!

So this is not a directory in the autofs filesystem but one in the mounted 
filesystem?

> 
> Somehow this causes a problem, the directory is always reported 
> missing, however if i remove the directory by hand, then run the script, 
> everything works great.
> 
> Where would I need to look to see what process is caching the contents of 
> the directory.

An example first.
When you reproduce the problem give the map (master and entry maps).
The steps to reproduce.
The syslog output with the "--debug" option on the master map entry.

Ian
