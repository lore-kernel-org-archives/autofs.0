From: Paul Raines <raines@nmr.mgh.harvard.edu>
Subject: Handling mount attempts to down NFS servers
Date: Tue, 11 Jan 2011 12:51:08 -0500 (EST)
Message-ID: <Pine.LNX.4.62.1101111244350.5250@gate.nmr.mgh.harvard.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org


I found many users asking this on google search, but no solutions.

Is there a way to make the '/bin/mount -t nfs' calls autofs makes
timeout faster when the server being accessed is down?

Barring that, is there a way to make it such that when there is
'/bin/mount -t nfs' attempt going on that is hung, other mount attempts
to perfectly working servers during that time do not also hang?
This is what is really a killer.

One thought I had is to add 'bg' to the mount options in the map files
but I am scared that might cause 100s of hung mount attempts to pile up.

I am using a mix of CentOS4.8 (autofs-4.1.4-2) and CentOS5.5
(autofs-5.0.1-0.rc2.143.el5_5.6) boxes.


-- 
---------------------------------------------------------------
Paul Raines                email: raines at nmr.mgh.harvard.edu
MGH/MIT/HMS Athinoula A. Martinos Center for Biomedical Imaging
149 (2301) 13th Street     Charlestown, MA 02129	    USA




The information in this e-mail is intended only for the person to whom it is
addressed. If you believe this e-mail was sent to you in error and the e-mail
contains patient information, please contact the Partners Compliance HelpLine at
http://www.partners.org/complianceline . If the e-mail was sent to you in error
but does not contain patient information, please contact the sender and properly
dispose of the e-mail.
