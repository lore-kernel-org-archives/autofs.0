From: Jeff Moyer <jmoyer@redhat.com>
Subject: new autofs test rpm available
Date: Tue, 24 Aug 2004 14:56:30 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16683.36702.305349.678017@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
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
To: autofs@linux.kernel.org

I've rolled another rpm with Ian's latest map expiry changes.  All of the
same rules still apply: could break things horribly, needs the kernel
patch.  I also included the socket descriptor leak fix in this next
version, which is 4.1.3-16.  Available in the usual place:
	 http://people.redhat.com/~jmoyer/

Happy testing.

-Jeff
