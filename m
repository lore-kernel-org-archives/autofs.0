From: Chris Quenelle <chris.quenelle@oracle.com>
Subject: Re: two /net paths to the same local mount?
Date: Fri, 23 Jul 2010 14:22:34 -0700
Message-ID: <4C4A081A.1000301@oracle.com>
References: <4C1FBABF.5060207@oracle.com>	
	<35D166B0274C8DB77A6BE435@[192.168.1.100]>
	<4C225338.8070008@oracle.com>	 <1277348429.2841.44.camel@localhost>
	<4C2A1C03.1070908@oracle.com>	 <1277903577.2819.8.camel@localhost>
	<4C2B5B4E.3010501@oracle.com>	 <1277950748.3137.2.camel@localhost>
	<4C33CA03.2020904@oracle.com>	 <1278476554.5423.9.camel@localhost>
	<4C379CD7.4070404@oracle.com>	 <1278903227.2930.18.camel@localhost>
	<4C3F6AA1.2040409@oracle.com>	
	<1279265282.2968.37.camel@localhost> <4C47428A.809@oracle.com>
	<1279770319.2986.26.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1279770319.2986.26.camel@localhost>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, Frank Thommen <frank.thommen@embl.de>

Ian Kent wrote:
> On Wed, 2010-07-21 at 11:55 -0700, Chris Quenelle wrote:
>> Ian Kent wrote:
>>> On Thu, 2010-07-15 at 13:08 -0700, Chris Quenelle wrote:
>>>> I went through this thread and collected all the information
>>>> in a problem description.  I also included sysrq dump
>>>> output before and during the problem.  It's 300k.  I can
>>>> send it to the list in email if you prefer.  For now
>>>> it's available here:
>>>>
>>>> http://quenelle.org/unix/wp-content/uploads/2010/07/linux-log.txt
>>> This doesn't look like a deadlock in the kernel.
>>>
>>> We still need a full debug log, which would have been useful to relate
>>> to the srsrq-t dump.
>> There is no debug output when I access the problematic path.
>> I verified that I'm actually getting all the debug output
>> by accessing an unmounted /net location on another host.
>> This surprised me.
> 
> I understand that may be the case but a full debug log is usually the
> staring point for automount debugging. A full debug log means, a debug
> log from the start of running automount (with the syslog facility
> daemon.* being recorded) until the problem occurs, with autofs in a
> clean state at the start. Most people don't get the "in a clean state at
> the start" so don't worry too much about that, but if we can't see
> anything in the log then I start talking about the state of autofs when
> it was started and move on from there.
> 
> The whole point is that, often times a problem is seen that happened
> quite some time before, and sometimes there are messages in the log that
> help focus efforts, which leads to a solution.
> 
> But even more importantly, with such an old version, we might have seen
> the problem before and the problem signature in the log might just "turn
> on that light". Of course, we may have something different or a previous
> problem with slightly different symptoms.
> 
> This is so important I'll say it again, a full debug log is pretty much
> always the starting point in trying to resolve autofs problems.

