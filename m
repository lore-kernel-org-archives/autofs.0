From: Phil Dumont <phil@solidstatescientific.com>
Subject: Should stat(2)ing an automount mount point trigger the
	automount?
Date: Fri, 22 May 2009 13:42:49 -0400 (EDT)
Message-ID: <67349.32791243014169920.JavaMail.root@zimbra.solidstatescientific.com>
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

On a CentOS 5.4 installation, I ran this command:

find /net/fs/export/vtrak3b/keeper/

...and it yielded this message to stderr:

find: WARNING: Hard link count is wrong for /net/fs/export/vtrak3b/keeper/: this may be a bug in your filesystem driver. Automatically turning on find's -noleaf option. Earlier results may have failed to include directories that should have been searched. 

Apparently, as soon as you access /net/host, if host is exporting
any paths other than /, the automount daemon will create a mount
point /net/host/path/to/export for every path exported by host,
but doesn't actually mount anything until you read the
exported/automounted directory.  (The host 'fs' is exporting
/export/vtrak3b/keeper, along with some other non-root
directories.)

And it would seem that stat(2)ing the mount point does not
trigger the automount, so the stat(2) reports on the mount
point, not the directory that's going to be mounted there.

It would seem that find stat(2)s a directory before it opendir(3)s
it.  So the stat(2) of keeper saw a hard link count of 2 (which is
correct for the empty mount point), but when find started reading the
directory, that triggered the automount, and it was now accessing the
mounted directory instead of the mount point, and apparently noticed
the discrepancy.

I've already entered a bug report against find, requesting that
it open the directory before stat-ing it:

    http://savannah.gnu.org/bugs/?26641

But the bug might arguably be with automount.  Should a stat
of the mount point trigger the automount?

phil dumont
