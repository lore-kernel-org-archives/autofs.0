From: David Howells <dhowells@redhat.com>
Subject: Bug in autofs4_d_automount()?
Date: Sat, 18 Jun 2011 00:29:48 +0100
Message-ID: <32229.1308353388@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: raven@themaw.net
Cc: dhowells@redhat.com, autofs@linux.kernel.org, viro@ZenIV.linux.org.uk


Hi Ian,

At the top of autofs4_d_automount() you have:

	/* The daemon never triggers a mount. */
	if (autofs4_oz_mode(sbi))
		return NULL;

I think this should be returning -EISDIR.  If by some chance we do get here in
Oz mode, this will cause the kernel to just loop forever.  A return of NULL is
meant to indicate that you got a collision and that it should recheck the
mountpoint - but it does not advance path in follow_managed().

-EISDIR is the return to indicate this is to be treated as a normal directory.

David
