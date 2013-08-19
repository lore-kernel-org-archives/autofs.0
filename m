From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: Seperate option for install systemd unit file
Date: Mon, 19 Aug 2013 14:23:16 +0800
Message-ID: <1376893398-11765-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=IYGQXOQZ1/nTppuEd/ch8zJ4cQiUxK6vCfukGWgqYeY=;
        b=OWFIYaA5CK1vl0IyL5RKRmFoXTZgmBclpPo+eVhEbVZh2oLiZBz+NKOVAGnLVWMP2o
         hoV8duYgsDnhRz25f690bsUTM74gkrTkatEcm1C5kH5uJ6g7FuyJ7sPiEphPDCsvcMcs
         duQkhHr4Mc+Imo6yvBeEnH56ZY6JEjuKUz9lXacyOY8fYzd+fXNZGwkjfz23abm42Ngf
         E9GDgTzOiZyAmjPptN/Hahxu6shEtsqXb2bNLTTL0g0d/NRFiIqAPzF9VPrEcPd9+n9V
         B6vdfYiPlWtmm+oWcbOv+ZUNhtg4ow3FgPp6Snd29aoA7ObMpAfJB2WvXLrgNma0I0oy
         XXJQ==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

those patches are very trivial changes which only instroduce a new --with-systemdsystemunitdir option
to better control where we should install system unit file to

1) seperate --with-systemd opiton, but been kept now for future use (but it's useless now)
2) add new option --with-systemdsystemunitdir to manage the path where unit file will be installed
3) --with-systemd and --with-systemdsystemunitdir are two seperate option, so unit can be installed even systemd support is not enabled.

downstream discussion: https://bugs.gentoo.org/show_bug.cgi?id=479492

let me know whether this looks good to you..

[PATCH 1/2] seperate option of --with-systemd from install systemd
[PATCH 2/2] introduce new '--with-systemdsystemunitdir'
