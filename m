From: Jamie Jackson <jamiejaxon@gmail.com>
Subject: Fwd: Converting to New Syntax
Date: Mon, 1 May 2017 16:02:05 -0400
Message-ID: <CA+onWPcDEfabovjUriMRTDVnOo8tx8rLf4PxJA13Xt_By5J4bQ@mail.gmail.com>
References: <CA+onWPdMOVqgvW7rhyDCQ8u4xJ+RTQptPtEjTRj4yja4tF9CnA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=3R+KCQDYIPNvVUnRMwM10BRYOVnn/ZQrDk4ig35LRaU=;
        b=kjwEN/3Ijd4Lwrgh+hfkQYff8PaKuDwRDxHuyY2c0nu3AMzn3wvPl/N0a8hxWxKfWV
         lbLfK8cLVrdHZQ5C1S9uPj+hITluKhdZ3ANIdN3aWlBc0dgfQc0Oka69ct6zsBaDoK1H
         HxfMcU2hiMmyKpYaG221CHCZd1DeTNJaO7HFYqabvwc3p5xRuu0boAkXxNufNbmE0wS4
         LCQRAmWlLHW9jd9KHZrfVJ1XuCGYzB/HRKOzopFUICHDLgkteflPCjHHneu0q8cmPnuf
         ncik8pWkHPCvu0C/jIM+QPXxAj/7gphNpO0q8IWUqk13f/D09FXPFryJzsnxiJLOmG9z
         qGvA==
In-Reply-To: <CA+onWPdMOVqgvW7rhyDCQ8u4xJ+RTQptPtEjTRj4yja4tF9CnA@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

I'm new to Autofs, but I've had one auto-mount going for a few weeks
now. It came time for me to add a second one, but I ran into "ignoring
duplicate indirect mount /mnt/non-icf/my"

I see from https://www.spinics.net/lists/autofs/msg00000.html that I'm
supposed to use a different syntax to get both of these mount points
to coexist:

/mnt/non-icf/my/secureftp
/mnt/non-icf/my/testsftp

I'm reading https://www.centos.org/docs/5/html/Deployment_Guide-en-US/s1-nfs-client-config-autofs.html
, but I'm having trouble absorbing the content.

Could someone help me convert what I've got to what I need?

https://gist.github.com/jamiejackson/460ba0a6526d6251554a157821f526da

Also, since I'm new to all of this, if you see anything else that I
could be doing in a better way, please let me know.

Thanks
Jamie
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
