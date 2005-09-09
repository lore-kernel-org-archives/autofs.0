From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Multipliexing mounts
Date: Fri, 9 Sep 2005 17:46:46 -0400
Message-ID: <17186.710.592680.252024@segfault.boston.redhat.com>
References: <134FC8D9C1F126488E3D123A9B2607370A75992F@bp1houex002.bp1.ad.bp.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <134FC8D9C1F126488E3D123A9B2607370A75992F@bp1houex002.bp1.ad.bp.com>
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
To: "Murata, Dennis W (SAIC)" <muratadw@bp.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] Multipliexing mounts; "Murata, Dennis W (SAIC)" <muratadw@bp.com> adds:

muratadw> I recently had an applications trainer give a class on Konqueror.
muratadw> During the class she went up a directory from $HOME.  Konqueror
muratadw> tried to automount 1321 home directories.  I did not count to see
muratadw> how many were mounted, but I was able to kill Konqueror.  The
muratadw> workstation did not lock up, but not all home directories were
muratadw> available.  Has the patch to multiplex mounts been applied to any
muratadw> autofs version?  We are running RHEL 3 update 3, with
muratadw> autofs-4.1.4-4 from jmoyer recompiled.  The users want the
muratadw> ghosting feature, so I don't want to disable it.  The home
muratadw> directories are automounted from a NetApp filer.

Multiplexing of connections would be an NFS feature, not autofs.  As far as
I know, there are no "productized" versions of that feature.  This is in
the works, though.  You might try asking on the nfs list for more details.

-Jeff
