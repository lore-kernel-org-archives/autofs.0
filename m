From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 24/25] autofs-5.0.7 - fix bad mkdir permission on create
Date: Mon, 19 Aug 2013 10:13:30 +0800
Message-ID: <1376878410.2478.12.camel@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
	 <20130819011435.6472.95050.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=sZ1b0ktM6Ctnz1q2Z08aie36Low=; b=NC1lhLh7SBxxra89Za8QiO+spbA5
	ovZXTlV09lsYvC95wpfrScFHeQ8jqZ2aS68Sc1cY0f2uYgzpd0mKnsVtvM1+pQTf
	F58IKxk/YN/KeDCMqritUh84KjJT7ktlmdEuWtIs+IRVwVPH0RaQ/Cw2lUENrezB
	NFdj/ukC9g0KMKM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=sZ1b0ktM6Ctnz1q2Z08aie
	36Low=; b=PYFJp2mrHw6bG+IEkI/u/eyrFpsJvwoKMEu16YiGjCBj5/c/gGrD2P
	Bb8xoZR7DdrSAQb5CgRh7hNrRnB7K9Lw3UdBZ8mNkiYLA5hXRZp2F72H50Ls4s0N
	nDAOVnjyghGwSuhE1lmawez3N09ZDNxQzrckAXmvnL3t9gEiTzNwE=
In-Reply-To: <20130819011435.6472.95050.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

On Mon, 2013-08-19 at 09:14 +0800, Ian Kent wrote:
> Reported by Gordon Lack (gordon[dot]m[dot]lack[at]gsk[dot]com).
> 
> If the automount daemon needs to create a directory (hierarchy) for an
> automount and it is started up with a umask of 027 (or similar) then it
> creates unusable directories (permission == 550).
> ---
>  CHANGELOG          |    1 +
>  daemon/automount.c |    5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/CHANGELOG b/CHANGELOG
> index 2499f1c..3a3fec1 100644
> --- a/CHANGELOG
> +++ b/CHANGELOG
> @@ -75,6 +75,7 @@
>  - fix fix wildcard multi map regression.
>  - improve timeout option description.
>  - only probe specific nfs version if requested.
> +- fix bad mkdir permission on create.
>  
>  25/07/2012 autofs-5.0.7
>  =======================
> diff --git a/daemon/automount.c b/daemon/automount.c
> index 97c726a..6b55103 100644
> --- a/daemon/automount.c
> +++ b/daemon/automount.c
> @@ -122,7 +122,10 @@ static int do_mkdir(const char *parent, const char *path, mode_t mode)
>  		status = statfs(parent, &fs);
>  	if ((status != -1 && fs.f_type == (__SWORD_TYPE) AUTOFS_SUPER_MAGIC) ||
>  	    contained_in_local_fs(path)) {
> -		if (mkdir(path, mode) == -1) {
> +		int mask = umask(0022);
> +		int ret = mkdir(path, mode);
> +		void umask(mask);

OK, so that void should be (void).

> +		if (ret == -1) {
>  			errno = EACCES;
>  			return 0;
>  		}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


