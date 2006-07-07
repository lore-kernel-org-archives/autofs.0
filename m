From: "Latrell" <is85022@cis.nctu.edu.tw>
Subject: Re: Large number of mount request.
Date: Fri, 7 Jul 2006 20:09:21 +0800
Message-ID: <00ec01c6a1be$34af4e00$251a17ac@ZyXEL.com>
References: <20060623112741.95825.qmail@web34505.mail.mud.yahoo.com>
	<007601c6a0af$aea99c70$251a17ac@ZyXEL.com>
	<1152187091.8761.6.camel@raven.themaw.net>
	<00b201c6a17a$8050d160$251a17ac@ZyXEL.com>
	<Pine.LNX.4.64.0607071653410.2893@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; format="flowed"; charset="us-ascii"; reply-type="original"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, ramana@intraperson.com

Sorry for misunderstanding what you mean. I think I should describe my 
scenario in detail.
I use autofs to mount shares under user's home directory. It functions 
normally in normal cases.
However, in stress test,  the user continuously login->change directory 
(autofs mount in this time) -> logout (a SIGERM sent to the automount 
daemon) --> login.......
What I understand from your comment is the mounts failed because some signal 
(should be SIGTERM I sent) interruptted. Am I right?
It's possible that automount receive the SIGTERM but can't terminate in 
time! And the new session opened and issue a 'cd' command, and the mount 
interruptted. Do you think it's possible?
What I encounter is:
1 user continuous loop -> "aquire_lock: can't lock lock file interrupted" 
never happen.
3 user continuous loop  -> "aquire_lock: can't lock lock file interrupted" 
sometimes happen.
3 more user continuous loop -> "aquire_lock: can't lock lock file 
interrupted"  happened frequently

Thanks for your comment, I'm really appreciated with your help.
Latrell.

----- Original Message ----- 
From: "Ian Kent" <raven@themaw.net>
To: "Latrell" <is85022@cis.nctu.edu.tw>
Cc: <autofs@linux.kernel.org>; <ramana@intraperson.com>
Sent: Friday, July 07, 2006 5:03 PM
Subject: Re: [autofs] Large number of mount request.


> On Fri, 7 Jul 2006, Latrell wrote:
>
>> There will be an automount daemon for 1 ftp session (used to mount shares
>> under home directory).
>> I sent SIGTERM to automount when my FTP session close (because the
>> corresponding automount daemod need to be killed).
>> In my scenario, there should be multi-sessions need to be closed. Thus,
>> SIGTERM will not be unique.
>
> I'm a little confused.
> What I was suggesting is that according to the log entry below automount
> received one of the above signals which caused the mount to fail. That was
> why I asked about where the signals might have come from. If you send a
> termination signal to version 4 and a mount is busy it usually won't exit
> but I would expect any mounts in progress to fail in this manner as well.
>
>>
>> My autofs version is 4.1.4 with patch autofs4-2.4.29-20050404.patch.
>> kernel is 2.4.31 (no autofs patch for 2.4.31)
>
> You should consider appling the patches for 4.1.4 available on kernel.org.
> At least apply autofs-4.1.4-locking-fix-1.patch.
> However, the locking problem that this addresses results in lock timeout
> log entries not lock interrupted messages. The reason bieng that automount
> dosn't wiat for the lock.
>
>>
>> Thanks, for your comment,
>> Latrell.
>> ----- Original Message ----- From: "Ian Kent" <raven@themaw.net>
>> To: "Latrell" <is85022@cis.nctu.edu.tw>
>> Cc: <ramana@intraperson.com>; <autofs@linux.kernel.org>
>> Sent: Thursday, July 06, 2006 7:58 PM
>> Subject: Re: [autofs] Large number of mount request.
>>
>>
>> > On Thu, 2006-07-06 at 11:52 +0800, Latrell wrote:
>> > > Do you mean my ghost option didn't make it in time thus "cd share1"
>> > > failed?
>> > > I got the following message whenever there's "Failed to change 
>> > > directory"
>> > > error:
>> > >
>> > > automount[2306]: aquire_lock: can't lock lock file interrupted:
>> > > /var/lock/autofs
>> >
>> > And what is sending the SIGQUIT, SIGTERM or SIGINT to autofs to cause 
>> > it
>> > to stop waiting and return a interrupted fail?
>> >
>> > > automount[2306]: failed to mount autofs path /tmp/users/shares/1034
>> > >
>> > > automount[2306]: /ramdisk/mnt/var1/tmp/users/shares/1034: mount 
>> > > failed!
>> > >
>> > > I also checked the ghost did create directory share1 under the home
>> > > directory. Could the lock problem cause cd share1 fail?
>> > >
>> > > Thanks for your comment,
>> > > Latrell.
>> > >
>> > > ----- Original Message ----- From: "ramana" <intraperson@yahoo.com>
>> > > To: "Latrell" <is85022@cis.nctu.edu.tw>; <autofs@linux.kernel.org>
>> > > Sent: Friday, June 23, 2006 7:27 PM
>> > > Subject: Re: [autofs] Large number of mount request.
>> > >
>> > >
>> > > > --- Latrell <is85022@cis.nctu.edu.tw> wrote:
>> > > >
>> > > >> Hi, all:
>> > > >>
>> > > >> I have a problem with the mount and umount packet.
>> > > >> My problem is when I have a large number of mount requests, some
>> > > >> mount request packets are missing. Thus, when I "cd share1", I 
>> > > >> will
>> > > >> get "fail to change directory" because share1 is not mounted. 
>> > > >> Fewer
>> > > >> mount requests work normally.
>> > > >
>> > > > I am afraid, this is ENOENT bug.
>> > > >
>> > > > Thanks in advance.
>> > > >
>> > > > Regards
>> > > > ramana
>> > > >
>> > > > __________________________________________________
>> > > > Do You Yahoo!?
>> > > > Tired of spam?  Yahoo! Mail has the best spam protection around
>> > > > http://mail.yahoo.com
>> > > >
>> > > > __________________________________________________
>> > > > Do You Yahoo!?
>> > > > Tired of spam?  Yahoo! Mail has the best spam protection around
>> > > > http://mail.yahoo.com
>> > > >
>> > >
>> > > _______________________________________________
>> > > autofs mailing list
>> > > autofs@linux.kernel.org
>> > > http://linux.kernel.org/mailman/listinfo/autofs
>> >
>>
>> _______________________________________________
>> autofs mailing list
>> autofs@linux.kernel.org
>> http://linux.kernel.org/mailman/listinfo/autofs
>>
> 
