From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: [PATCH 1/4] fs/autofs: Use time_before, time_before_eq, etc.
Date: Wed, 26 Dec 2007 11:58:56 -0800
Message-ID: <2c0942db0712261158q34cddebeifceef6ceda683320@mail.gmail.com>
References: <Pine.LNX.4.58.0712261621000.1185@pc-041.diku.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752688AbXLZT7S@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=xSmvDR6z2z2XMaAA4HRWyMgmctiVVydsQ+Atfu0+2Hs=;
        b=L7gbfbH30C5FuOIsPnAeB3zCPvuQV1njnz+t6kVphPLUIolZom8P+0cta4B2lkmJLy3W65c+SaT906yIqQVYK71N5+4TRCEtqUSuYVBnXpD4J1RmF6VL7WuzqSe12h+7C+BHzASWlnIcnlCCJwRsuCQiqqTilLn2QM9R0E67Hl4=
In-Reply-To: <Pine.LNX.4.58.0712261621000.1185@pc-041.diku.dk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Julia Lawall <julia@diku.dk>
Cc: hpa@zytor.com, autofs@linux.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Dec 26, 2007 7:21 AM, Julia Lawall <julia@diku.dk> wrote:
> -               if (jiffies - ent->last_usage < timeout)
> +               if (time_before(jiffies, ent->last_usage + timeout))

I don't think this is a safe change? subtraction is always safe (if
you think about it as 'distance'), addition isn't always safe unless
you know the range. The time_before macro will expand that out to
(effectively):

  if ( (long)(ent->last_usage + timeout) - (long)(jiffies) < 0 )

which seems to introduce an overflow condition in the first term.

Dunno, I may be wrong (happens often), but at the very least what
you've transformed it into is no longer obviously correct, and so it's
not a great change.
