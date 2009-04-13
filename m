From: Ian Kent <raven@themaw.net>
Subject: Re: Automounter stops after reload signal.
Date: Mon, 13 Apr 2009 17:01:42 +0800
Message-ID: <49E2FF76.2080108@themaw.net>
References: <49DCCD73.5050307@bononline.nl>
	<1239545315.23791.0.camel@zeus.themaw.net>
	<49E22C1D.8030504@bononline.nl> <49E2D284.1040801@themaw.net>
	<49E2F90A.9010901@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49E2F90A.9010901@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org

Stef Bon wrote:
> Ian Kent wrote:
>> Stef Bon wrote:
>>  
>>> Ian Kent wrote:
>>>    
>>>> On Wed, 2009-04-08 at 18:14 +0200, Stef Bon wrote:
>>>>  
>>>>      
>>>>> Hello,
>>>>>
>>>>> I've been working on a construction which adds an autofs managed
>>>>> mountpoint to the homedirectory, when:
>>>>> a. an usb device or more than one is detected when logging in
>>>>> b. an usb device is plugged in during a session
>>>>>             
>>>> What version of autofs did you say you are using?
>>>>         
>>> Well, 5.0.4.
>>>     
>>
>> OK, then the daemon should remain running as long as there is at least
>> one entry in the master map. If the daemon receives a HUP signal then
>> any mount handling threads that terminate will send SIGTERM to the
>> signal catching thread. If the master map becomes empty during this
>> SIGTERM check autofs will exit. That is what the daemon exit condition
>> is and we do need such a condition to be able to exit at all.
>>
>> If something else is happening in your case then we need to work out
>> what's going on.
>>   
> 
> Yes, the auto.master file is not empty. In all of my cases, and in the
> example below, the auto.master file has one line which is there always:
> 
> /mnt/sd /etc/autofs/auto.sd --timeout=50
> 
> 
> I remember that I have added this line to prevent this unwanted
> behaviour. In my construction it can happen that when no users are
> logged in (after logout), there are no mountpoints, and then the
> automounter did stop also. So then I added this line, and the behaviour
> disappeared. Now it's back again. Removing a mountpoint, and reloading
> gives this behaviour, even if there are other mountpoints and maps in
> the auto.master file.
> 
> Ok, so this should be a bug, if you say that, when the auto.master file
> is empty, the automounter should stop after a HUP signal.
> Apart from this bug, I do not understand this. You say it's necessary to
> exit at all, but is this a technical reason? The master daemon should
> not stop after a reload signal, even if the master file is empty.

OK, looks like a bug.
I'll look further, using your example.

What I'm saying is that, in order to exit there must be such a condition
and that it isn't as straight forward as just saying the daemon
shouldn't exit after receiving a HUP signal even if the master map is
empty. The issue of continuing to run or not has come up a number of
times and it is tricky. At the very least an empty master map is likely
to continue to be the exit condition.

> 
> Stef Bon
>> However, there are a couple of patches against 5.0.4 in this area of the
>> code, but I'm not sure they make the above behaviour different. We could
>> give then a try.
>>
>>  
>>> I can imagine that my story is complicated, so I've found a simple way
>>> to get the same behaviour.
>>>
>>> Add the following line to the auto.master file in /etc/autofs:
>>>
>>> /mnt/smb   /etc/autofs/auto.smb
>>>
>>> Start the daemon, or, if already running, do a reload.
>>>
>>> Play with the new mountpoint, so do something like :
>>>
>>> ls /mnt/smb/<valid name of smb host>
>>>
>>> look at the result, a tree should be the result.
>>>
>>> Now remove the line again, (thus: "/mnt/smb /etc/a...."), and give the
>>> daemon a reload again,
>>>
>>> and the daemon stops.
>>>     
>>
>> As it should if there are no master map entries remaining.
>> I've been here before and I think trying to change the exit condition
>> will be quite hard.
>>
>>  
>>> I've got a 2.6.27.9 kernel, patched with
>>>
>>> autofs4-2.6.27-dev-ioctl-20081029.patch and
>>> autofs4-2.6.27-v5-update-20081027.patch
>>>
>>> Stef Bon
>>>
>>>     
>>
>>   
> 
