From: devnull@adc.idt.com
Subject: Re: Re: unacceptable bug in autofs kernel module
Date: Thu, 24 Mar 2005 15:17:18 -0500 (EST)
Message-ID: <Pine.LNX.4.61.0503241506130.867@pod.adc.idt.com>
References: <Pine.LNX.4.61.0503211425190.29378@pod.adc.idt.com>
	<Pine.LNX.4.58.0503220858230.4244@wombat.indigo.net.au>
	<Pine.LNX.4.61.0503221500170.8797@pod.adc.idt.com>
	<Pine.LNX.4.58.0503231139130.8473@wombat.indigo.net.au>
Reply-To: devnull@adc.idt.com
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0503231139130.8473@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: AutoFS on Linux Kernel <autofs@linux.kernel.org>

>> # system("bsub -q normal -I mkdirhier run_details/me");
>> # You need to change MachineName to something else here.
>> system("rsh MachineName mkdirhier /home/me/run_details/me");
>
> What's happening here?
> Is this an "rsh" to another machine?

rsh to another machine. I was trying to give you something simlar to LSF i 
guess. If you have access to LSF, then that's great.

BTW, this happens with autofs 4.1.2 and 4.1.4


> Yes. There's not really enough info here.
> The debug severity info appears to be missing.

Let me see if I can fix that.


>
> I can't see any failed mount messages, is that usual?

Yes, usually no mount failure messages at all.
Just the "mount version older than kernel errors", which has more to do 
with the version of util-linux.(i think)


> I have found some problems in a couple of areas recently which I've been
> working on. One area is in thre replicated server code. Although
> I've previously claimed that mount entries without replcated server syntax
> aren't affected by this code that's completely wrong. atm it appears that
> if you have a busy network with variable round trip times that mounts
> can fail intermitently. I first found this when the wireless connection to
> my test machine at home was intermitently disconecting causing longish
> timeouts and hence mount failures.
>
> Would you be able to test out a patch?

Absolutely. BTW, all of this is on X86_64 (might be the same on i686 too)


> Is the rmtree of the File::Path perl module where the problem occures.
The problem occures near
opendir DIR, "run_details" or die "1. couldn't open run_details ($!)\n";

The problem is that when i create a sub dir on another machine(as would 
happen when a job is submitted to a something like LSF) and a process 
tries to read the content of that dir on the local machine, the local 
machine "read process" dies with a file not found.

If you run the perl script that i attached in my previous email, you will 
see the exact problem.

Thanks for your time and efforts.

/dev/null

devnull@adc.idt.com
