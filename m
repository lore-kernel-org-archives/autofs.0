From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: HOST expansion with autofs+LDAP
Date: Fri, 22 May 2009 09:50:58 -0400
Message-ID: <x49d4a1kzzx.fsf@segfault.boston.devel.redhat.com>
References: <20090512154529.9FC3313ED0@wsnyder.org>
	<4A0A4BCC.4030702@themaw.net> <4A0A57E0.3010601@themaw.net>
	<20090521140333.A048214477@wsnyder.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090521140333.A048214477@wsnyder.org> (Wilson Snyder's message
	of "Thu, 21 May 2009 10:03:33 -0400 (EDT)")
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
To: Wilson Snyder <wsnyder@wsnyder.org>
Cc: autofs@linux.kernel.org, raven@themaw.net

wsnyder@wsnyder.org (Wilson Snyder) writes:

>>Ian Kent wrote:
>>> Wilson Snyder wrote:
>>>> I have a suse10.3 system which includes autofs-5.0.2-30.2
>>>>
>>>> I'd like an LDAP entry that makes an autofs mountpoint that
>>>> includes the local host's name.  If this wasn't under LDAP I
>>>> believe "/net/$HOST" would work - creating a
>>>> "/net/{name-of-hostname}" mountpoint.
>>>>
>>>> However, if I add a mountpoint with cn=$HOST
>>>>
>>>> cn=$HOST,nismapname=auto.net,dc=company,dc=com
>>>>
>>>> The automounter nicely makes a "/net/$HOST" mount -
>>>> *literally* /net/$HOST, that is it doesn't expand $HOST to
>>>> the hostname.
>>>>
>>>> Same thing if I use cn=${host}
>>>>
>>>> Any hints?  Thanks! 
>>> 
>>> Oddly enough I think that $HOST should be expanded but I have no idea
>>> how you think this is supposed to work because you haven't provided any
>>> information about the LDAP entry, other than the dn, or provided any
>>> debug log information.
>>
>>Sorry, that isn't correct.
>>Macro expansion is not done on keys and never has been.
>>
>>Which begs the question, is it sensible to do macro expansion on keys
>>from a map before trying to match them against the key string received
>>from the kernel for the lookup?
>
> I'm not sure if I'm decoding the question properly, but I
> suspect it's fast enough to expand on the fly, as that's
> more flexible, but either way works for my application since
> HOST is (well is generally) constant.
>
> Can you point me to the right place in t the 5.0.2 sources
> to patch this in? I see the expansion code in parse_mount
> but am not sure what the best place to call it from is.

Here's a general overview of how things work:

1) A process walks into an automount managed mountpoint and does a lookup
   of a directory, in your case, fully.qualified.domain.name.
2) The kernel passes this on to the automount daemon as a lookup of
   "fully.qualified.domain.name"
3) the automount daemon checks its maps for an entry with a key of
   "fully.qualified.domain.name"

So, the trick is figuring out how the automount daemon is supposed to
know that "fully.qualified.domain.name" belongs to your entry with
cn="$HOST".

You *could* enumerate the entire map on startup, and expand the $HOST in
the automounter's cache.  However, not all map sources support
enumeration (hesiod and program maps come to mind).  So, what do you do
in those cases?

Further, Ian mentioned that this is a catch 22.  You want to parse an
entry in the lookup phase.  The automounter is laid out in a bit of a
layered format:

daemon proper  |
-------------  |
lookup modules |  (looks up keys)
-------------  |
parse modules  |  (expands *entries*)
-------------  |
mount modules  V  (mounts expanded entry on dir named by key)

The flow is as the arrow indicates.  What you're asking for is parsing
in the lookup module.  (It's doable, of course, barring the problem that
it won't work for all map types.)

Now, backing up, here, why do you want to create a directory with the
local host's fqdn?  What are you really trying to do?  This goes back to
Ian's initial question, I guess.

Cheers,
Jeff
