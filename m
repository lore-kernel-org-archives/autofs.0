From: Jeff Moyer <jmoyer@redhat.com>
Subject: autofs-4.1.2-6 test rpms available
Date: Thu, 6 May 2004 17:18:28 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16538.43940.58650.642984@segfault.boston.redhat.com>
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

Here is the changelog for the latest version.  It includes Ian's latest
replicated server patches, my yperror patch, and an init script patch to
make option parsing more pedantic.  Available at:
     http://people.redhat.com/~jmoyer/

-Jeff

Changelog:
* Thu May  6 2004   - 1:4.1.2-6
- The lookup_yp module only dealt with YPERR_KEY, all other errors were
  treated as success.  As a result, if the ypdomain was not bound, the
  subprocess that starts mounts would SIGSEGV.  This is now fixed.
- Option parsing in the init script was not precise enough, sometimes matching
  filesystem options to one of --ghost, --timeout, --verbose, or --debug.
  The option-parsing patch addresses this issue by making the regexp's much
  more precise.
- Ian has rolled a third version of the replicated mount fixes.