Point taken about the importance of the full debug log.
If the problem turns out to be reproducible after rebooting
the machine (which I haven't done yet) then I'll post a debug
log from the time of boot up until the problem happens.


> 
>> I'm not really in a position to get debug symbols right now.
> 
> That's a bummer.
> 
>> You've done two important things for me so far.
>>
>> 1. You've showed me there is a place I can get help with my
>> autofs problems.
> 
> Sure. But your distribution autofs maintainer should be able to go
> through the debugging exercise with you and bring his view to the list.
> That is actually important because the maintainer should be keeping an
> eye on what is happening and what new patches are appearing on
> kernel.org and be aware of the patches they have applied in their
> distribution version. This last point is the most important as I have no
> idea what the SuSE folks have applied to the package and I really
> shouldn't have to go through the exercise of finding out, although I
> have done so from time to time.


Okay.

> 
> Oh ... I can't resist ... a shameless plug.
> 
> If your a heavy autofs user the best distribution to use is RedHat
> Enterpise Linux because I am up with what is happening with autofs
> (obviously).

If I have an RHEL system and I want to set it up to automatically
pull down the latest patches, is there a web page describing how
I can do that?  Or the same for SUSE for that matter?
I realize this isn't an automount-specific question.  I'm using
an ocean of poorly updated lab machines with different distros
and versions of Linux.  Any tips for keeping some or all
of them updated with official patches would be great.  Like I said,
I know it's off-topic, but pointers to RTFM would make my life much
easier.



>   
>> 2. You've helped me come up to speed on Linux/automount debugging
>> so that I can do an initial evaluation for any future problems
>> I run into.
> 
> I'm sure you will pick up a bit more too as time passes.
> 
>> These things are very useful to me, even if I didn't get to
>> root of my problem.  When I get more time I will look for
>> debug symbol packages for SUSE, and/or I'll try building
>> automount from source with debugging enabled.
> 
> Yes, it is a bit hard, since a lot has happened since 5.2.
> 
>> --chris
>>
>>
>>
>>
>>> You might be seeing a thread create synchronization problem. I've fixed
>>> some problems in that area since 5.0.2 (but then we don't know what
>>> patches the SuSE folks have applied). Information about that possibility
>>> can be obtained by getting a gdb backtrace of the main automount
>>> process. This isn't much use unless debug symbols are available. In
>>> Fedora we have debuginfo packages that correspond to each package. They
>>> can be installed along with the package so that gdb has access to the
>>> program symbols.
>>>
>>> In any case once the debug symbols are available you can use:
>>>
>>> gdb -p <automount pid> /usr/sbin/automount
>>> gdb> thr a a bt
>>>
>>> (assuming automount is actuall in /usr/sbin) and capture the output of
>>> this so we can see what the automount threads are doing, or not doing,
>>> as the case may be.
>>>  
>>>> Again, I want to thank you guys for your time.  I've learned a lot.
>>>>
>>>> From the dump output I can see that there is one additional
>>>> "automount" thread when the problem is happening.  I think
>>>> the new one has the number 5603.  But that number seems to be
>>>> in the "father" column, not the "pid" column.  I'm not sure
>>>> what that means.
>>>>
>>>> automount     S 0000555555686e00     0  5603      1                4054 (NOTLB)
>>>> ffff810366a07e88 0000000000000086 0000000005f5e100 000000000000000a
>>>>        ffff810417dc62d8 ffff810417dc6080 ffff810001033700 001082fb301a703a
>>>>        0000000000000653 0000000001037030
>>>> Call Trace: <ffffffff8014a06b>{enqueue_hrtimer+90} <ffffffff802ea159>{schedule_hrtimer+41}
>>>>        <ffffffff8014a5af>{hrtimer_nanosleep+130} <ffffffff8014a6a5>{sys_nanosleep+76}
>>>>        <ffffffff8010ae42>{system_call+126}
>>>>
>>>> Anyway, the full dumps are included in the log I pointed at above.
>>>>
>>>> --chris
>>>>
>>>>
>>>>
>>>> Ian Kent wrote:
>>>>> On Fri, 2010-07-09 at 15:04 -0700, Chris Quenelle wrote:
>>>>>> Ian Kent wrote:
>>>>>>
>>>>>>> strace output is often not very useful.
>>>>>>>
>>>>>>> If you think there is some sort of deadlock going on get a sysreq-t dump
>>>>>>> to syslog. We still haven't seen a debug log?
>>>>>> I've had reports that my emails are being delayed when they go out to the list.
>>>>>> If anyone is following along and you'd like me to add you to my cc:
>>>>>> lines so you get the email directly, let me know, and I'll do that.
>>>>> That's going to happen if you post to a subscribers only list without
>>>>> subscribing to it.
>>>>>
>>>>>> I'm getting close to my limits of what this problem is worth to me.
>>>>> And yet you haven't really provided the information requested?
>>>>>
>>>>> I don't remember but did we get the distribution and autofs version your
>>>>> using?
>>>>>
>>>>>> I suspect the two broken paths will get unwedged if I reboot the system.
>>>>>> But I'd love to know how to prevent it from happening again.
>>>>>>
>>>>>> I saw these lines in /var/log/messages:
>>>>>>
>>>>>>>>>>> Jun 29 09:04:46 carabas automount[11786]: Debug logging set for /net
>>>>>>>>>>> Jun 29 09:09:22 carabas automount[11786]: get_pkt: message pending on control fifo.
>>>>>>>>>>> Jun 29 09:09:22 carabas automount[11786]: Basic logging set for /net
>>>>>> Does that mean that all debugging output from automount should be
>>>>>> going to that file?  Or could the debug output still be going someplace
>>>>>> else (or into /dev/null?) In between the first line of that log output and
>>>>>> the last line, I provoked a correctly functioning automount of
>>>>>> a local file system, and I also tried to access the "broken" path
>>>>>> to the local filesystem.
>>>>> What file, I don't understand what you mean?
>>>>>
>>>>> But you don't mention what you have done to tell syslog to actually send
>>>>> "all" facility daemon messages to the syslog.
>>>>>
>>>>> Try having a look at Jeffs page http://people.redhat.com/jmoyer for a
>>>>> description debug logging setup.
>>>>>
>>>>>> So that in combination with strace/automount not giving any output
>>>>>> when I access the broken path, makes me think the control path
>>>>>> is not getting out of the kernel.
>>>>> Maybe.
>>>>>
>>>>>> Can you point me to an explanation of what a "sysreq-t dump" is and
>>>>>> how to get it?  I don't have access to the console of this machine,
>>>>>> hopefully it's something I can do from a root term window.
>>>>> Wherever your distribution's has kernel documentation (or a package that
>>>>> contains the documentation) look at Documentation/sysrq.txt.
>>>>>
>>>>> Often, you will find you can:
>>>>>
>>>>> echo "t" > /proc/sysrq-trigger
>>>>>
>>>>> to get a trace dump, which is what I'm asking for.
>>>>>
>>>>>> To summarize my problem, I have a test set of paths to access a local
>>>>>> filesystem, 7 work and 2 don't.
>>>>>>
>>>>>> /net/carabas/export/home1
>>>>>> /net/carabas/export/home2    <-- fails
>>>>>> /net/carabas/export/home3    <-- fails
>>>>>> /net/carabas.sfbay/export/home1
>>>>>> /net/carabas.sfbay/export/home2
>>>>>> /net/carabas.sfbay/export/home3
>>>>>> /net/carabas.sfbay.sun.com/export/home1
>>>>>> /net/carabas.sfbay.sun.com/export/home2
>>>>>> /net/carabas.sfbay.sun.com/export/home3
>>>>>>
>>>>>>
>>>>>> I don't see anythign suspicious in the output of:
>>>>>> showmount
>>>>>> df
>>>>>> /etc/host.conf
>>>>>> strace automount
>>>>>> automount -l debug /net
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> --chris
>>>
> 
> 
