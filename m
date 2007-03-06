From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: direct mount from NFS-mounted directories issue
Date: Tue, 06 Mar 2007 14:06:54 +0100
Message-ID: <45ED676E.8020904@inria.fr>
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

A direct mount which mount point is itself located on a NFS mount
does'nt work, with the following error message on launch:
Mar  6 14:05:21 stalingrad automount[23355]: do_mount_autofs_direct:
failed to create mount directory /home/members/rousse/test

From the mandriva user that reported this issue, it worked with previous
release. Full story at http://qa.mandriva.com/show_bug.cgi?id=28646
