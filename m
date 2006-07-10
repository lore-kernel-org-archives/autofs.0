From: "Latrell" <is85022@cis.nctu.edu.tw>
Subject: Re: Large number of mount request.
Date: Mon, 10 Jul 2006 09:40:04 +0800
Message-ID: <010301c6a3c1$ce6837f0$251a17ac@ZyXEL.com>
References: <20060708055304.30906.qmail@web56008.mail.re3.yahoo.com>
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
To: ramana@intraperson.com, Ian Kent <raven@themaw.net>, Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Hi, All:

I use autofs to mount shares of users under home directory with. Each user 
login, a map file will be created and an automount daemon will be invoked 
with options pid-file, ghost, timeout and file.
When user logout, I need the automount daemon killed. Thus, I send SIGTERM 
to the automount daemon. It's probably there are several automount daemons 
existing in the same time.
I found a case if many users logout at the same time, many SIGTERMs will be 
sent to corresponding automount daemons. In such cirsumstance, some 
automount daemons will not be killed and will exist in system forever. Thus 
I check the pid under /proc and send SIGTERM again when the automonut daemon 
not killed.

Did I use autofs in the wrong way?
Ms stress test is to keep login(invoke automount), mount(cd share1),access, 
logout(umount, kill automount) for 4 users sessions.

Many thanks,
Latrell.

ps. I patched the lock patch, and the condition not changed.

----- Original Message ----- 
From: "ramana" <intraperson@yahoo.com>
To: "Ian Kent" <raven@themaw.net>; "Latrell" <is85022@cis.nctu.edu.tw>; 
"Jeff Moyer" <jmoyer@redhat.com>
Cc: <autofs@linux.kernel.org>
Sent: Saturday, July 08, 2006 1:53 PM
Subject: Re: [autofs] Large number of mount request.


>
>
> --- Ian Kent <raven@themaw.net> wrote:
>
>>
>> I think Jeff has pretty much summed it up.
>>
>> The SIGTERM terminates autofs and you then have unnecessary startup
>> and
>> shutdown overhead giving a window where mounts will not work as there
>> is
>> no daemon to manage them.
>>
>> Don't forget that there was also a bug in the lock routines that
>> cause
>> it not to wait sometimes. Apply, at least the locking patch to 4.1.4.
>
> I do not think so.
>
> His explanation about what actually he is doing is not very clear.
>
> Little more explanation on how he is doing strss test would help,
> 'rather than trying to include his own conclusions'
>
> Thanks in advance.
>
> Regards
> ramana
>
> --
>
> Autodir
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> 
