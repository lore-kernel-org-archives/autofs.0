From: Sev Binello <sev@bnl.gov>
Subject: Re: automount[ ]: failed to mount
Date: Thu, 10 Mar 2005 15:01:35 -0500
Message-ID: <4230A79F.1030806@bnl.gov>
References: <4228E196.4090303@bnl.gov> <4230A701.40202@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <4230A701.40202@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: cfeist@redhat.com
Cc: autofs@linux.kernel.org


Yes, trying it already.
Installed it yesterday.
No failed mount  messages since.
Looks goo so far.

Thanks
-Sev

Chris Feist wrote:

> Can you try the new autofs package for RHEL3?
>
> http://people.redhat.com/jmoyer/autofs-4.1.3-104.i386.rpm
>
> Note: this is a package for RHEL3, not Fedora Core (it may not work 
> with FC).
>
> Thanks,
> Chris
>
>
> Sev Binello wrote:
>
>>
>> Can anyone shed any light on the significance of the error messages 
>> below?
>>
>> We constantly get messages of the form ....
>>
>> Mar  4 11:28:57 acnlin43 automount[2740]: attempting to mount entry 
>> /cfs/g
>> Mar  4 11:29:00 acnlin43 automount[14890]: mount(nfs): no host elected
>> Mar  4 11:29:00 acnlin43 automount[14890]: failed to mount /cfs/g
>>
>> or just simply....
>>
>>   Mar  4 09:58:17 acnlin42 automount[30250]: failed to mount /cfs/ad
>>
>>
>>
>> Followed by a successful mount not too long afterward...
>> Mar  4 11:33:54 acnlin43 automount[2740]: attempting to mount entry 
>> /cfs/g
>>
>> The failure bounces around to different filesystems -- using /cfs/g 
>> here as an example --
>> even though the nfs severs for these filesystems are up and running.
>>
>> We are running Redhat WS updates 1,2,3,4  and autofs-3.1.7-41 
>> autofs-4.1.3-47
>> our mounts look something like this ( we normally use udp, but also 
>> tested with tcp)...
>> in auto.master
>>        /cfs    /etc/auto.cfs   --timeout 60
>> in auto.cfs
>>            g    -ro,intr,noquota,proto=tcp                
>> acnlin34.pbn.bnl.gov:/cfsg
>>
>>
>>
>> Thanks,
>> -Sev
>>
>> _______________________________________________
>> autofs mailing list
>> autofs@linux.kernel.org
>> http://linux.kernel.org/mailman/listinfo/autofs
>
