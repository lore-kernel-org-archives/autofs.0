From: mmarion@qualcomm.com
Subject: Re: Autofs 4.1.4_beta2 + NetApp Filer + missing dir
Date: Fri, 4 Mar 2005 17:07:14 -0800 (PST)
Message-ID: <200503050107.j2517EGK021770@cornholio.qualcomm.com>
References: <Pine.LNX.4.61.0503011049350.25092@pod.adc.idt.com>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.61.0503011049350.25092@pod.adc.idt.com>
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
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On  1 Mar, devnull@adc.idt.com wrote:

> This is an extension to the "unacceptable bug in autofs kernel module" 
> sent by mmarion at qualcomm

I didn't send that.. someone else did, but I did comment that I thought we
were seeing the same thing.  I try to be more subtle when talking about a 
bug.. especially when I know I can't code well enough to fix it. :)

> /usr/sbin/automount -V
> Linux automount version 4.1.4_beta2
> (4.1.2 didnt work either)
> 
> We are submitting jobs to machines via LSF, the data being stored on 
> NetApp filers, running OnTap 6.5.2

Hmm.. read that you're still seeing the issue, are you using direct map or
program map to mount?  Ghosting?  Our project data is all on netapp filers 
as well, not sure on the ontap version.

I just brought up 2 hosts (1 i386 suse-9.2 and 1 amd64 sles9, both kernel 
2.6.5-7.147-smp which has the latest autofs4/ghosting patches already) and
installed 4.1.4_beta2.  I'm now doing direct mounts with ghosting.. and it
appears to be working like a charm.. interactively at least.

Next I want to push into our LSF farm and have users hit it with jobs to see
if the direct map vs program map and/or ghosting help with the jobs that say
"file not found" when it's clearly there.  

That problem almost seems like the programs expect the mount to be atomic, and
error out before automount has a time to do it's mount.. even though it's
sub-second in it's action.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
"One of the best ways to get yourself a reputation as a dangerous
 citizen these days is to go about repeating the very phrases which
 our founding fathers used in the great struggle for independence."
                            -- Charles Austin Beard (1874-1948)
