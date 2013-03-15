From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2] autofs-5.0.7 - create a shared library
Date: Fri, 15 Mar 2013 14:28:14 +0400
Message-ID: <5142F7BE.400@msgid.tls.msk.ru>
References: <1363274460-27237-3-git-send-email-obi@saftware.de> <1363300213-12657-1-git-send-email-obi@saftware.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1363300213-12657-1-git-send-email-obi@saftware.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andreas Oberritter <obi@saftware.de>
Cc: autofs@vger.kernel.org

15.03.2013 02:30, Andreas Oberritter wrote:
> This reduces the (stripped) binary size from 1.6M to 572K
> on my system.

But it creates an additional file, the shared library, which
also occupes space.

What's the reason for that?  Instead of just one executable
we now have executable plus a library, which together is
larger than single executable.

Thanks,

/mjt
