From: peter.a.harris@exgate.tek.com
Subject: RE: unacceptable bug in autofs kernel module
Date: Fri, 4 Feb 2005 14:34:43 -0800
Message-ID: <C147DE5CF1A13D42B560879D6D212E63D094BC@us-bv-m21.global.tektronix.net>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Charles.Lever@netapp.com, jmoyer@redhat.com
Cc: autofs@linux.kernel.org, mmarion@qualcomm.com

We are running 6.5.3.


Pete Harris                      
Tektronix, Inc. / Technical Computing
MS 39-325 / PO BOX 500 / BEAVERTON OR 97077-0500
Ph: 1-503-627-3989 / Fax: 1-503-627-5587
PGP: 0xD1F493F6      EA9E 25B8 EF02 3EBD 26CB 7E28 026E 74DB D1F4 93F6
----------------------------------------------------------------------
--          Any opinions expressed are those of the author          --
--               and may not represent Tektronix, Inc.              --

=-----Original Message-----
=From: Lever, Charles [mailto:Charles.Lever@netapp.com]
=Sent: Friday, February 04, 2005 11:11 AM
=To: Harris, Peter A; Jeff Moyer
=Cc: mmarion@qualcomm.com; autofs@linux.kernel.org
=Subject: RE: [autofs] unacceptable bug in autofs kernel module
=
=This sounds a lot like the mount command is not retrying a mount when it
=gets a timed out RPC.  Networking problems or an overloaded mountd on
=the server would both be reasons for an RPC timeout during a mount.
=
=Jeff, is the mount patch we worked on last summer available for RHEL 3,
=or is it just a RHEL AS 2.1 fix at this point?
=
=Peter, what release of Data ONTAP is running on the filer(s)?
=
<Snip>
