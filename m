From: chris barry <Christopher.Barry@qlogic.com>
Subject: simple automount question
Date: Sun, 02 Mar 2008 23:17:06 -0500
Message-ID: <1204517826.5312.62.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs mailing list <autofs@linux.kernel.org>

I've googled, but have not found an answer to this seemingly simple
question.

I'm automounting /foo from box1 on box2. /foo has no files, just other
directories, one of which is bar.

box2 $ cd /foo
box2 $ ls
box2 $ (nothing shows up)
box2 $ cd bar
box2 $ cd ..
box2 $ ls
bar
box2 $


Q: how do I get all of the directories under /foo to show up after it's
automounted?

/etc/auto.master
/foo	/etc/auto.foo --timeout=60

/etc/auto.foo
(all on one line)
*              /
-fstype=nfs,rsize=32768,wsize=32768,tcp,rw,bg,hard,intr,noacl,nocto,async   10.20.30.40:/foo/&

Is my auto.foo wrong for this application?


Thanks,
-C
