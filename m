From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Fri, 2 Dec 2005 11:04:28 -0500
Message-ID: <17296.28812.390586.101214@segfault.boston.redhat.com>
References: <20051116101740.GA9551@RAM>
	<17292.64892.680738.833917@segfault.boston.redhat.com>
	<1133315771.8978.65.camel@lade.trondhjem.org>
	<438E0C66.6040607@us.ibm.com>
	<1133384015.8974.35.camel@lade.trondhjem.org>
	<438E1A05.7000308@us.ibm.com>
	<Pine.LNX.4.63.0512011917010.3189@donald.themaw.net>
	<438F251B.7060602@us.ibm.com>
	<Pine.LNX.4.63.0512022059350.2070@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0512022059350.2070@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: "William H. Taber" <wtaber@us.ibm.com>, Trond Myklebust <trond.myklebust@fys.uio.no>, Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

==> Regarding Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix; Ian Kent <raven@themaw.net> adds:

raven> On Thu, 1 Dec 2005, William H. Taber wrote:
>> > So the question is, can anyone provide an example of a path that, upon
>> > calling autofs revalidate or lookup with the i_sem held, not be the
>> path > that aquired it?

raven> So still no counter example!

>> Any other process calling lookup_one_len on a file in /net.

raven> I'm afraid this is not an example it's an assertion.  "Any other
raven> process" is a little broad I think.  You'll need to be more
raven> specific.

Well, I think we've determined that the reported problem doesn't happen
with any in-tree callers.  The question, then, is do you want to fix the
locking problem?  Two approaches were presented in this thread.  I don't
really like the idea of the hack used by devfs, since it relies on implicit
semantics.  I haven't given much thought to the second approach, though
(are we sure it can be made to work?).  It may require a good deal of
effort, but if it makes things work properly, it's worth considering.  I'm
just not sure where it sits in the list of priorities, as I know you've got
a lot on your plate, Ian.

-Jeff
