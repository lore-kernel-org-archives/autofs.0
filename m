From: raven@themaw.net
Subject: Re: LDAP questions
Date: Sat, 16 Apr 2005 13:08:36 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504161253520.8246@donald.themaw.net>
References: <ufa8y3krl0t.fsf@epithumia.math.uh.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <ufa8y3krl0t.fsf@epithumia.math.uh.edu>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jason L Tibbitts III <tibbs@math.uh.edu>
Cc: autofs@linux.kernel.org

On Fri, 15 Apr 2005, Jason L Tibbitts III wrote:

> I'm trying to migrate towards LDAP and away from homebrew map
> distribution.  My test setup is running FC3, autofs-4.1.3-114.  So far
> I've been successful, but I have a couple of questions.  I apologize
> for the length of this but I think these are mostly related.
>
> Is there any documentation on how mount entries retrieved from LDAP
> are cached?  I'm seeing entries sticking around long after they've
> been deleted from the map and I'm wondering if there's any timeout for
> positive hits.  I'm also not seeing any type of negative caching.

No.

But the logic is fairly simple in the sense that autofs will only update 
it's map when it attempts a mount.

When this was implemented an additional requested feature was to add a map 
refresh timeout. I've resisted that so far as the code was complicated 
enough already. Also, there are a couple of pending patches for the LDAP 
module. Once these have been merged and the code stabilised I'll consider 
adding the refresh. This is likey to take quite a while as there's already 
heaps to do.

>
> I noticed that I see a lot of messages like this one, accessing /home/mike:
>
> lookup(ldap): got answer, but no first entry for (&(objectclass=automount)(cn=mike))
>
> I'm using the NIS schema, not the automount schema.  The LDAP server
> shows these searches:
>
> SRCH base="nisMapName=auto.home,dc=math,dc=uh,dc=edu" scope=2 deref=0
> filter="(&(objectClass=nisObject)(cn=mike))"
> SRCH attr=cn nisMapEntry
> SEARCH RESULT tag=101 err=0 nentries=1 text=
>
> SRCH base="nisMapName=auto.home,dc=math,dc=uh,dc=edu" scope=2 deref=0 filter="(&(?=undefined)(cn=mike))"
> SRCH attr=cn automountInformation
> SEARCH RESULT tag=101 err=0 nentries=0 text=
>
> Note how the first search returns an entry.  Should I just ignore
> these log messages, or can I turn off use of the automount schema
> somehow?  (The master map is in LDAP too, so theoretically the daemon
> should be able to figure out which schema I'm using when it starts up
> and could stick to it.)

You're seeing symtoms of one of the problems that the above LDAP patches 
address.

The map update implementation still needs work in this respect as it looks 
to both schema unconditionally. Unfortuneately I was more focused on the 
map update problem than rationalising the LDAP code at the time.

Sorry about that. I know about it and it's being worked on.

>
> I noticed that running "man" takes ages now.  The default manpath for
> some reason has a bunch of references to points under /usr/local,
> which so happens to be managed by autofs.  Each time man tries to stat
> one of these paths, it takes about a second.  From strace -r:
>
> 0.000068 stat64("/usr/local/share/man/en_US.UTF-8", 0xbfff947c) = -1 ENOENT (No such file or directory)
> 0.921225 stat64("/usr/local/share/man/en", 0xbfff947c) = -1 ENOENT (No such file or directory)
> 1.001739 stat64("/usr/local/share/man", 0xbfff94ac) = -1 ENOENT (No such file or directory)
> 1.082108 stat64("/usr/kerberos/bin/man", 0xbfffb52c) = -1 ENOENT (No such file or directory)
> 0.000074 stat64("/usr/kerberos/bin/MAN", 0xbfffb52c) = -1 ENOENT (No such file or directory)
>
> So each time /usr/local/share/man or something under it is referenced,
> there is a one second pause and for each pause the following two lines
> are logged:
>
> lookup(ldap): got answer, but no first entry for (&(objectclass=nisObject)(cn=/))
> lookup(ldap): got answer, but no first entry for (&(objectclass=automount)(cn=/))
>
> I don't believe that the delay is coming from the LDAP server.  It's
> logs only have single second resolution, but the BIND, SRCH and SEARCH
> RESULT lines generally all happen within the same second.

No I don't think it's your LDAP server either.
It's likey due to the additional searches being done for schema entries 
your not using.

>
> Any hints or pointers would be appreciated.

I'm afraid you'll have to wait for the LDAP patches to be merged.

Ian
