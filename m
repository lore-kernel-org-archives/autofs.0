From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Use of egrep without "|| true" in the init.d script
Date: Thu, 24 Feb 2005 14:18:44 +0100
Message-ID: <20050224131844.GA5150@uio.no>
Mime-Version: 1.0
Content-Disposition: inline
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
To: autofs@linux.kernel.org

Ian,

Would you like to take a look at
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=295480 ?

The problem looks real enough to me (although I don't see the specific
circumstances where it would break), and it should probably be fixed for
beta3.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
