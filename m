From: "Patel, Rahulkumar [NJ]" <rahul@lehman.com>
Subject: Autofs picking first server from the automounter map all the
 time
Date: Fri, 30 Apr 2004 15:19:30 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <D85B695BF793684EA72C8E481FB1D9A1225096@nycmgexm004.leh.lbcorp.lehman.com>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>

Hi,
I have following entry defined in the automounter map.
But, when I try to access it all the time it pick last server defined for
that mount.

perl -ro,soft,nosuid,noquota,intr server1:/vol/vol1/software/perl
server2:/vol/vol1/software/perl.


When I cd /home/perl --> All the time I connect to server2.

I am running autofs-3.1.7-21.

Does anyone has idea why this is happening ?

Thanks
Rahul

------------------------------------------------------------------------------
This message is intended only for the personal and confidential use of the
designated recipient(s) named above.  If you are not the intended recipient of
this message you are hereby notified that any review, dissemination,
distribution or copying of this message is strictly prohibited.  This
communication is for information purposes only and should not be regarded as
an offer to sell or as a solicitation of an offer to buy any financial
product, an official confirmation of any transaction, or as an official
statement of Lehman Brothers.  Email transmission cannot be guaranteed to be
secure or error-free.  Therefore, we do not represent that this information is
complete or accurate and it should not be relied upon as such.  All
information is subject to change without notice.
