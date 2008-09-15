From: Alexander <normalex@gmail.com>
Subject: Re: autofs Digest, Vol 66, Issue 9
Date: Sun, 14 Sep 2008 22:26:48 -0700
Message-ID: <e788514b0809142226q3be9c84do7a0e971bfcd7d0ad@mail.gmail.com>
References: <mailman.1.1221393601.15542.autofs@linux.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <mailman.1.1221393601.15542.autofs@linux.kernel.org>
Content-Disposition: inline
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
To: autofs@linux.kernel.org

you should put actual numbers instead of $GID and $UID.


2008/9/14  <autofs-request@linux.kernel.org>:
> Send autofs mailing list submissions to
>        autofs@linux.kernel.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>        http://linux.kernel.org/mailman/listinfo/autofs
> or, via email, send a message with subject or body 'help' to
>        autofs-request@linux.kernel.org
>
> You can reach the person managing the list at
>        autofs-owner@linux.kernel.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of autofs digest..."
>
>
> Today's Topics:
>
>   1. Re: How to use the user mount option (Richard Ray)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Sat, 13 Sep 2008 14:00:03 -0500 (CDT)
> From: Richard Ray <rray@mstc.state.ms.us>
> Subject: Re: [autofs] How to use the user mount option
> To: autofs@linux.kernel.org
> Message-ID: <Pine.LNX.4.64.0809131353430.14642@rray.drdc.mstc.ms.gov>
> Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
>
> On Sat, 13 Sep 2008, Ian Kent wrote:
>
>> On Fri, 2008-09-12 at 13:08 -0500, Richard Ray wrote:
>>> I feel this must be a simple thing but it is not working for me.
>>> In auto.misc I have
>>>
>>> flash -fstype=auto,rw,sync,flush,user    :/dev/sdb1
>>>
>>> In auto.master I have
>>>
>>> /misc file:/etc/auto.misc
>>>
>>> If I cd /misc/flash the device will mount but all files belong to root
>>> If I add uid= to auto.misc the files belong to me
>>> Should not the user option do that without specifying a uid
>>
>> The "user" option is an fstab only option.
>>
>> So, since autofs specifies the device and the mount point mount(8)
>> doesn't consult the fstab.
>>
>> The only option you have is something like:
>> flash -fstype=auto,rw,sync,flush,uid=$UID,gid=$GID    :/dev/sdb1
>>
>> As long as the requester is a valid user on the system it should mount
>> as that user.
>
> I am a bit less ignorant now but this opens a new can of worms.
> Is there documentation for mount options that are not valid in map files?
> $GID and $UID are not variables I see when I run env so where do they come
> from?
> Are there othere variables that can be used in map files?
> Can I use something like $(id -u) in a map file?
>
> Thanks
> Richard Ray
>
>
>
>>
>>>
>>> Name        : autofs
>>> Version     : 5.0.2
>>> Release     : 27
>>>
>>> Fedora 8
>>> kernel: 2.6.24.4-64.fc8
>>>
>>> Thanks
>>> Richard Ray
>>>
>>> _______________________________________________
>>> autofs mailing list
>>> autofs@linux.kernel.org
>>> http://linux.kernel.org/mailman/listinfo/autofs
>>
>
>
>
> ------------------------------
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
>
> End of autofs Digest, Vol 66, Issue 9
> *************************************
>



-- 
Sincerely,
Alexandr N.
