From: Miklos Szeredi <miklos@szeredi.hu>
Subject: sloppy mount option not handled by some filesystems.
Date: Tue, 27 Jan 2015 18:09:52 +0100
Message-ID: <CAJfpegsPezK7-MY7F+re7N4N564OyzKVPsmOa-zSWGSpuP7W_A@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=PQtTB09+QlY17ZRYDjgb6S/LfJ7xsggjwcQ9/Q/kNZw=;
        b=OLq+kGeW1mIm25JiweM/AHSgY6R4lAWMRfpAJLTFz8f3YqrM+82f8F32FKAtnQ8JXh
         DHzHySAbhKmUfF5Hg7cTAuxTWx/XWjfFzUTx6JBYQiy0wOGe7FKrMHbNmfSrjUpAcuIP
         7UBPITaMfcH4bJHnznmfVJyFPPEkpZq5Gjl0I=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: Ian Kent <ikent@redhat.com>, lchiquitto@suse.com

I have two bug reports about filesystems that reject the "-s" option
and hence can't be used with autofs compiled with the sloppy option
(which apparently needs to be kept for back compatibility).

The mount(8) man page says that filesystems do not necessarily support
"-s" so I think autofs should honour this.

Any ideas?

Fs type whitelist?

Blacklist?

Retrying without the sloppy option if it fails with it?

Autofs option to turn off the sloppy option on a per-map or per-mount basis?

Thanks,
Miklos
