From: "Paul B. Henson" <henson@acm.org>
Subject: error returned upon mount failure
Date: Tue, 8 Apr 2008 19:36:36 -0700 (PDT)
Message-ID: <Pine.GSO.4.55.0804081730320.21655@loogie.intranet.csupomona.edu>
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
To: autofs@linux.kernel.org


I was working with automount 5 on a fairly recent 2.6.23 kernel, and got
the following error when trying to access an automounted directory:

gentoo ~ # ls /user/henson
ls: cannot access /user/henson: No such file or directory


The directory did exist, and the automounter configuration was correct,
but the actual mount failed:

gentoo ~ # mount -t nfs4 -o sec=krb5i zfs1:/export/user/henson /mnt
mount.nfs4: Permission denied


On a Solaris 10 system, attempting to access the same directory gave a more
appropriate error message:

root@s10 ~ # ls /user/henson
/user/henson: Permission denied

root@s10 ~ # mount -o vers=4 zfs1:/export/user/henson /mnt
nfs mount: mount: /mnt: Permission denied


Would it be possible to have the Linux automounter give a more accurate
error message for this case?


-- 
Paul B. Henson  |  (909) 979-6361  |  http://www.csupomona.edu/~henson/
Operating Systems and Network Analyst  |  henson@csupomona.edu
California State Polytechnic University  |  Pomona CA 91768
