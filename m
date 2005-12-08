From: Paul Raines <raines@nmr.mgh.harvard.edu>
Subject: disable-mount-locking patch
Date: Thu, 8 Dec 2005 10:00:00 -0500 (EST)
Message-ID: <Pine.LNX.4.62.0512080954130.22388@gate.nmr.mgh.harvard.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
ReSent-To: autofs@linux.kernel.org
ReSent-Message-ID: <Pine.LNX.4.62.0512081005450.22388@gate.nmr.mgh.harvard.edu>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org


Where can I get the disable-mount-locking patch for 4.1.4?  And
the patch for mount?

The locking is an absolute killer for me.  One user on a big interactive 
server accessing a mount on a down box causes every other user accessing 
perfectly valid mounts to have their accesses fail (giving the aquire_lock 
error in the log) while the first mount takes forever to timeout.

I have very simple though very large mount maps.  No nesting.


-- 
---------------------------------------------------------------
Paul Raines                email: raines at nmr.mgh.harvard.edu
MGH/MIT/HMS Athinoula A. Martinos Center for Biomedical Imaging
149 (2301) 13th Street     Charlestown, MA 02129	    USA
