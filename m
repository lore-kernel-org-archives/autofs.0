From: jeffm@suse.com
Subject: [PATCH 0/2] autofs: fix two related bugs with lookup + expired yp maps
Date: Wed,  4 May 2016 20:03:30 -0400
Message-ID: <1462406612-2354-1-git-send-email-jeffm@suse.com>
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: Jeff Mahoney <jeffm@suse.com>

From: Jeff Mahoney <jeffm@suse.com>

Hi Ian -

We recently encountered an issue where a client would all of a sudden
start returning ELOOP for anything involving crossing an autofs mount.
We tracked it down to two bugs, one which obscured the other.  The first
is that we were not properly updating the map age for yp maps when we retry
the lookup with dots instead of underscores.  The second is that it is
possible under several situations to return success when there was a
failure in lookup_nss_mount.  In this particular case, it was the only
map in the list and since the age wasn't update, it was skipped.  Then
we exit the while loop with ret == 0, ultimately returning success to
the caller.  Autofs would tell the kernel it succeeded, the kernel would
retry the lookup, and we'd loop until we hit the kernel loop limit (40).

These two patches fix each of the issues.

Thanks,

-Jeff

Jeff Mahoney (2):
  autofs: fix yp map age not updated in s/_/./g case
  autofs: properly handle errors in lookup_nss_mount

 daemon/lookup.c     |  5 ++++-
 modules/lookup_yp.c | 17 ++++++++---------
 2 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.7.1

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
