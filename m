From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: auto.net gets a key with a path under SLES9.
Date: Mon, 14 Nov 2005 15:56:09 -0500
Message-ID: <17272.63977.587380.139989@segfault.boston.redhat.com>
References: <4378ED9A.6090903@deragon.biz>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4378ED9A.6090903@deragon.biz>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Hans Deragon <hans@deragon.biz>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] auto.net gets a key with a path under SLES9.; Hans Deragon <hans@deragon.biz> adds:

hans> Greetings.  I compiled autofs 4.1.4 for SuSE Linux Enterprise Server
hans> 9 (SLES9). I did found a little problem with auto.net.  The original
hans> code has:

hans>    key=$1

hans>    However, under SLES9, in my network environment, $key can be of
hans> the form "server/something[/otherthing]*", which is wrong.  $key
hans> should only be a server name.  I fixed the problem with:

hans>    key=`echo $1 | perl -wp -e 's%^(\w+)(\/?.+)*$%$1%;'`

hans>    My fix removes any path after the server name.

hans>    Exactly why automount passes a server name containg some path is
hans> unclear for me.  But I wanted to report this here.  If other suffer
hans> from this, you might want to consider some fix like mine (maybe using
hans> sed which is more standard).

hans>    I have not experienced this under Fedora Core 4 (FC4).

Could you enable debugging and post the logs, here?  You can find
information on how to do that on my people page:

  http://people.redhat.com/jmoyer/

I'll note that this sounds like a kernel bug that was fixed a while back,
but that bug was thought to only trigger when ghosting was enabled.  Even
so, you may want to try something like the attached patch.

Thanks,

Jeff

--- linux-2.4.21/fs/autofs4/root.c.orig	2005-05-31 09:31:16.097321176 -0400
+++ linux-2.4.21/fs/autofs4/root.c	2005-05-31 09:31:19.816755736 -0400
@@ -301,7 +301,14 @@ static int try_to_fill_dentry(struct den
 
 		DPRINTK(("try_to_fill_entry: expire done status=%d\n", status));
 		
-		return 0;
+		/*
+		 * If the directory still exists the mount request must
+		 * continue otherwise it can't be followed at the right
+		 * time during the walk.
+		 */
+		status = d_invalidate(dentry);
+		if (status != -EBUSY)
+			return 0;
 	}
 
 	DPRINTK(("try_to_fill_entry: dentry=%p %.*s ino=%p\n", 
