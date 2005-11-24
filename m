From: Farkas Levente <lfarkas@bppiac.hu>
Subject: Re: automount never umount
Date: Fri, 25 Nov 2005 00:17:36 +0100
Message-ID: <43864A10.4090801@bppiac.hu>
References: <4381E865.4070908@bppiac.hu>
	<Pine.LNX.4.58.0511220822410.16196@wombat.indigo.net.au>
	<4382E835.3020904@bppiac.hu>
	<Pine.LNX.4.63.0511222054060.2600@donald.themaw.net>
	<438344F7.8020503@bppiac.hu>
	<17283.19512.49399.338448@segfault.boston.redhat.com>
	<43838CA9.40105@bppiac.hu>
	<17283.46783.748916.772469@segfault.boston.redhat.com>
	<438435EF.6080102@bppiac.hu>
	<Pine.LNX.4.63.0511232105320.3200@donald.themaw.net>
	<43846C1C.3050305@bppiac.hu>
	<17284.35467.301318.255602@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0511232334300.3253@donald.themaw.net>
	<17284.40834.559604.943290@segfault.boston.redhat.com>
	<4384A354.9040502@bppiac.hu>
	<17284.41971.660257.356263@segfault.boston.redhat.com>
	<43859055.3020508@bppiac.hu>
	<Pine.LNX.4.63.0511242003250.2069@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511242003250.2069@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> On Thu, 24 Nov 2005, Farkas Levente wrote:
> 
> 
>>Jeff Moyer wrote:
>>
>>>lfarkas> a full lsof ? fuser -v for what?
>>>
>>>For the mount points in question.  I guess something like:
>>>
>>>fuser -v -m <automountpoint>
>>>
>>>lsof +D <automountpoint>
>>
>>ok now i use only nfs and no smbfs, uprgade to
>>kernel-2.6.14-1.1641_FC4.jmoyertest.2 but it doesn't show me any
>>difference. so here is the current daemon log and that's all:-(
>>-------------------------------
>>[root@garfield ~]# fuser -v -m /net/
>>
>>                     USER        PID ACCESS COMMAND
>>/net/                root       1919 f....  automount
>>[root@garfield ~]# lsof +D /net/
>>COMMAND    PID USER   FD   TYPE DEVICE SIZE NODE NAME
>>automount 1919 root    5r   DIR   0,20    0 5471 /net/
>>-------------------------------
>>new tips?
> 
> 
> These's still no printk output?
> 
> So no explanation of what is wrong.
> 
> Jeff we could enable DEBUG in the kernel module.
> What do you think.
> 
> If it would be better I could take the source from the kernel you have and 
> put together a tarball. Farkas could then compile and install it so that 
> the original module can restored with a "make uninstall" when we are done.

i try what you want, althugh i prefer rpms.

-- 
   Levente                               "Si vis pacem para bellum!"
