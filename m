From: rsmits-l <rsmits-l@tudelft.nl>
Subject: Re: Problem with autofs and ldap
Date: Tue, 21 Oct 2014 15:27:50 +0200
Message-ID: <54465F56.8060701@tudelft.nl>
References: <543E6912.8050109@tudelft.nl> <5440D89C.6040001@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <5440D89C.6040001@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

On 10/17/2014 10:51 AM, Ian Kent wrote:
> On 15/10/14 20:31, rsmits-l wrote:
>> Hello,
>>
>> I have a very weird issue that maybe someone sounds familiar. I have
>> placed our automount entry's in our Active Directory / LDAP. Problem is
>> that is it not stable. After a restart of autofs I sometimes only see
>> half of our map entry's. Sometimes 75 %.
>
> That's odd if the map is actually being read, yes.
> At one time autofs didn't do paged ldap reads so AD would only send one
> page which meant not all the entries would be read for larger maps.
>

Yes, the paged ldap story crossed my screen when I was googling for this 
problem.

>>
>> When I do a autofs reload maybe 90 % of the time I see all entry's. I am
>> having this issue on Redhat 6 and Suse 11. Strange thing is that the
>> autofs logging (debug) shows always all the entry's but are not
>> reflected in the filesystem structure.
>
> I can't remember now what gets logged for the ldap map reads so how have
> you established the read gets all the entries (and what rel6 version of
> autofs are you using)?

The read gets all the entry's but just doesn't show it in the directory 
structure. I am having this issue on Redhat 6.5 (autofs 5.0.5-89)

On Suse Enterprise Desktop 11.3 : (autofs-5.0.6-3.10.16.1)

>
>>
>> This is my config :
>>
>> /etc/sysconfig/autofs
>> ----
>> LDAP_URI="ldap://srvxxx.domain.net/"
>> SEARCH_BASE="ou=LinuxAutoMount,ou=Resources,dc=domain,dc=net"
>> LDAP_TIMEOUT="100"
>> LDAP_NETWORK_TIMEOUT="100"
>> MAP_HASH_TABLE_SIZE=2048
>
> OK, so BROWSE_MODE isn't set so it = yes by default and you expect the
> mount point directories within what are probably indirect mounts to be
> created or removed, as the case may be, correct?
>
> But they aren't all being created (or removed)?

That's right.

>> /etc/nsswitch.conf
>> ----
>> automount: files ldap
>
> This might make a difference, depending on what file maps exist, but we
> would need a debug log and map examples to reproduce the problem.
>
> What about logging a bug against rhel-6 and working on it there.
>
> Ian

That's what I was thinking. This really looks like a bug. I will post my 
finding to you and the list when this is solved.

Greetings, Richard Smits.
