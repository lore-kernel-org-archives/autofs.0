From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: automount does not close file descriptors at start
Date: Wed, 16 Feb 2005 13:53:50 +0100
Message-ID: <20050216125350.GA6031@uio.no>
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

Hi,

My latest autofs package for Debian (4.1.3+4.1.4beta2-1) had problems
installing, freezing after install; I've worked around this now
(4.1.3+4.1.4beta2-2 is on its way up to the archive), but I've been told this
is really a bug in automount. What I've been told is along the lines of:

"Any daemon going into the background should close all file descriptors from
zero up to MAXFDS minus the ones it actually wants to have open."

In other words, one should probably have a for loop of sorts in
become_daemon().

/* Steinar */
-- 
Homepage: http://www.sesse.net/
