From: Ian Kent <raven@themaw.net>
Subject: Re: Ubuntu NFS automount problem
Date: Tue, 25 Nov 2008 02:43:52 +0900
Message-ID: <1227548632.2913.33.camel@zeus.themaw.net>
References: <4928BFA4.2090805@sun.com>
	<1227499728.2913.0.camel@zeus.themaw.net> <492A56E6.1070603@sun.com>
	<492ACF74.6000703@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <492ACF74.6000703@sun.com>
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
To: Bill Shannon <bill.shannon@sun.com>
Cc: autofs@linux.kernel.org

On Mon, 2008-11-24 at 07:59 -0800, Bill Shannon wrote:
> Bill Shannon wrote:
> >>> # cat /etc/auto.net
> >>> *    -rw,intr    &:/
> >>
> >> How is do you expect this to work, explain?
> 
> Ok, maybe the question you meant to ask is "how is the above entry
> supposed to achieve the effect you desire".
> 
> That's a good question.

And the answer is "it doesn't".
At least not on Solaris 9 or Linux.
I don't know about OpenSolaris or Solaris 10.

The reason I was confused is because of the internal contradictions in
you original two postings.

But, if you could have described the semantic rules which allowed that
apparent contradiction work the way you described then I would have been
happy to listen.

> 
> Going back to Solaris, I see that /net is handled by a special
> auto.master entry:
> 
> /net	-hosts	-nosuid
> 
> I'd forgotten all about that.
> 
> I just tried that on Linux with autofs and it doesn't seem to work.
> Is there a Linux equivalent for the "-hosts" pseudo-map on Solaris?

Yes, with autofs version 4 use "/net /etc/auto.net" in the master map
which generally should work the way you expect. The internal hosts map
is available in autofs version 5, which I suspect may be called autofs5
in ubuntu.

> 
> I'm having the same problem with the corresponding entry in my
> my auto.home map.  I guess exporting each individual home directory
> from zfs isn't going to work the same way exporting the entire /export/home
> directory works.  I guess I'll have to find a better way to handle that...

I don't know how zfs may change any of this either.

A wildcard map for an indirect map, which home directories usually are,
might be:

*	<home directory server>:/<home directory base directory>/&
