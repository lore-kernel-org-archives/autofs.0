From: Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: expire after kill -HUP ?
Date: Mon, 02 Dec 2013 10:12:24 +0100
Message-ID: <529C4EF8.5060305@molgen.mpg.de>
References: <5299B9CF.8030808@molgen.mpg.de>	 <7B07798B-AB21-4FD2-AE32-B280A8DAE045@themaw.net>	 <529B8F27.6040202@molgen.mpg.de> <1385945107.2507.1.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1385945107.2507.1.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

Yeah, the patch fixed it. Thank you!

   Donald


On 12/02/13 01:45, Ian Kent wrote:
> On Sun, 2013-12-01 at 20:33 +0100, Donald Buczek wrote:
>> Hello,
>>
>> sorry, I kept it short because I hoped, you might be able to reproduce
>> it easily.
>>
>> The output of http://owww.molgen.mpg.de/~buczek/autofs-demo/AAA_test.sh
>> is in http://owww.molgen.mpg.de/~buczek/autofs-demo/AAA_test.log.
>> Clearly the expiry stops after the first  HUP. Maps not changed. The two
>> config files are also in http://owww.molgen.mpg.de/~buczek/autofs-demo/.
> Maybe I don't see it because I'm running with this patch ....
> https://www.kernel.org/pub/linux/daemons/autofs/v5/patches-5.0.9/autofs-5.0.8-fix-task-manager-not-getting-signaled.patch
>
> Can you give it a try please.
>
>> Thank you !
>>     Donald
>>
>> Am 01.12.2013 08:21, schrieb Ian Kent:
>>>> On 30 Nov 2013, at 6:11 pm, Donald Buczek <buczek@molgen.mpg.de> wrote:
>>>>
>>>> Hello,
>>>>
>>>> autofs-5.0.8
>>>> kernel 3.8.2
>>>>
>>>> I've noticed, that in our installation mounts stop expiring after we send the daemon a SIGHUP to notify it about map updates.
>>> I don't see that here.
>>>
>>>> Debug log from the daemon seems to confirm that, the regular "st_expire: state 1 path... " messages no longer appear after the HUP is received and processed ("re-reading master map"...).
>>>>
>>> There have been a couple of changes in that area, I'll have a look around.
>>> Can you give a bit more detail about the problem like:
>>> does it happen the very first time every time.
>>> are there specific changes that trigger the behaviour.
>>> does it happen if no changes are actually made.
>>> what sort of activity is happening when the problem occurs.
>>>
>>> and a look at the log would probably be useful.
>>>
>>>
>>>> Maybe the signal goes to the st_queue_handler task?
>>> The signal goes to the main thread and the thread is responsible for adding tasks to the task queue as needed.
>>>
>>> That's pretty much only for readmap and program exit, but alarms (which trigger the expire runs) are cleared and set at various places, mostly at the start and end of expire run.
>>>
>>>> Regards
>>>>     Donald Buczek
>>>>
>>>> -- 
>>>> Donald Buczek
>>>> buczek@molgen.mpg.de
>>>> Tel: +49 30 8413 1433
>>>>
>>>>
>>>>
>>
>


-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

