From: "Murata, Dennis W (SAIC)" <muratadw@bp.com>
Subject: Multipliexing mounts
Date: Fri, 9 Sep 2005 15:50:50 -0500
Message-ID: <134FC8D9C1F126488E3D123A9B2607370A75992F@bp1houex002.bp1.ad.bp.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
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
To: autofs@linux.kernel.org

I recently had an applications trainer give a class on Konqueror.  During the class she went up a directory from $HOME.  Konqueror tried to automount 1321 home directories.  I did not count to see how many were mounted, but I was able to kill Konqueror.  The workstation did not lock up, but not all home directories were available.  Has the patch to multiplex mounts been applied to any autofs version?
We are running RHEL 3 update 3, with autofs-4.1.4-4 from jmoyer recompiled.  The users want the ghosting feature, so I don't want to disable it.
The home directories are automounted from a NetApp filer.

Wayne Murata  
