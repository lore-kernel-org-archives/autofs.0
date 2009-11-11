From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] make documentation for set-log-priority clearer
Date: Wed, 11 Nov 2009 12:08:56 -0500
Message-ID: <x49eio5ouon.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi,

It is not apparent from the documentation of the --set-log-priority
option that the option can be used to change the log priority of the
damon while it is running.  This patch tries to fix that.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/man/automount.8 b/man/automount.8
index 9fcaaf4..d9a45c2 100644
--- a/man/automount.8
+++ b/man/automount.8
@@ -77,7 +77,9 @@ changes. For example, if verbose logging is set in the configuration then
 attempting to set logging to basic logging, by using alert, crit, err
 or emerg won't stop the verbose logging. However, setting logging to debug
 will lead to everything (debug logging) being logged witch can then also
-be disabled, returning the daemon to verbose logging.
+be disabled, returning the daemon to verbose logging. This option can be
+specified to change the logging priority of an already running automount
+process.
 .P
 The \fIpath\fP argument corresponds to the automounted
 path name as specified in the master map.
