From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet committed
Date: Sat, 28 Dec 2013 20:09:49 +0800
Message-ID: <CAF1ZMEcOgg2DA++12XHnBRue58-W_HmeByNfbs80HjmnFsZ0dA@mail.gmail.com>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
	<CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
	<1387875881.7351.12.camel@perseus.fritz.box>
	<CAF1ZMEeUDS8wunF9AHXwQ=xf0OW6_ucmyfQicfbpP7sVavpaSw@mail.gmail.com>
	<1387881262.7351.15.camel@perseus.fritz.box>
	<CAF1ZMEcfVTYS=6sfVhSbO8MVaMxcU2v8qV_7O6ACMCRHLxMXeA@mail.gmail.com>
	<CAF1ZMEfbrpZ_=GxYTNS-sfus9-QTBD-WCMaZR-ZaEpShPbFdBg@mail.gmail.com>
	<CAF1ZMEdRhy5LcfEwUW3Os5M8nKXT1j2+M4oqOKgqF3sjLPyWpw@mail.gmail.com>
	<1388134613.2623.7.camel@perseus.fritz.box>
	<1388198519.13774.4.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PAzraHKnDRFib58UW5Xc492XZSkQJE63sAm/z8LzFTA=;
        b=GV4Ump73ihSKjsWxkXD+C3ORNf62lNv0sqKdHGAseupghj1ehn9PlbrLuLbnB1ttDn
         3V/zCArJN1yBtMkOBRLKOohshmwsyGeUPFdT9o9UXeDukoZg55Kh27jnJjdXYlhmS0Py
         zwFsCpUcWGzWVWtVanc9azwO+PdKILNLl2mxBo9MPzkjr+ftxH7WbciPX6L7GM007d6T
         ctxJjclc7F9k7v1NhPZhFRWaySNDSSAYLRMrha3Xm2+DSkrBovncXFHEZ9WI7T1W5gTg
         JLEzyjZ+hosHlbr2+6rrog+TW10DiybtGu5xfLeoVaVKTalNAEsRtLIGuHdg+dIQ5o3i
         +f8w==
In-Reply-To: <1388198519.13774.4.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Sat, Dec 28, 2013 at 10:41 AM, Ian Kent <raven@themaw.net> wrote:

>> > using commit ec267c2c406256e401540e5bc890b2e0c2ff6c35
> I've updated the autofs-5.0.public branch.
> Can you test it please.
>
> Ian
>
Hi Ian:
 Did you only fix the problem while libtirpc is disabled, as I looking
at your commits?
I've tested the case with libtirpc disabled, all works fine (test both
nfs mount with nfsvers=3,4)

but with libtirpc enabled, fail as same previous error

Lan
