From: Jason L Tibbitts III <tibbs@math.uh.edu>
Subject: Re: LDAP questions
Date: Mon, 18 Apr 2005 08:37:02 -0500
Message-ID: <ufavf6kdx4x.fsf@epithumia.math.uh.edu>
References: <ufa8y3krl0t.fsf@epithumia.math.uh.edu>
	<Pine.LNX.4.62.0504161253520.8246@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504161253520.8246@donald.themaw.net>
	(raven@themaw.net's
	message of "Sat, 16 Apr 2005 13:08:36 +0800 (WST)")
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

>>>>> "r" == raven  <raven@themaw.net> writes:

r> But the logic is fairly simple in the sense that autofs will only
r> update it's map when it attempts a mount.

I understand.  As I understand things, fresh data will be fetched if
it attempts a mount from cached data which fails.  The most
significant implication of this is that you cannot smoothly migrate
from one server to another by making a copy and then changing the LDAP
map; the clients won't stop using the old server as long as they can
still mount from it.

Not a big deal as long as you know about it.

r> I'm afraid you'll have to wait for the LDAP patches to be merged.

No problem.  I'm always happy to test things out; are these patches
available anywhere?

 - J<
