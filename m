From: "Gordon Lack" <gml4410@ggr.co.uk>
Subject: Bug in autofs v4.1.4 init.d script for reload (and fix)
Date: Tue, 12 Sep 2006 13:58:06 +0100
Message-ID: <4506AEDE.6B8D5E65@ggr.co.uk>
References: <44AE7785.74E63D70@ggr.co.uk> <44EB1231.7ABAA89B@ggr.co.uk>
	<45015498.22A9C700@ggr.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: autofs@linux.kernel.org

   The init.d script when asked to reload compares the list of required
mount commands (in TMP1) against the list of currently-running automount
processes (in TMP2).

   However, automount fork()s as it runs, so the process list in TMP2
will, potentially, contain these child processes.  The result of this is
(conter-intuitively) that thescript tries to start *another* process. 
(The reason is that when you grep TMP2 for the mountpoint of the TMP1
entry you get 2 lines, which doesn't match the one line, so the code
thinks it isn't there).

   There is a simple fix for this - change the process-finding command
to include the ppid (using Unix, rather than BSD options) and only
select the lines with ppid==1.

   ie: replace:

        ps axwww|grep "[0-9]:[0-9][0-9] $DAEMON " | (
            while read pid tt stat time command; do

 with

# Remove duplicates (which happen transiently on fork()ing?)
# Only need the pid, but also match against ppid, so we only get
# "parent" automount processes not forked ones.
# (The [1] in the grep is so that the grep command doesn't match)
#
        ps -e -opid=,ppid=,command= | grep " [1] $DAEMON " | (
            while read pid ppid command; do
