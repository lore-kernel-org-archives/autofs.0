From: raven@themaw.net
Subject: Re: Use of egrep without "|| true" in the init.d script
Date: Mon, 7 Mar 2005 10:52:01 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0503071050060.8807@donald.themaw.net>
References: <20050224131844.GA5150@uio.no>
	<Pine.LNX.4.62.0503061156360.8723@donald.themaw.net>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.62.0503061156360.8723@donald.themaw.net>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Sun, 6 Mar 2005 raven@themaw.net wrote:

>
> Hi Jeff,
>
> This issue relates to the umount_loopback function.
>
> I believe this patch was the result of a RedHat bug report.
> Did you manage to track this down?
>
> As I mentioned before autofs should umount all mounts that are not busy at 
> shutdown. I'm planning on removing this for beta3 until we can work out why 
> it was needed. Hope that will not cause problems for you.

Aaahhm ... I've changed my mind as there's surely some reason for it in 
the first place.

I'll code around it but I'd still like to know the history please.

>
> Ian
>
> On Thu, 24 Feb 2005, Steinar H. Gunderson wrote:
>
>>  Ian,
>> 
>>  Would you like to take a look at
>>  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=295480 ?
>> 
>>  The problem looks real enough to me (although I don't see the specific
>>  circumstances where it would break), and it should probably be fixed for
>>  beta3.
>> 
>>  /* Steinar */
>>  -- 
>>  Homepage: http://www.sesse.net/
>> 
>>  _______________________________________________
>>  autofs mailing list
>>  autofs@linux.kernel.org
>>  http://linux.kernel.org/mailman/listinfo/autofs
>> 
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
