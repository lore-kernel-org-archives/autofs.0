From: "Latrell" <is85022@cis.nctu.edu.tw>
Subject: Re: Large number of mount request.
Date: Thu, 6 Jul 2006 11:52:54 +0800
Message-ID: <007601c6a0af$aea99c70$251a17ac@ZyXEL.com>
References: <20060623112741.95825.qmail@web34505.mail.mud.yahoo.com>
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
To: ramana@intraperson.com, autofs@linux.kernel.org

Do you mean my ghost option didn't make it in time thus "cd share1" failed?
I got the following message whenever there's "Failed to change directory" 
error:

automount[2306]: aquire_lock: can't lock lock file interrupted: 
/var/lock/autofs
automount[2306]: failed to mount autofs path /tmp/users/shares/1034

automount[2306]: /ramdisk/mnt/var1/tmp/users/shares/1034: mount failed!

I also checked the ghost did create directory share1 under the home 
directory. Could the lock problem cause cd share1 fail?

Thanks for your comment,
Latrell.

----- Original Message ----- 
From: "ramana" <intraperson@yahoo.com>
To: "Latrell" <is85022@cis.nctu.edu.tw>; <autofs@linux.kernel.org>
Sent: Friday, June 23, 2006 7:27 PM
Subject: Re: [autofs] Large number of mount request.


> --- Latrell <is85022@cis.nctu.edu.tw> wrote:
>
>> Hi, all:
>>
>> I have a problem with the mount and umount packet.
>> My problem is when I have a large number of mount requests, some
>> mount request packets are missing. Thus, when I "cd share1", I will
>> get "fail to change directory" because share1 is not mounted. Fewer
>> mount requests work normally.
>
> I am afraid, this is ENOENT bug.
>
> Thanks in advance.
>
> Regards
> ramana
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> 
