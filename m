From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 0/9] Series short description
Date: Wed, 24 Jul 2013 18:31:55 +0800
Message-ID: <CAF1ZMEfoeAsp5MiENjb347K+3H-Hb_Zd=eHb_dO9vgmy9joWpg@mail.gmail.com>
References: <20130724081610.722.84685.stgit@perseus.fritz.box>
	<CAF1ZMEdmTPuUCP2dR-nxBEP+swm0Mqoxw0ve3rJx-9wn12FRXA@mail.gmail.com>
	<1374660865.2358.32.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bHWucoHbR8x6uZaWGhaF5PYPcOCBxgqJX2jdAR+mWBg=;
        b=S7Pliu0gC7Tn+yFE69yUDBiWJT2kGZPR0PRUeQpkDRQF703ulpw8g7BKuTk6yxsVJI
         lEEwcajHxxS18gdZtbNrxT7qujmPfWQEXpeR6W1x/y2Vz9QVSwSf6bnBJus0X6EiAsD2
         k3s6keQWlyBsC6cXAzaolP0EWQjLHB/q1xTKahbk5CwoJ0uMTiUatu2Jzc6I98dNZ0XN
         l+qbaIY/1IbIezBGMk1guWPY7NU4tLEXe5c4TehSXukbdS+1p11kB30ZKr0vC5X23JUX
         c5C2hq1gV/ra27k/MR16D0aOWOl13sjVM1tEU/7k8GG2JzY3Wwg7Ds0PJpCmpcvLY2/T
         hZLQ==
In-Reply-To: <1374660865.2358.32.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Wed, Jul 24, 2013 at 6:14 PM, Ian Kent <raven@themaw.net> wrote:
> On Wed, 2013-07-24 at 16:34 +0800, Dennis Lan (dlan) wrote:
>> On Wed, Jul 24, 2013 at 4:17 PM, Ian Kent <raven@themaw.net> wrote:
>> > The following series implements...
>> >
>> > ---
>> >
>> > Dustin Polke (1):
>> >       autofs-5.0.7 - fix compilation of lookup_ldap.c without sasl
>> >
>> > Ian Kent (1):
>> >       autofs-5.0.7 - use LIBS for link libraries
>> >
>> > Lan Yixun (dlan) (7):
>> >       autofs-5.0.7 - fix typo forced-shutdown should be force-shutdown
>> >       autofs-5.0.7 - fix hesiod check error and use correct $(LIBS) setting
>> >       autofs-5.0.7 - fix dead LDAP symbolic link when LDAP support is disabled
>> >       autofs-5.0.7 add missing libtirpc lib to mount_nfs.so when TIRPC enabled
>> >       autofs-5.0.7 - use compiler determined by configure instead of hard-coded ones
>> >       autofs-5.0.7 - remove hard-coded STRIP variable
>> >       autofs-5.0.7 - unbundle NOTSTRIP from DEBUG so they wont depend on each other
>> >
>> >
>> >  CHANGELOG             |    4 ++++
>> >  Makefile.conf.in      |    3 +++
>> >  Makefile.rules        |   30 +++++++++++++++---------------
>> >  aclocal.m4            |   12 ++++++------
>> >  configure             |   20 ++++++++++----------
>> >  configure.in          |    2 +-
>> >  daemon/Makefile       |    2 +-
>> >  include/lookup_ldap.h |    4 ++--
>> >  lib/Makefile          |    4 ++++
>> >  modules/Makefile      |   20 ++++++++++++--------
>> >  modules/lookup_ldap.c |   14 ++++++++++++--
>> >  11 files changed, 70 insertions(+), 45 deletions(-)
>> >
>> > --
>> > Signature
>>
>> Hi Ian:
>>   Thanks.
>>   But I haven't seen the commits published, am I use the wrong repo url? [1]
>
> This was a false start, as I replied to it later.
>
> The posts to follow are what I have in the queue for the next time I
> commit changes.
>
> There are three types of patches in the queue of patches I have.
>
> First are ones I will commit next time I do a commit, second are patches
> that may on may not be applied depending on their state and which may or
> may not be committed next commit, and third patches which I'm carrying
> that I don't intend to commit, at least for the moment.
>
> So I'd like to confirm I have what your hoping for before committing
> anything and then there's the as yet unfinished patch ....
>
> Ian
>
>>
>> Dennis Lan (dlan)
>>
>>
>> [1] git://git.kernel.org/pub/scm/linux/storage/autofs/autofs.git
>
>

HI Ian:
  As I go through the patches, I think you've already include most of
my patches,
but expect this one:
  [PATCH 1/6] fix compile error with heimdal support enabled
  So far so good, and I will have a test tomorrow, and will let you
know the result.

  Thanks

Dennis Lan (dlan)
