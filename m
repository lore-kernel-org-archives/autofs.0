From: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Subject: How does autofs know when the maps have changed?
Date: Wed, 2 Jan 2008 07:12:51 +0900
Message-ID: <BAC1D28A5AB852439A6914CA7AB4E63F0519299F@permls05.wde.woodside.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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


Hi all

We have a mix of Linux and Solaris workstations and servers.  In Solaris
land, an 'automount -v' is run nightly to pickup any changes to the
automount maps.  Is this required with the autofs distributed by RedHat?
Does autofs do any checking to see if the map has changed? We're running
RedHat EL 3, 4 and 5, (mostly) fully patched.

Thanks

CC


NOTICE: This email and any attachments are confidential. 
They may contain legally privileged information or 
copyright material. You must not read, copy, use or 
disclose them without authorisation. If you are not an 
intended recipient, please contact us at once by return 
email and then delete both messages and all attachments.
