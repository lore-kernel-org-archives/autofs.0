From: canon@nersc.gov
Subject: fsck and already mounted filesystems
Date: Mon, 24 May 2004 15:36:32 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200405242236.i4OMaWqR027104@pookie.nersc.gov>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org


Greetings,

We perform multiple mounts of local file systems for
use in a chroot environment.  It looks like this latest
autofs breaks this since the fsck fails.  The fix
would be to skip the fsck if the file system is already
mounted.  There is code in libext2fs that does this.
I can propose a patch if it would be helpful.

--Shane



------------------------------------------------------------------------
Shane Canon                             voice: 510-486-6981
PSDF Project Lead                       fax:   510-486-7520
National Energy Research Scientific
  Computing Center                       
1 Cyclotron Road Mailstop 943-256
Berkeley, CA 94720                      canon@nersc.gov
------------------------------------------------------------------------
