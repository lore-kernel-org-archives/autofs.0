From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH 2/2] introduce new '--with-systemdsystemunitdir'
Date: Mon, 02 Sep 2013 09:08:44 +0400
Message-ID: <52241D5C.1050905@msgid.tls.msk.ru>
References: <1376893398-11765-1-git-send-email-dennis.yxun@gmail.com> <1376893398-11765-3-git-send-email-dennis.yxun@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1376893398-11765-3-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs@vger.kernel.org

19.08.2013 10:23, Lan Yixun (dlan) wrote:
> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
>
> this option only control the path where the systemd unit file wll be installed
> and it's seperated from --with-systemd option, so it can be always installed alone.
>
> use cases:
> 1) if this option is not specificed, default option is
> '--with-systemdsystemunitdir=yes'
> will auto probe the directory of unit file
> 2) --with-systemdsystemunitdir=no, or --without-systemdsystemunitdir
> no unit file will be installed
> 3) --with-systemdsystemunitdir=/my/unit/file/directory/
> will install unit file into /my/unit/file/directory/
> (gentoo linux goes the 3nd way)

Out of curiocity, -- you haven't mentioned _why_ this option is needed to
start with.  Does gentoo use an alternative directory for systemd units?
If yes, again, out of curiocity, why?

Thanks,

/mjt
