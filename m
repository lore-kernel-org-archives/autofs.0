From: Jeff Moyer <jmoyer@redhat.com>
Subject: [announce] autofs-4.1.4-4 FC4 packages available
Date: Thu, 14 Apr 2005 08:13:51 -0400
Message-ID: <16990.24191.475851.544067@segfault.boston.redhat.com>
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hello,

I put together a test rpm for fc4 based on the 4.1.4 release of autofs.
You can find it here:

  http://people.redhat.com/jmoyer/autofs/fc4/autofs-4.1.4-4/

For those of you who would like to try it but are not running fc4, the srpm
is located in the SRPMS directory at the url above.  I've done some basic
functionality tests, but haven't run through a full regression.  As such,
consider this a beta pacakge (i.e. don't throw this into production just
yet!).  I put in a workaround for the multimount issue reported yesterday.

Ian, thanks for all of the hard work in putting this together.  I managed
to remove 50+ patches from our RPM!

-Jeff
