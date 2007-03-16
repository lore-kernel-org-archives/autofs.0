From: Peter Staubach <staubach@redhat.com>
Subject: Re: Autofs weirdness in nsswitch.conf and other stuff...
Date: Fri, 16 Mar 2007 14:21:23 -0400
Message-ID: <45FAE023.5010805@redhat.com>
References: <60464.128.114.56.35.1173996300.squirrel@webmail.soe.ucsc.edu>	<1174008860.3397.9.camel@raven.themaw.net>	<45FA996D.2080606@redhat.com>	<1174055083.3397.11.camel@raven.themaw.net>	<45FAABA3.8060608@redhat.com>	<x494polck3t.fsf@segfault.boston.devel.redhat.com>	<45FAB4B8.7060908@soe.ucsc.edu>	<1174062776.3397.51.camel@raven.themaw.net>	<Pine.LNX.4.64.0703160951030.11089@simba.math.ucla.edu>
	<1174066773.3397.76.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1174066773.3397.76.camel@raven.themaw.net>
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
> On Fri, 2007-03-16 at 10:09 -0700, Jim Carter wrote:
>   
>> On Sat, 17 Mar 2007, Ian Kent wrote:
>>
>>     
>>> Let me see if I can clear this up.
>>> ...
>>> The first instance of a master map that is found, using nsswitch, is
>>> used unless it is explicitly specified, such as "/etc/auto.master",
>>> ...
>>> The first instance of each autofs managed indirect mount that is found
>>> in the master map is used. The corresponding map given in the entry is
>>> looked for by using nsswitch specified sources unless the source is
>>> explicitly given, such as "/etc/auto.mymap" in which case only that map
>>> is used. Additional instances of the same indirect mount point in the
>>> configuration are ignored.
>>> ...
>>> Automount key lookups use the same rules as the lookup of maps above and
>>> the first instance of a map key found is used.
>>>       
>> Yes, this does clear it up.  Autofs' philosophy differs from other 
>> nsswitchable maps, where a key is looked for in potentially every listed 
>> data source until found.  Whereas, autofs identifies the first map that 
>> exists, and looks up a key in that map, and if it's absent, you lose.  It 
>> doesn't go on to look for the key in subsequent data sources such as LDAP, 
>> unless the plus kludge has been used.  (In any case, the first found 
>> instance of the key is used and subsequent instances or sources are 
>> not looked at.)
>>     
>
> Maybe I have got this wrong then.
>
> I thought the default nsswitch action was [NOTFOUND=continue] so autofs
> will search multiple source instances of a given map name for a key and
> the first match will succeed or not found will be returned. This is so
> only if the map source is not explicitly given in the map name in which
> case only that map source will be consulted.

This is how I thought that it was supposed to work as well.

It would seem to be the right way and I suspect, should not prevent us from
using the Connectathon testsuite if we wish.  Even if if does, then we 
should
investigate to see why any failures might occur and either fix the testsuite
or make a better informed decision about the semantics of autofs at that 
time.

    Thanx...

       ps
