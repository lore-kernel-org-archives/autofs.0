From: Stef Bon <stef@bononline.nl>
Subject: Returning issues.
Date: Sun, 05 Jun 2011 19:01:04 +0200
Message-ID: <4DEBB650.8030207@bononline.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

  hi,

I see that issues that automounter doing unnecessary mounting like:

http://linux.kernel.org/pipermail/autofs/2011-May/006568.html

and here

http://linux.kernel.org/pipermail/autofs/2011-April/006542.html

some more documentation here would prevent users asking the
same questions.

This behaviour is mostly caused by:

A.

ls is a alias (in de shell) to ls --color=auto

which will follow targets, and this makes the automounter mount.

B.


extended attributes called by the environment, or an app.

I see here a sollution is proposed to fix this in coreutils and the acl 
package. Hmm, is this right?

If an app wants to get the xattr of an autofs managed directory, what is 
the sollution proposed here then?
Can't an autofs managed directory have Xattr?? That does not sound right.

In my construction I'm blocking the xattr calls to autofs managed dirs, 
unless it's already mounted, and I consider this as an ugly hack.

Stef
