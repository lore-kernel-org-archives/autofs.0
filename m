From: Ian Kent <raven@themaw.net>
Subject: Re: Automounter stops after reload signal.
Date: Sun, 03 May 2009 11:16:35 +0800
Message-ID: <49FD0C93.9010100@themaw.net>
References: <49DCCD73.5050307@bononline.nl>
	<1239545315.23791.0.camel@zeus.themaw.net>
	<49E22C1D.8030504@bononline.nl> <49E2D284.1040801@themaw.net>
	<49E2F90A.9010901@bononline.nl> <49E2FF76.2080108@themaw.net>
	<20090424043142.GA3172@zeus.themaw.net>
	<20090424045400.GA5578@zeus.themaw.net>
	<49F17607.1010606@bononline.nl>
	<20090501024052.GA3519@zeus.themaw.net>
	<49FCDCC2.4090201@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49FCDCC2.4090201@bononline.nl>
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
>> On Fri, Apr 24, 2009 at 10:19:19AM +0200, Stef Bon wrote:
>>  
>>> Ian Kent wrote:
>>>    
>>>> Oops, that's not quite right.
>>>> Try this instead, of course the CHANGELOG hunk might not apply.
>>>>       
>>
>> And there was another mistake in this patch.
>> This one hopefully will be the final form of the fix.
>>
>> autofs-5.0.4 - library reload fix update fix
>>   
> 
> Ok,
> 
> I have not been able to apply and test this patch. The last one is doing
> very well.

The problem with the original patch was that, if autofs started with no
mounts in the master map (for some reason), it wasn't able to exit when
sent a TERM signal.

Ian
