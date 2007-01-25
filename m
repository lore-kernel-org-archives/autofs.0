From: Ian Kent <raven@themaw.net>
Subject: Re: autofs v5: Problem with @network in access_lists
Date: Thu, 25 Jan 2007 16:37:49 +0900
Message-ID: <1169710669.8575.5.camel@raven>
References: <6a5354cc0701241113x60461168p19f83943d7da6ff9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <6a5354cc0701241113x60461168p19f83943d7da6ff9@mail.gmail.com>
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
To: Bill Maloy <bill.maloy@gmail.com>
Cc: autofs@linux.kernel.org

On Wed, 2007-01-24 at 13:13 -0600, Bill Maloy wrote:
> Solaris NFS servers can be configured to use a network
> specifier in the access_list of an NFS exported file
> system.
> 
> >From <http://docs.sun.com/app/docs/doc/816-0211/6m6nc676n?a=view>
> "The network or subnet component is preceded by an at-sign (@). "

*Sigh*
I missed that as well when I updated to account for the Solaris export
semantics.

> 
> This feature does not play nicely with autofs-5.0.1-rc3.
> 
> In the host_match() function within lib/rpc_subs.c, the
> initial character of the formal parameter named "pattern"
> is compared against '@' ... indicating a need to check
> the NFS client's hostname (myname) for membership
> in the given netgroup.
> 
> However, the existing "if/else-if" logic does not
> consider the case where a network address (and mask)
> follows the '@' character -- instead of an "expected"
> netgroup name.

That's right.

> 
> You can confirm this behavior by modifying the access
> control list of a working v5 automounting export
> (containing an @netgroup specification) to have
> a Solaris-like @network/mask specifier, instead.

Don't need to confirm it, that is the way it works atm.

> 
> The fix?  Well, if the innetgr() function supported
> "IPaddress/mask"-style strings in addition to netgroup
> names, the code as written would probably support
> access_lists containing network components.

That's not going to happen.

> 
> Until that day, the character following the '@' sign
> in an exports list item could be examined.  If numeric,
> the masked_match() logic of the 'else' branch could
> be used.  If non-numeric, the existing innetgr()
> logic would be used.

Something like that, I'll have a look.

> 
> This might beg for the inet_aton() logic to be
> made into a function call, since it would be
> potentially executed in the "if (*m_pattern == '@')"
> branch as well as in the else branch.

Yes, I need to separate that anyway to make IPv6 conversion simpler when
it's needed.

> 
> I didn't feel comfortable submitting such a patch,
> since I've only just recently started looking at
> the automounter v5 source code (guess why), and
> wasn't completely sure that my analysis was correct.

Yep. You're right.

Ian
