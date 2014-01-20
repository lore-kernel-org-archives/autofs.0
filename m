From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: [PATCH] autofs-5.0.7 don't reset errno
Date: Mon, 20 Jan 2014 11:45:00 -0200
Message-ID: <CAEySpB5C8gOhsCd3Mv+2C_4+wX+jHVGP227i9kuY1QPZ4FJTDQ@mail.gmail.com>
References: <CAEySpB5qJqSennSmX_kxXxA2YXvL7UweqyhhvLOvMcHYQP_Rcw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=XCwYKuOWRNqhZF2gEyu48VqgWG6JXUfklpvx/Sb2TDU=;
        b=enY1UQo92kF66xiezA0EApS5LH3bC5pgQEgRdvgpzRuhCzJhkEoRtUadUMNHcWVPPd
         vhQI3CX69AaYwUZdNiIeYrflCjlKaQn1I2fQd/oTLT/j8i7Ig7IrY931/SFOGW3xFDap
         AbhF7mJrNX7YGFm2DhkZf/PEPpd2/Jbq/nc2Bq1iIurdonAuS/oY6gRXDOBBWJO6tbLE
         5/+OD+tTisoqkatvjcI9Q19XGn5ILpniqtbf3cc58x0joj8LYwx+lHB0nh3YFvEv6MQf
         BQIJEzzDrcsFfq+6mvg2J8Yi53aZkN4p8aUVvlSzu2QAEbeyOkIIKaIjmMiFI7PCk7XB
         MNeQ==
In-Reply-To: <CAEySpB5qJqSennSmX_kxXxA2YXvL7UweqyhhvLOvMcHYQP_Rcw@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs <autofs@vger.kernel.org>

On Thu, Sep 20, 2012 at 12:35 PM, Leonardo Chiquitto
<leonardo.lists@gmail.com> wrote:
> Hello Ian,
>
> Please consider the patch below for inclusion.
>
> Thanks,
> Leonardo
>
> From: Werner Fink <werner@suse.de>
>
> Do not reset the error code that might just have been set to ENOTDIR.
>
> Index: autofs/daemon/automount.c
> ===================================================================
> --- autofs.orig/daemon/automount.c
> +++ autofs/daemon/automount.c
> @@ -107,9 +107,9 @@ static int do_mkdir(const char *parent,
>         /* If path exists we're done */
>         status = stat(path, &st);
>         if (status == 0) {
> +               errno = EEXIST;
>                 if (!S_ISDIR(st.st_mode))
>                         errno = ENOTDIR;
> -               errno = EEXIST;
>                 return 0;
>         }

Hi Ian,

Looks like this one has slipped through the cracks. Could you review
and commit if appropriate?

Thanks,
Leonardo
