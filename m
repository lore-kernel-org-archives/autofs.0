From: Alexander Macdonald <alexandermacdonald@yahoo.com>
Subject: Re: 2.6 patches broken with 2.6.4
Date: Thu, 11 Mar 2004 19:30:25 +0000
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4050BE51.6010908@yahoo.com>
References: <Pine.LNX.4.44.0312022129550.2970-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312022129550.2970-100000@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

The patches have applied cleanly to all kernels up to now, however the second 
patch (and maybe more, didn't try them since there wasn't any point) won't apply 
cleanly to kernel 2.6.4.

I don't know about anybody else's experience with these patches but I haven't 
had any trouble with them at all, maybe you should send them to Andrew Morton 
for inclusion in the -mm branch, That'd save me some patching time for each 
kernel ;)


Keep up the good work!
Alex


Ian Kent wrote:
> Hi guys,
> 
> I have some 2.6 patches.
> 
> They can be found at 
> 
> http://www.kernel.org/pub/linux/kernel/people/raven/autofs4-2.6
> 
> Apply them in number order please.
> 
> Please leave out the max_anon_2.patch initially. We need to establish what 
> the status of the kernel module is before trying this patch. It was 
> written by Mike Waychison to increase the number of anonymous devices. 
> Once the status patches is established it would be good to how the 
> max_anon patch goes with over 255 mounts and less than about 790 (rpc 
> doesn't allow more than that at the moment).
> 
> Try as many or as few things as your setup allows and please try and give 
> some coverage of what was used and what went wrong. We need to try this on 
> SMP setups if at all possible.
> 
> I know I don't need to say this to ypu guys but I will anyway. Please make 
> sure that you do staged testing. What I'm saying is steady as it goes. 
> First a single machine then a couple etc., you know the routine. While the 
> general approach of the patches is the same as what I have used for ages 
> in 2.4 the locking and synchronisation is different and may not be 
> correct (read I think it's not quite right but need evidence to confirm 
> it).
> 
> Looking forward to your feedback.
> 
> On Sun, 16 Nov 2003, Chris Croswhite wrote:
> 
> 
>>I can offer up about 75 Linux boxes as testing.  They are used pretty heavily mounting about 300-400 differnet mount points during the day from slowlaris, HPsUx, Linux and NetApp file systems.  Just let me know.
>>
>>TIA,
>>Chris
>>
>>
>>-----Original Message-----
>>From:	Ian Kent [mailto:raven@themaw.net]
>>Sent:	Sun 16-Nov-03 18:53
>>To:	Alexander Macdonald
>>Cc:	autofs@linux.kernel.org
>>Subject:	Re: [autofs] making the mountpoints visible all the time (fwd)
>>On Sun, 16 Nov 2003, Alexander Macdonald wrote:
>>
>>
>>>I'm happy to try out any patches, although I'm only using autofs for
>>>about 20 or so samba and nfs shares on a few pcs so it wont exactly be
>>>thorough enterprise level testing :)
>>>
>>>
>>>>In fact, I don't have a 2.6 environment other than what I use to test at
>>>>home so volenteers are needed for testing. We can't expect the changes
>>>>to be accepted without some testing other than my simple setup.
>>>>
>>>>
>>
>>Any help is appreciated.
>>
>>I'll let you know when I've got something to test.
>>
>>Thanks.
>>
>>
> 
> 
