From: Jeff Moyer <jmoyer@redhat.com>
Subject: [RFT] Another round of testing for the map expiry changes
Date: Thu, 18 Nov 2004 10:43:32 -0500
Message-ID: <16796.49956.382698.186364@segfault.boston.redhat.com>
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
Cc: cfeist@redhat.com, raven@themaw.net

Hello, all,

It's been a while, as you can see from the changelog below.  I'd like to
get more feedback on the map expiry changes Ian came up with.  I would also
like feedback on the following:

- giant (>4k characters) program maps (they used to get truncated)
- No regressions !  (this simply requires lots of people to make sure their
  environments still work).

RPMs can be found in the usual place:
     http://people.redhat.com/~jmoyer/

So far, I've only built for fc-3.  If people would like to test on other
distros, let me know which ones.  The kernel patch is required for the map
expiry changes.  To make things easy for you, I've built an FC-3 kernel
with this patch and posted it to the web page.  If you want to run this on
an arch other than i686, let me know.  I've built the rpms, I just haven't
uploaded them due to size.

Any and all feedback is welcome.  Happy testing.

-Jeff


* Wed Nov 17 2004  <jmoyer@redhat.com> - 1:4.1.3-55.1
- re-enable map expiry patch
- update ldap-search-limit patch to play nice with map expiry changes.
- Multimounts broke with the expiry patch.  ian fixed.  (Ian Kent)

* Tue Nov 16 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-55
- Fix program maps so that they can have gt 4k characters. (Neil Horman)
  Addresses bz #138994.
- Add a space after the colon here "Starting automounter:" in init script.
  Fixes bz #138513.

* Mon Nov 15 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-53
- Make autofs understand -[no]browse.  Addresses fz #113494.

* Thu Nov 11 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-48
- Fix the umount loop device function in the init script.

* Wed Oct 27 2004 Chris Feist <cfeist@redhat.com> - 1:4.1.3-34
- Added a patch to fix the automounter failing on ldap maps
  when it couldn't get the whole map.  (ie. when the search
  limit was lower than the number of results)

* Thu Oct 21 2004 Chris Feist <cfeist@redhat.com> - 1:4.1.3-32
- Fixed the use of +ypmapname so the maps included with +ypmapname
  are used in the correct order.  (In the past the '+' entries
  were always processed after local entries.)

* Thu Oct 21 2004 Chris Feist <cfeist@redhat.com> - 1:4.1.3-31
- Fixed the duplicate map detection code to detect if maps try
  to mount on top of existing maps. 

* Wed Oct 20 2004 Chris Feist <cfeist@redhat.com> - 1:4.1.3-29
- Fixed a problem with backwards compatability. Specifying local
  maps without '/etc/' prepended to them now works. (bz #136038)

* Fri Oct 15 2004 Chris Feist <cfeist@redhat.com> - 1:4.1.3-28
- Fixed a bug which caused directories to never be unmounted. (bz #134403)

* Thu Oct 14 2004 Chris Feist <cfeist@redhat.com> - 1:4.1.3-27
- Fixed an error in the init script which caused duplicate entries to be
  displayed when asking for autofs status.

* Fri Oct  1 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-22
- Comment out map expiry (and related) patch for an FC3 build.

* Thu Sep 23 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-21
- Make local options apply to all maps in a multi-map entry.

* Tue Sep 21 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-20
- Merged my and Ian's socket leak fixes into one, smaller patch. Only
  partially addresses bz #128966.
- Fix some more echo lines for internationalization. bz #77820
- Revert the only one auto.master patch until we implement the +auto_master
  syntax.  Temporarily addresses bz #133055.

* Thu Sep  2 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-18
- Umount loopback filesystems under automount points when stopping the 
  automounter.
- Uncomment the map expiry patch.
- change a close to an fclose in lookup_file.c

* Tue Aug 31 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-17
- Add patch to support parsing nsswitch.conf to determine map sources.
- Disable this patch, and Ian's map expiry patch for a FC build.

* Tue Aug 24 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-16
- Version 3 of Ian's map expiry changes.

* Wed Aug 18 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-15
- Fix a socket leak in the rpc_subs, causing mounts to fail since we are 
  running out of port space fairly quickly.

* Wed Aug 18 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-14
- New map expiry patch from Ian.
- Fix a couple signal races.  No known problem reports of these, but they
  are holes, none-the-less.

* Tue Aug 10 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-13
- Only read one auto.master map (instead of concatenating all found
sources).
- Uncomment Ian's experimental mount expiry patch.
