From: "Latrell" <is85022@cis.nctu.edu.tw>
Subject: Re: Large number of mount request.
Date: Fri, 7 Jul 2006 12:04:45 +0800
Message-ID: <00b201c6a17a$8050d160$251a17ac@ZyXEL.com>
References: <20060623112741.95825.qmail@web34505.mail.mud.yahoo.com>
	<007601c6a0af$aea99c70$251a17ac@ZyXEL.com>
	<1152187091.8761.6.camel@raven.themaw.net>
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

There will be an automount daemon for 1 ftp session (used to mount shares 
under home directory).
I sent SIGTERM to automount when my FTP session close (because the 
corresponding automount daemod need to be killed).
In my scenario, there should be multi-sessions need to be closed. Thus, 
SIGTERM will not be unique.

My autofs version is 4.1.4 with patch autofs4-2.4.29-20050404.patch.
kernel is 2.4.31 (no autofs patch for 2.4.31)

Thanks, for your comment,
Latrell.
----- Original Message ----- 
From: "Ian Kent" <raven@themaw.net>
To: "Latrell" <is85022@cis.nctu.edu.tw>
Cc: <ramana@intraperson.com>; <autofs@linux.kernel.org>
Sent: Thursday, July 06, 2006 7:58 PM
Subject: Re: [autofs] Large number of mount request.


> On Thu, 2006-07-06 at 11:52 +0800, Latrell wrote:
>> Do you mean my ghost option didn't make it in time thus "cd share1" 
>> failed?
>> I got the following message whenever there's "Failed to change directory"
>> error:
>>
>> automount[2306]: aquire_lock: can't lock lock file interrupted:
>> /var/lock/autofs
>
> And what is sending the SIGQUIT, SIGTERM or SIGINT to autofs to cause it
> to stop waiting and return a interrupted fail?
>
>> automount[2306]: failed to mount autofs path /tmp/users/shares/1034
>>
>> automount[2306]: /ramdisk/mnt/var1/tmp/users/shares/1034: mount failed!
>>
>> I also checked the ghost did create directory share1 under the home
>> directory. Could the lock problem cause cd share1 fail?
>>
>> Thanks for your comment,
>> Latrell.
>>
>> ----- Original Message ----- 
>> From: "ramana" <intraperson@yahoo.com>
>> To: "Latrell" <is85022@cis.nctu.edu.tw>; <autofs@linux.kernel.org>
>> Sent: Friday, June 23, 2006 7:27 PM
>> Subject: Re: [autofs] Large number of mount request.
>>
>>
>> > --- Latrell <is85022@cis.nctu.edu.tw> wrote:
>> >
>> >> Hi, all:
>> >>
>> >> I have a problem with the mount and umount packet.
>> >> My problem is when I have a large number of mount requests, some
>> >> mount request packets are missing. Thus, when I "cd share1", I will
>> >> get "fail to change directory" because share1 is not mounted. Fewer
>> >> mount requests work normally.
>> >
>> > I am afraid, this is ENOENT bug.
>> >
>> > Thanks in advance.
>> >
>> > Regards
>> > ramana
>> >
>> > __________________________________________________
>> > Do You Yahoo!?
>> > Tired of spam?  Yahoo! Mail has the best spam protection around
>> > http://mail.yahoo.com
>> >
>> > __________________________________________________
>> > Do You Yahoo!?
>> > Tired of spam?  Yahoo! Mail has the best spam protection around
>> > http://mail.yahoo.com
>> >
>>
>> _______________________________________________
>> autofs mailing list
>> autofs@linux.kernel.org
>> http://linux.kernel.org/mailman/listinfo/autofs
> 
