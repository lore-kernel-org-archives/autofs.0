From: "junpyo.kim" <junpyo.kim@magnachip.com>
Subject: Re: first access fails with ENOENT after autofs started
Date: Mon, 4 Feb 2008 14:25:47 +0900
Message-ID: <11B3631FC8E5AF4EB565308D99883A95020AD959@EXCHANGE.magnachipsemi.com>
References: <479EF388.5080805@oracle.com>	<1201620505.3435.6.camel@raven.themaw.net><479FEFE8.6030800@oracle.com><1201665930.3087.15.camel@raven.themaw.net>
	<47A00688.5030501@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
To: wengang wang <wen.gang.wang@oracle.com>, Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Dear experts.

I have problem transient chdir fails on kernel 2.6.9-67.ELsmp RHEL(WS
Version4).

I'd been heard patch, have you any patch?
Know that update linux kernel, but can't update kernel. Because ECAD
Tools(such as synopsys, cadense etc.).

Do you have any idea?

Thank you.

==================================================
JunPyo Kim,  CE DT Team
junpyo.kim@magnachip.com
+82-10-2894-4415 / +82-2-6903-4637

-----Original Message-----
From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org] On Behalf Of wengang wang
Sent: Wednesday, January 30, 2008 2:09 PM
To: Ian Kent
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] first access fails with ENOENT after autofs
started

Hi Ian,

I checked the patch for 53.1.4,  and my patch is the same as that one:)
will use 53.1.4 if there is no special patches on the under using
version.

thanks,
wengang.

Ian Kent wrote:
> On Wed, 2008-01-30 at 11:32 +0800, wengang wang wrote:
>   
>> Thanks Ian for your reply.
>>
>> Ian Kent wrote:
>>     
>>> On Tue, 2008-01-29 at 17:36 +0800, wengang wang wrote:
>>>   
>>>       
>>>> Hi experts,
>>>>
>>>> In RHEL kernel 2.6.18-53 and mainline kernel 2.6.24,
>>>>     
>>>>         
>>> This was a known problem due to a couple of missing patches in the
>>> RHEL-5 kernel revision 53.
>>>
>>>   
>>>       
>> yes.
>>     
>>> I'm not aware of a problem with 2.6.24.
>>>
>>>   
>>>       
>> yes, there is no problem with 2.6.24. 
>> By involving it, I just want to say the code
>> d_instantiate(); //not d_add()
>> is the same.
>>     
>>>> in function autofs4_lookup() in fs/autofs4/root.c,
>>>> if dentry is not found in function autofs4_lookup_unhashed(),
>>>> a d_instantiate() is done on the dentry passed as parameter instead
of 
>>>> d_add().
>>>>     
>>>>         
>>> d_instantiate is used to delay hashing the dentry until the
following
>>> mkdir as this prevents a potential deadlock.
>>>
>>>   
>>>       
>>>> seems this cause a problem that the first access just after autofs 
>>>> started to
>>>> /path/to/<autofsMountPoint>/<nfsMountPoint> fail with the error
ENOENT.
>>>>
>>>> If I rolled back to use d_add(), there is no such problem.
>>>> Is this a bug or I omitted something?
>>>>     
>>>>         
>>> Considering there's virtually no information to go on here I have no
>>> idea but this hasn't been seen to be a problem other than in the
RHEL
>>> kernel above.
>>>
>>> You will need to provide a lot more information than this if you
want me
>>> to investigate.
>>>
>>>   
>>>       
>> detail for this problem is:
>> 1)  adding a line in /etc/auto.master
>>      /topdir   /etc/auto.topdir
>> 2) in auto.topdir
>>     subdir   -fstype=nfs   hostname:/path/to/exported/directory
>> 3) /etc/init.d/autofs restart
>> 4) ll /topdir/subdir
>>     got NO SUCH DIRECTORY here. 
>>     by strace, lstat returned ENOENT.
>>
>> according to your
>>
>> This was a known problem due to a couple of missing patches in the
>> RHEL-5 kernel revision 53.
>>
>> I made a patch by comparing RHEL-5 53 kernel with 2.6.24.  and seems
it 
>> solves the problem.
>>     
>
> Why, an updated kernel is available for RHEL-5 and has been for some
> time. Try revision 53.1.4.
>
> I started on getting this fixed as soon as I noticed the patches
> missing.
>
>   
>> the patch is as below:
>>
------------------------------------------------------------------------
----------------------------
>> --- ./fs/autofs4/root.c.orig    2008-01-29 22:20:18.000000000 -0500
>> +++ ./fs/autofs4/root.c 2008-01-29 22:20:47.000000000 -0500
>> @@ -662,10 +662,18 @@
>>          * doesn't do the right thing for all system calls, but it
should
>>          * be OK for the operations we permit from an autofs.
>>          */
>> -       if (dentry->d_inode && d_unhashed(dentry)) {
>> +       if (!oz_mode && d_unhashed(dentry)) {
>> +               struct dentry *parent = dentry->d_parent;
>> +               struct dentry *new = d_lookup(parent,
&dentry->d_name);
>> +               if (new != NULL)
>> +                       dentry = new;
>> +               else
>> +                       dentry = ERR_PTR(-ENOENT);
>> +
>>                 if (unhashed)
>>                         dput(unhashed);
>> -               return ERR_PTR(-ENOENT);
>> +
>> +               return dentry;
>>         }
>>  
>>         if (unhashed)
>>
------------------------------------------------------------------------
----------------------------
>>
>> is this patch ok and enough for RHEL-5 kernel revision 53?
>>     
>
> Can't remember now but it's the dentry->d_inode -> !oz_mode change
that
> is needed for the d_add -> d_instantiate deadlock fix and yes we also
> need to check if someone beat us to the mount with the d_lookup.
>
> However, you really should use the supported updates.
>
> Ian
>
>
>   

-- 
Wengang Wang
Member of Technical Staff
Oracle Asia R&D Center
Open Source Technologies Development

Tel:      +86 10 8278 6265
Mobile:   +86 13381078925

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs
