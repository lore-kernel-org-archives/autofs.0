From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Problem with init script and monolithic kernels
Date: Sat, 29 Jan 2005 18:40:31 +0100
Message-ID: <20050129174031.GB29464@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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

A Debian user complained about the line

  if lsmod | grep -q autofs[^4]

in the init.d script failing on monolithic kernels (lsmod outputs "lsmod:
QM_MODULES: Function not implemented" and fails with exit code 1, which makes
the entire init.d script stop due to set -e). Ian, could you change this to
something like this in time for 4.1.4?

  if ( [ -f /proc/modules ] && lsmod ) | grep -q autofs[^4]

I haven't been able to test it myself except on a module-enabled machine (I
have no machines without module support readily available), but it looks
quite straightforward to me and should fix the problem.

(Actually, the line reads elsif in our version, but that's a different story,
which we've discussed here briefly earlier :-) )

/* Steinar */
-- 
Homepage: http://www.sesse.net/
