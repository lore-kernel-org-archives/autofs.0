From: Peter <Sheldon@hera.kernel.org>
Subject: fstab
Date: Sun, 3 May 2009 18:14:37 +0200
Message-ID: <20090503181437.91f3a3c2.Sheldon@peters.home>
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


I can't find any reference to a network share (nfs) can or can not be present in fstab. My problem is SLOCATE doesn't like Autofs and ignores my nfs share when I run updatedb. Using nfs in a "normal" fashion from fstab slocate works. Looks like Autofs ignore has been hardcoded because removing autofs from updatedb.conf makes no difference. I keep my file storage server down and bring it up when needed. Autofs works like a charm, nfs via fstab doesn't. If I put in a line in fstab noauto with the nfs share will KDE or AUTOFS have problems? I am on Gentoo.
thanks
regards
peter

-- 
Peter <Sheldon>
