From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 00/25] Current autofs patch queue
Date: Tue, 20 Aug 2013 12:52:39 +0800
Message-ID: <CAF1ZMEcW8=PdrA1s4n5fkDVhKOyCDXKDp6OVcwvRkb0gO7V2=A@mail.gmail.com>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
	<CAF1ZMEeFd=v+zWpqTOqdp59PAx_e4Ugqsr-tYAsSurrFiWi4hQ@mail.gmail.com>
	<1376967355.2426.1.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pOu868VajSsLdry9d6MD3bKXg7BOTMvs43e57j1J8l0=;
        b=VywxOuYpDf1W55xtELWQMUiEVra+LJmmJGGq+TitrlmM7p2heJL9CdnepuaIk13U9q
         ORciSpguCQLHDXbzAC+T5oGoCpFWqam46zWbbD8ZpdP8vVBikaG2JuaueS4OqN3HepLg
         Cel8Nxnt/qxKD6zqe3jf4TeZuJCL6ISncj6ViAWZ3aCyKymcbfa/aoRtrh3lMvjanwSq
         fWBQ4r04i/yxxW5fE3YUuvEeMpsjWumx0/TdKN7WbCBK913XCGMK7k1ZCtVanbuCwfst
         eKgdawXJpkp0aBz6LgIwWE/KXBHHgMJKHGekUyUgRwCIJAhCehRA+ZsZBLP4mVh0Eda3
         mALg==
In-Reply-To: <1376967355.2426.1.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Tue, Aug 20, 2013 at 10:55 AM, Ian Kent <raven@themaw.net> wrote:
> On Mon, 2013-08-19 at 13:30 +0800, Dennis Lan (dlan) wrote:
>> On Mon, Aug 19, 2013 at 9:11 AM, Ian Kent <raven@themaw.net> wrote:
>> > There are patches from several contributors I plan on committing
>> > so I thought posting them to the list for final review would be
>> > sensible.
>> >
>> > I'm not sure when I'll commit the changes but I hope in the next
>> > couple of days.
>> >
>> > ---
>> >
>> > Dustin Polke (1):
>> >       autofs-5.0.7 - fix compilation of lookup_ldap.c without sasl
>> >
>> > Ian Kent (13):
>> >       autofs-5.0.7 - don't override LDFLAGS in make rules
>> >       autofs-5.0.7 - fix a couple of compiler warnings
>> >       autofs-5.0.7 - add after sssd dependency to unit file
>> >       autofs-5.0.7 - dont start readmap unless ready
>> >       autofs-5.0.7 - fix dumpmaps multi output
>> >       autofs-5.0.7 - try and cleanup after dumpmaps
>> >       autofs-5.0.7 - teach dumpmaps to output simple key value pairs
>> >       autofs-5.0.7 - fix syncronize handle_mounts() shutdown
>> >       autofs-5.0.7 - fix fix wildcard multi map regression
>> >       autofs-5.0.7 - improve timeout option description
>> >       autofs-5.0.7 - only probe specific nfs version when requested
>> >       autofs-5.0.7 - fix bad mkdir permission on create
>> >       autofs-5.0.7 - setup program map env from macro table
>> >
>> > Lan Yixun (dlan) (10):
>> >       autofs-5.0.7 - fix compile error with heimdal support enabled
>> >       autofs-5.0.7 - fix typo forced-shutdown should be force-shutdown
>> >       autofs-5.0.7 - fix hesiod check error and use correct $(LIBS) setting
>> >       autofs-5.0.7 - fix dead LDAP symbolic link when LDAP support is disabled
>> >       autofs-5.0.7 - add missing libtirpc lib to mount_nfs.so when TIRPC enabled
>> >       autofs-5.0.7 - use compiler determined by configure instead of hard-coded ones
>> >       autofs-5.0.7 - remove hard-coded STRIP variable
>> >       autofs-5.0.7 - use LIBS for link libraries
>> >       autofs-5.0.7 - unbundle NOTSTRIP from DEBUG so they dont depend on each other
>> >       autofs-5.0.7 - fix occasional build error when enable parallel compiling
>> >
>> > Leonardo Chiquitto (1):
>> >       autofs-5.0.7 - fix crash due to thread unsafe use of libldap
>> >
>> >
>> >  CHANGELOG                      |   23 ++++
>> >  Makefile.conf.in               |    3
>> >  Makefile.rules                 |   34 +++--
>> >  aclocal.m4                     |   19 ++-
>> >  autofs.spec                    |    3
>> >  configure                      |  104 +++++++++++++++--
>> >  configure.in                   |    2
>> >  daemon/Makefile                |    2
>> >  daemon/automount.c             |   71 +++++++++--
>> >  daemon/state.c                 |   15 +-
>> >  include/config.h.in            |    3
>> >  include/lookup_ldap.h          |    4 -
>> >  include/macros.h               |    1
>> >  include/master.h               |    1
>> >  lib/Makefile                   |    6 +
>> >  lib/macros.c                   |   28 ++++
>> >  lib/master.c                   |  250 ++++++++++++++++++++++++++++++++++++++--
>> >  man/auto.master.5.in           |    5 +
>> >  man/automount.8                |   23 +++-
>> >  modules/Makefile               |   20 ++-
>> >  modules/cyrus-sasl.c           |   39 +++++-
>> >  modules/lookup_file.c          |   25 +++-
>> >  modules/lookup_ldap.c          |   76 +++++++++++-
>> >  modules/lookup_nisplus.c       |   26 +++-
>> >  modules/lookup_program.c       |   20 +++
>> >  modules/lookup_sss.c           |   22 +++-
>> >  modules/lookup_yp.c            |   23 +++-
>> >  modules/mount_bind.c           |    2
>> >  modules/mount_nfs.c            |   14 ++
>> >  redhat/autofs.sysconfig.in     |    5 +
>> >  samples/autofs.conf.default.in |    5 +
>> >  samples/autofs.service.in      |    2
>> >  32 files changed, 753 insertions(+), 123 deletions(-)
>> >
>> > --
>> > Ian
>>
>>
>> HI Ian:
>>  May I suggest you pushing this patch serials to one test branch
>> (for-next?) in the public repository?
>> I find this much more convenient for me to test (instead of fetch all
>> the patches and apply myself).
>> Since this branch is experimental, you can delete it later or rebase
>> to master branch.
>
> Not sure I've done this correctly but try updating and checkout branch
> pending-temp-v0.
>
> Ian
>
>
HI Ian:
  what you 've done is correct!
  I tested this branch, so far so good..

 you can use "git push origin :refs/heads/pending-temp-v0" to delete
this branch in the remote repository
or "git push --force origin HEAD:refs/heads/pending-temp-v0" to
override the remote branch with new commit (just in case you need to
do this)

Dennis Lan (dlan)
