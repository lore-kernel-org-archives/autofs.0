From: Joe Pruett <joey@clean.q7.com>
Subject: Re: something changed from 4 to 5
Date: Sat, 23 Aug 2008 21:58:18 -0700 (PDT)
Message-ID: <alpine.LRH.1.10.0808232150000.7557@q7.q7.com>
References: <alpine.LRH.1.10.0808120940350.4317@q7.q7.com>
	<1218596289.3148.8.camel@raven.themaw.net>
	<alpine.LRH.1.10.0808230743560.25167@q7.q7.com>
	<48B0E465.80701@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48B0E465.80701@themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

> Took me a while to work out what you had done here.
> To get the backtrace you need only connect to the main thread (in this case 
> 1741) and do the "thr a a bt".
> That gives backtrace info for all the sub-threads at once, which is what we 
> need.

this is a centos 5 box so the other pids from ps are standalone processes 
(look at the lwp list from the first gdb to see that they aren't the 
same).

the first gdb should have been the data you want.  by connecting to the 
other pids, it eventually unblocks whatever is stuck and then the world 
starts working again. oddly, it seems to be a call to access that is hung. 
in the past i've just used strace and could never tell what was stuck.

just to refresh how i have things:

auto.master:
/disks	auto.disks
/home	auto.home

auto.disks:
hyperion.0	hyperion:/disk/0
jupiter.0	jupiter:/disk/0
mir.0		mir:/disk/0

auto.home: (examples)
joey		:/disks/jupiter.0/joey
admin		:/disks/mir.0/admin
shipper		:/disks/hyperion.0/shipper

so tickling /home/shipper should tickle /disks/hyperion.0 to create an nfs 
mount for hyperion:/disk/0 and then a bind mount to 
/disks/hyperion.0/shipper.

this works 99% of the time.  the machine that acts up the most is the 
least used (ssh and cron server), so my guess is that things in /disks 
actually get unmounted between times that are using /home.
