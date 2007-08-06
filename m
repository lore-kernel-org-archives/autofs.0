From: Jim Summers <jsummers@bachman.cs.ou.edu>
Subject: Re: AutoFS5 Ldap base strangeness
Date: Mon, 06 Aug 2007 15:24:02 -0500
Message-ID: <46B78362.1060904@cs.ou.edu>
References: <46B23DFB.7060200@cs.ou.edu>	
	<1186111889.3573.5.camel@raven.themaw.net>
	<46B3715F.2080805@cs.ou.edu>
	<1186214661.4233.2.camel@raven.themaw.net>
Reply-To: jsummers@bachman.cs.ou.edu
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1186214661.4233.2.camel@raven.themaw.net>
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



Ian Kent wrote:
> On Fri, 2007-08-03 at 13:18 -0500, Jim Summers wrote:
>> Ian Kent wrote:
>>> On Thu, 2007-08-02 at 15:26 -0500, Jim Summers wrote:
>>>> hello all,
>>>>
>>>> I am just about to get my automounting working with autofs5 and my ldap.  I am
>>>> able to start the automount daemon and it loads and reads /home map, which
>>>> points at ou=auto.home for the user's home directory location and options.
>>>>
>>>> but when i attempt to su - <user> it can not mount the user's home.  here is
>>>> what i see in the ldap server's access log:
>>>> ===
>>>> [31/Jul/2007:15:28:19 -0500] conn=8420 op=1 SRCH
>>>> base="cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu" scope=2
>>>> filter="(&(objectClass=automount)(|(automountKey=tmac)(automountKey=/)))"
>>>> attrs="automountKey automountInformation"
>>>> [31/Jul/2007:15:28:19 -0500] conn=8420 op=1 RESULT err=0 tag=101 nentries=0
>>>> etime=0
>>>> [31/Jul/2007:15:28:19 -0500] conn=8420 op=2 UNBIND
>>>> ===
>>>>
>>>> the weird part of the above is, in the first line it says "cn=sfu" but then
>>>> also says automountKey=tmac
>>>>
>>>> the su command is:  su - tmac
>>>>
>>>> so the correct username is tmac not sfu.
>>>>
>>>> any ideas where the sfu thing is coming from??
>>>>
>>>> is the info cached somewhere?  I ask because when I start the daemon, i can
>>>> see in the logs where it does:
>>>> ===
>>>> [31/Jul/2007:15:35:40 -0500] conn=8536 op=1 SRCH
>>>> base="ou=auto.home,dc=it,dc=ou,dc=edu" scope=2
>>>> filter="(objectClass=automount)" attrs="1.1"
>>>> [31/Jul/2007:15:35:40 -0500] conn=8536 op=1 RESULT err=0 tag=101 nentries=617
>>>> etime=0
>>>> ===
>>>> which is returning 617 entries.
>>>>
>>>> not sure what i have wroong here??
>>> Me neither.
>>>
>>> How about posting an ldapsearch of the auto.home and what's used for the
>>> master map.
>> I think you may be on to something.
>>
>> Here is the auto.master
>>
>> /home   ldap://landin/ou=auto.home,dc=it,dc=ou,dc=edu
>>
>> and here is a snip from an ldapsearch of auto.home.
>>
>> dn: ou=auto.home,dc=it,dc=ou,dc=edu
>> objectClass: top
>> objectClass: organizationalUnit
>> ou: auto.home
> 
> I don't think version 5 will let you get away with not adding
> objectClass: automountMap
> in this entry or maybe
> objectClass: nisMap
> at least I think those are the class names.

Excellent, that has fixed the problem. after adding:

objectClass: automountMap
automountMapName: auto.home

then the homes were mountable.

Many Thanks!


> 
>> dn: cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu
>> objectClass: automount
>> objectClass: nisObject
>> objectClass: top
>> cn: sfu
>> automountKey: sfu
>> automountInformation: -rw,rsize=4096,wsize=4096 turing:/it/turing/home2/sfu
>> nisMapEntry: turing:/it/turing/home2/sfu
>> nisMapName: auto.home
>>
>> dn: cn=cfranklin,ou=auto.home,dc=it,dc=ou,dc=edu
>> objectClass: automount
>> objectClass: nisObject
>> objectClass: top
>> cn: cfranklin
>> automountKey: cfranklin
>> automountInformation: -rw,rsize=8192,wsize=8192 rabin:/raid/facstaff/cfranklin
>> nisMapEntry: rabin:/raid/facstaff/cfranklin
>> nisMapName: auto.home
>>
>> naturally there are several hundred more user entries.
>>
>> what do you think?
>>
>> tia
>>
>>
>>> Ian
>>>
>>>
>>> _______________________________________________
>>> autofs mailing list
>>> autofs@linux.kernel.org
>>> http://linux.kernel.org/mailman/listinfo/autofs

-- 
Jim Summers
School of Computer Science-University of Oklahoma
-------------------------------------------------
