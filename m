From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: top level mount point
Date: Mon, 01 Oct 2007 11:05:54 -0400
Message-ID: <x49odfiyiwd.fsf@segfault.boston.devel.redhat.com>
References: <10badf220709110016w454badfdt31a82bf6142171cc@mail.gmail.com>
	<1189502864.3585.10.camel@raven.themaw.net>
	<46E6D684.7010808@schrodinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46E6D684.7010808@schrodinger.com> (Simon Gao's message of "Tue\,
	11 Sep 2007 10\:55\:16 -0700")
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
To: Simon Gao <gao@schrodinger.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Simon Gao <gao@schrodinger.com> writes:

> Ian Kent wrote:
>> On Tue, 2007-09-11 at 16:46 +0930, Shane wrote:
>>   
>>> Hey All,
>>>
>>> I'm trying to get a "top-level" automount to work.  eg
>>>
>>> /home  -rw,vers=3,fstype=nfs,intr,hard,tcp,rsize=32768,wsize=32768
>>> srv1:/export/home/
>>>
>>> I've tried a few things so far - putting that exactly as is into
>>> /etc/auto.master, created an auto.direct file and put /- auto.direct
>>> into auto.master neither any joy - also tried /home  auto.home in
>>> auto.master and above but with * or / as the key as contents of
>>> auto.home none are working.
>>>     
>>
>> Not valid in auto.master.
>>
>> An indirect map must have keys that are a directory component only, that
>> is no "/"s.
>>
>> So, in auto.master you can have:
>>
>> /home	auto.home
>>
>> and auto.home as:
>>
>> *	srv1:/export/home/&
>>
>> to mount /home/myname as srv1:/export/home/myname
>>
>> You could leave out the "&" but I'm not sure that would be useful.
>>
>>   
>>> Firstly is this actually possible?  Though I have no idea how Apple
>>> translate our maps into something automount uses they do get around
>>> this but /home is a symlink to somewhere like
>>> /private/var/automount/home. If its possible ...what have I missed to
>>> get this working?
>>>     
>>
>> No, not possible with version 4.
>>
>> Single level indirect maps aren't possible by definition.
>>
>> Single level direct maps are possible with version 5.
>>
>> So, in auto.master you could have:
>>
>> /-	auto.home
>>
>> and auto.home:
>>
>> /home	svr1:/export/home
>> /other/dir	other:/export/other
>>
>> and the like.
>>
>> Ian
>>
>>   
>
> Is there a good way to set up ldap entries so autofs 4 and 5 can each
> find and match its own version of automount maps?

It depends on which version of autofs4 you are running.  The latest
versions are able to determine your default search base, but older
versions cannot.  So, if you want to be compatible across the board,
the safest way to construct your ldap entries would be something like
the following.  Change out the schema for whichever schema you want to
use.

dn: automountMapName=auto.master,dc=autofs,dc=test
objectClass: top
objectClass: automountMap
automountMapName: auto.master

dn: automountKey=/home,automountMapName=auto.master,dc=autofs,dc=test
objectClass: automount
automountKey: /home
automountInformation: ldap: automountmapname=auto.home,dc=autofs,dc=test

dn: automountMapName=auto.home,dc=autofs,dc=test
objectClass: top
objectClass: automountMap
automountMapName: auto.home

dn: automountKey=/,automountMapName=auto.test,dc=autofs,dc=test
objectClass: automount
automountKey: /
automountInformation: srv1:/export/&

Cheers,

Jeff
