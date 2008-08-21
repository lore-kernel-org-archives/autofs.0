From: Jeff Blaine <jblaine@kickflop.net>
Subject: Re: LDAP-based "auto.net" for /net
Date: Thu, 21 Aug 2008 10:21:21 -0400
Message-ID: <48AD79E1.6010509@kickflop.net>
References: <39967.129.83.31.3.1219317751.squirrel@webmail.kickflop.net>	
	<x493akyjxr4.fsf@segfault.boston.devel.redhat.com>	
	<48AD7135.9080406@kickflop.net>	
	<x49y72qiip7.fsf@segfault.boston.devel.redhat.com>	
	<1219326432.15073.6.camel@raven.themaw.net>
	<48AD75F0.5000000@kickflop.net>
	<1219327698.15073.10.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1219327698.15073.10.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

I believe "w00t" is the appropriate response.  I'm not
sure what I was doing wrong, but that works fine.  Thanks.

Ian Kent wrote:
> On Thu, 2008-08-21 at 10:04 -0400, Jeff Blaine wrote:
>> I'm using the RFC2307bis schema.  I have everything working
>> so far with the exception of /net (such as auto.home).
>>
>> /etc/sysconfig/autofs contains (among other things):
>> DEFAULT_MAP_OBJECT_CLASS="automountMap"
>> DEFAULT_ENTRY_OBJECT_CLASS="automount"
>> DEFAULT_MAP_ATTRIBUTE="automountMapName"
>> DEFAULT_ENTRY_ATTRIBUTE="automountKey"
>> DEFAULT_VALUE_ATTRIBUTE="automountInformation"
>>
>> Here's LDIF of mine for a site-specific 'auto.nfs' map's
>> entry (/NFS/reverse ----> jellyroll:/reverse)
>>
>> dn: automountMapName=auto.nfs,dc=rcf,dc=foo,dc=org
>> objectClass: top
>> objectClass: automountMap
>> automountMapName: auto.nfs
>>
>> dn: automountkey=/NFS,automountMapName=auto.master,dc=rcf,dc=foo,dc=org
>> objectClass: top
>> objectClass: automount
>> automountKey: /NFS
>> automountInformation: 
>> ldap:rcf-ldap1.foo.org:automountmapname=auto.nfs,dc=rcf,
>> dc=foo,dc=org
> 
> So what about something like:
> 
> dn: automountkey=/net,automountMapName=auto.master,dc=rcf,dc=foo,dc=org
> objectclass: top
> objectclass: automount
> automountkey: /net
> automountinformation:-hosts
> 
> I'm not sure if the "-" will give you trouble?
> 
>> dn: automountKey=reverse,automountMapName=auto.nfs,dc=rcf,dc=foo,dc=org
>> objectClass: top
>> objectClass: automount
>> automountKey: reverse
>> automountInformation: jellyroll:/&
>>
>> Ian Kent wrote:
>>> On Thu, 2008-08-21 at 09:47 -0400, Jeff Moyer wrote:
>>>> Jeff Blaine <jblaine@kickflop.net> writes:
>>>>
>>>>> Jeff Moyer wrote:
>>>>>> jblaine@kickflop.net writes:
>>>>>>
>>>>>>> If anyone has been successful in getting /net/hostname
>>>>>>> automounting working with LDAP-based autofs maps (not
>>>>>>> a local /etc/auto.net file), I would love to see your
>>>>>>> LDIF information showing how you configured it.
>>>>>> First, program maps must be on a file system.  Second, are you using
>>>>>> autofs version 4 or 5?  
>>>>> AutoFS 5.
>>>>>
>>>>>> If 5, then you can simply use the ldif equivalent of:
>>>>>> /net       -hosts
>>>>> That's what I am trying to do :)  I was hoping someone could
>>>>> show me theirs.  It's not clear to me how to construct that
>>>>> particular set of LDIF info.
>>> And what have you got in LDAP now or are you starting from scratch?
>>>
>>>> OK, what schema are you using?
>>>>
>>>> -Jeff
>>>>
>>>> _______________________________________________
>>>> autofs mailing list
>>>> autofs@linux.kernel.org
>>>> http://linux.kernel.org/mailman/listinfo/autofs
> 
