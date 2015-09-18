From: Ning Yu <ning.yu@canonical.com>
Subject: Re: [PATCH v5 0/8] Series to change autofs to using a monotonic clock
Date: Fri, 18 Sep 2015 18:18:51 +0800
Message-ID: <CAA1QoHSMtakm4mXxH=SbzRDEFL+fJAkkC=Od85VM3G4t7jpEtQ@mail.gmail.com>
References: <20150918092704.29311.84246.stgit@pluto.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20150918092704.29311.84246.stgit@pluto.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Yu Ning <ning.yu@ubuntu.com>, autofs mailing list <autofs@vger.kernel.org>

On Fri, Sep 18, 2015 at 5:34 PM, Ian Kent <raven@themaw.net> wrote:
> This is what I get using "stg mail" when mailing patch series.
>
> I've made a few changes to te breakdown of the patches.
> I tried to implement the alarm module change we discussued.
> I changed the mount and expire condition to use a monotonic clock
> as well for both the direc and indirect modules for completeness.
> And I changed the patch descriptions a bit.
>
> I'll add my "Signed-off-by" after we've verified the series is OK
> and I've completed some samity testing.
>
> The series should apply, I don't think there are conflicts with
> patches in my queue that are before them. The CHANGELOG hunk will
> be a problem though, as expected, and will likely change due to
> me changing the patch order before actually committing them.
>
> Let me know if you can see any problem with the series.
>

It looks much more better than my original version, thanks very much.
I'm OK with it, and hope it won't cause any regression issue ;)

> ---
>
> Ian Kent (1):
>       autofs-5.1.1 - remove unused function elapsed()
>
> Yu Ning (7):
>       autofs-5.1.1 - define monotonic clock helper functions
>       autofs-5.1.1 - use monotonic clock for alarm thread condition wait
>       autofs-5.1.1 - define pending condition init helper function
>       autofs-5.1.1 - use monotonic clock for direct mount condition
>       autofs-5.1.1 - use monotonic clock for indirect mount condition
>       autofs-5.1.1 - change remaining gettimeofday() to use clock_gettime()
>       autofs-5.1.1 - change time() to use monotonic_clock()
>
>
>  CHANGELOG                 |    7 +++++++
>  daemon/automount.c        |    4 ++--
>  daemon/direct.c           |   24 ++++++++----------------
>  daemon/indirect.c         |   24 ++++++++----------------
>  daemon/lookup.c           |    6 +++---
>  daemon/state.c            |    2 +-
>  include/automount.h       |   31 +++++++++++++++++++++++++++++++
>  include/rpc_subs.h        |    1 +
>  lib/alarm.c               |   28 ++++++++++++++++++++++------
>  lib/cache.c               |    2 +-
>  lib/master.c              |    4 ++--
>  lib/rpc_subs.c            |   20 +++++++++++---------
>  modules/dclist.c          |    2 +-
>  modules/lookup_file.c     |    8 ++++----
>  modules/lookup_hesiod.c   |    6 +++---
>  modules/lookup_hosts.c    |    4 ++--
>  modules/lookup_ldap.c     |   10 +++++-----
>  modules/lookup_nisplus.c  |   10 +++++-----
>  modules/lookup_program.c  |   10 +++++-----
>  modules/lookup_sss.c      |    6 +++---
>  modules/lookup_userhome.c |    2 +-
>  modules/lookup_yp.c       |    8 ++++----
>  modules/mount_autofs.c    |    2 +-
>  modules/parse_amd.c       |    2 +-
>  modules/replicated.c      |   34 ++++++++++++++++------------------
>  25 files changed, 148 insertions(+), 109 deletions(-)
>
> --
> Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
