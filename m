From: David Howells <dhowells@redhat.com>
Subject: autofs4_d_automount() can change path->dentry param
Date: Sat, 15 Jan 2011 11:11:02 +0000
Message-ID: <18985.1295089862@redhat.com>
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
To: raven@themaw.net, viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, autofs@linux.kernel.org


Hi Ian,

I've just noticed that autofs4_d_automount() can change the dentry pointer in
the path parameter (via autofs4_mountpoint_changed()).  Is this just doing a
straight substitution of one dentry for its equivalent?  I don't think it'll
be a problem for follow_automount() and follow_managed(), provided the dentry
stays in the same namespace - but if we eliminate the vfsmount pointer and
just pass the dentry pointer in to d_automount(), you won't be able to do this
anymore.  Would it work to simply return NULL here and hope the recheck picks
up the substitution?

David
