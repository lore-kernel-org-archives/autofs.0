From: "Kamil Kisiel" <kamil@kamilkisiel.net>
Subject: autofs expire_indirect errors in syslog
Date: Wed, 19 Mar 2008 22:15:09 -0700
Message-ID: <66d392400803192215p36cc021bv6bfae3c09e173602@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: autofs@linux.kernel.org

I'm using autofs to mount some NFS shares, but occasionally some of
the machines on the network get their syslog filling up with errors
like this:

Mar 19 21:11:05 <hostname> automount[6762]: expire_indirect: fstat
failed: Bad file descriptor
Mar 19 21:12:20 <hostname> automount[6762]: expire_indirect: fstat
failed: Bad file descriptor
Mar 19 21:13:35 <hostname> automount[6762]: expire_indirect: fstat
failed: Bad file descriptor

Any suggestions as to why this might be, or steps to take to debug?
-- 
Kamil
