From: Ian Kent <raven@themaw.net>
Subject: autofs4 patches for 2.6 kernel
Date: Wed, 7 Apr 2004 20:04:18 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404071952170.4948@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>


Hi all,

Some progress on getting the autofs4 patches into the kernel tree.

Could anyone that is able to test within a 2.6 envronment please test this 
as much as possible and feed back the results.

There are bound to be problems so it would be good to be pro-active.

Thanks in advance.

Ian

---------- Forwarded message ----------
Date: Tue, 6 Apr 2004 22:33:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-mm2


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm2/


- Merged up Ian Kent's autofs4 patches

snip ...

+0-autofs4-2.6.0-signal-20040405.patch
+1-autofs4-2.6.4-cleanup-20040405.patch
+2-autofs4-2.6.4-fill_super-20040405.patch
+3-autofs4-2.6.0-bkl-20040405.patch
+4-autofs4-2.6.0-expire-20040405.patch
+5-autofs4-2.6.0-readdir-20040405.patch
+6-autofs4-2.6.0-may_umount-20040405.patch
+7-autofs4-2.6.0-extra-20040405.patch

 autofs4 merge

snip (rest of message) ...
