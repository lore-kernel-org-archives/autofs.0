From: Ian Kent <raven@themaw.net>
Subject: Re: something changed from 4 to 5
Date: Sun, 24 Aug 2008 13:11:55 +0800
Message-ID: <48B0ED9B.5080103@themaw.net>
References: <alpine.LRH.1.10.0808120940350.4317@q7.q7.com>
	<1218596289.3148.8.camel@raven.themaw.net>
	<alpine.LRH.1.10.0808230743560.25167@q7.q7.com>
	<48B0E465.80701@themaw.net>
	<alpine.LRH.1.10.0808232150000.7557@q7.q7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LRH.1.10.0808232150000.7557@q7.q7.com>
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
To: Joe Pruett <joey@clean.q7.com>
Cc: autofs@linux.kernel.org

Joe Pruett wrote:
>> Took me a while to work out what you had done here.
>> To get the backtrace you need only connect to the main thread (in 
>> this case 1741) and do the "thr a a bt".
>> That gives backtrace info for all the sub-threads at once, which is 
>> what we need.
>
> this is a centos 5 box so the other pids from ps are standalone 
> processes (look at the lwp list from the first gdb to see that they 
> aren't the same).
>
> the first gdb should have been the data you want. by connecting to the 
> other pids, it eventually unblocks whatever is stuck and then the 
> world starts working again. oddly, it seems to be a call to access 
> that is hung. in the past i've just used strace and could never tell 
> what was stuck.

And the call to access(2) is seen in the first backtrace as waiting on 
an nfs mount and any other processes calling to access(2) should wait on 
the first in this case, since the path includes the same mount.

When this happens you could also try looking for mount processes to 
match them to those in the backtraces but if any have died that should 
result in the daemon continuing. So it's a bit puzzling.

Ian
