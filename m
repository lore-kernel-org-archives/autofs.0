From: Jeff Moyer <jmoyer@redhat.com>
Subject: [rft] New autofs rpm available for testing
Date: Fri, 14 Jan 2005 16:23:02 -0500
Message-ID: <16872.14390.835831.995533@segfault.boston.redhat.com>
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

This RPM catches up on most of the changes that have been going in of late.
Attached is the most recent part of the changelog.  You can find the RPMs
by following the Fedora Core 4 link on the following page:

   http://people.redhat.com/jmoyer/

The version is 4.1.3-76, and requires a kernel patch for 2.4 based
systems.  The current FC3 and FC4 kernels already have the patch applied.

This version does contain Ian's map update patch.

Happy testing.

-Jeff

(the changelog is cobbled together from multiple branches, so may be a bit
out of order)

* Tue Jan 11 2005 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-76
- Fix the large program map patch.

* Tue Jan 11 2005 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-75
- Fix some merging breakages that caused the package not to build.

* Thu Jan  6 2005  <jmoyer@redhat.com> - 1:4.1.3-74
- Add in the map expiry patch
- Bring in other patches that have been committed to other branches. This 
  version should now contain all fixes we have to date
- Merge conflicts due to map expiry changes

* Tue Dec  7 2004 Chris Feist <cfeist@redhat.com> - 1:4.1.3-67
- Fixed an error which would cause autofs to attempt to use an
  uninitialized pointer and segfault.  (bz #137220)
- Fixed segfault when LDAP_SIZELIMIT_EXCEEDED is called and --ghost
  is used, addresses  bz #137220.

* Tue Dec  7 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-65
- Fix truncation of large program maps.  bz #138994

* Mon Dec  7 2004 Chris Feist <cfeist@redhat.com> - 1:4.1.3-64
- Fixed problem with autofs not finding all mount points in an ldap map.
  bz #139548

* Fri Nov 19 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-58
- Pass a socket into clntudp_bufcreate so that we don't use up additional 
  reserved ports.  This patch, along with the socket leak fix, addresses
  bz #128966.

* Fri Nov 19 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-57
- Pass a socket into clntudp_bufcreate so that we don't use up additional 
  reserved ports.  This patch, along with the socket leak fix, addresses
  bz #128966.

* Wed Nov 17 2004  <jmoyer@redhat.com> - 1:4.1.3-56
- Somehow the -browse patch either didn't get committed or got reverted.
  Fixed.

* Tue Nov 16 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-55
- Fix program maps so that they can have gt 4k characters. (Neil Horman)
  Addresses bz #138994.
- Add a space after the colon here "Starting automounter:" in init script.
  Fixes bz #138513.
