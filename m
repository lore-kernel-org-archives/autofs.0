From: wengang wang <wen.gang.wang@oracle.com>
Subject: first access fails with ENOENT after autofs started
Date: Tue, 29 Jan 2008 17:36:08 +0800
Message-ID: <479EF388.5080805@oracle.com>
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

Hi experts,

In RHEL kernel 2.6.18-53 and mainline kernel 2.6.24,
in function autofs4_lookup() in fs/autofs4/root.c,
if dentry is not found in function autofs4_lookup_unhashed(),
a d_instantiate() is done on the dentry passed as parameter instead of 
d_add().

seems this cause a problem that the first access just after autofs 
started to
/path/to/<autofsMountPoint>/<nfsMountPoint> fail with the error ENOENT.

If I rolled back to use d_add(), there is no such problem.
Is this a bug or I omitted something?

thanks,
wengang.
