From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs looks up wrong path element metoo and /net
	question
Date: Mon, 24 Oct 2005 19:16:53 -0400
Message-ID: <17245.27493.442472.417163@segfault.boston.redhat.com>
References: <200509251900.j8PJ0HIm008775@hera.kernel.org>
	<Pine.LNX.4.61.0509271133270.9747@pod.adc.idt.com>
	<17245.22591.307788.606416@segfault.boston.redhat.com>
	<Pine.LNX.4.61.0510241911160.25037@pod.adc.idt.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0510241911160.25037@pod.adc.idt.com>
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
Content-Type: text/plain; charset="us-ascii"
To: devnull@adc.idt.com
Cc: AutoFS on Linux Kernel <autofs@linux.kernel.org>

==> Regarding Re: [autofs] autofs looks up wrong path element metoo and /net question; devnull@adc.idt.com adds:

devnull> Thanks Jeff.
devnull> http://hera.kernel.org/pipermail/autofs/2005-October/002517.html

devnull> Has 2 patches. One for expire.c and one for root.c

devnull> I am assuming I need the root.c one only..?

That's actually a slightly different problem.  That patch is undergoing
testing right now.  If you'd like to add yourself to the list of testers,
then by all means apply that patch.  You will want to apply the entire
patch.

devnull> Thanks for your help.

np.

-Jeff


On Mon, 24 Oct 2005, Jeff Moyer wrote:

>> Date: Mon, 24 Oct 2005 17:55:11 -0400 From: Jeff Moyer
>> <jmoyer@redhat.com> To: devnull@adc.idt.com Cc: AutoFS on Linux Kernel
>> <autofs@linux.kernel.org> Subject: Re: [autofs] autofs looks up wrong
>> path element metoo and /net question
>> 
>> ==> Regarding [autofs] autofs looks up wrong path element metoo and /net
>> question; devnull@adc.idt.com adds:
>> 
devnull> Ian, list.  Fedora Core 2
>>
devnull> /usr/sbin/automount -V Linux automount version 4.1.4
>> So you built your own?  OK.
>> 
devnull> I am running automount with /usr/sbin/automount --ghost -v --debug
>>
devnull> uname -r 2.6.7 / 2.4.31
>> Again, your own kernel?  Ian posted a kernel patch to fix the issue.
>> You probably want to grab that, though I can't find a pointer to it at
>> the moment.  I've attached the equivalent patch that went into RHEL3,
>> for reference.
>> 
>> -Jeff
>> 
>> --- linux-2.4.21/fs/autofs4/root.c.orig 2005-05-31 09:31:16.097321176
>> -0400 +++ linux-2.4.21/fs/autofs4/root.c 2005-05-31 09:31:19.816755736
>> -0400 @@ -301,7 +301,14 @@ static int try_to_fill_dentry(struct den
>> 
>> DPRINTK(("try_to_fill_entry: expire done status=%d\n", status));
>> 
>> - return 0; + /* + * If the directory still exists the mount request
>> must + * continue otherwise it can't be followed at the right + * time
>> during the walk.  + */ + status = d_invalidate(dentry); + if (status !=
>> -EBUSY) + return 0; }
>> 
>> DPRINTK(("try_to_fill_entry: dentry=%p %.*s ino=%p\n",
>> 

devnull> /dev/null

devnull> devnull@adc.idt.com
