From: Ian Kent <raven@themaw.net>
Subject: Re: LDAP questions
Date: Tue, 19 Apr 2005 14:32:53 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504191429330.17350@wombat.indigo.net.au>
References: <ufa8y3krl0t.fsf@epithumia.math.uh.edu>
	<Pine.LNX.4.62.0504161253520.8246@donald.themaw.net>
	<ufavf6kdx4x.fsf@epithumia.math.uh.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <ufavf6kdx4x.fsf@epithumia.math.uh.edu>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason L Tibbitts III <tibbs@math.uh.edu>
Cc: autofs@linux.kernel.org

On Mon, 18 Apr 2005, Jason L Tibbitts III wrote:

> >>>>> "r" == raven  <raven@themaw.net> writes:
> 
> r> But the logic is fairly simple in the sense that autofs will only
> r> update it's map when it attempts a mount.
> 
> I understand.  As I understand things, fresh data will be fetched if
> it attempts a mount from cached data which fails.  The most
> significant implication of this is that you cannot smoothly migrate
> from one server to another by making a copy and then changing the LDAP
> map; the clients won't stop using the old server as long as they can
> still mount from it.

You can send a HUP signal to the daemon to force a map re-read as well.

> 
> Not a big deal as long as you know about it.
> 
> r> I'm afraid you'll have to wait for the LDAP patches to be merged.
> 
> No problem.  I'm always happy to test things out; are these patches
> available anywhere?

They've been posted to the list but I've not had a chance to look at them 
yet. There are a couple of LDAP requests (and associated patches).

Ian
