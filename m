From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] autofs4 - use simple_empty() for empty directory check
Date: Fri, 16 Nov 2012 08:43:28 -0800
Message-ID: <CA+55aFz+JUthf-HAdYLzQH=r0niB4+X1ymn5egLpdhiptYXr7w@mail.gmail.com>
References: <20121116041523.18624.46918.stgit@perseus.themaw.net>
 <CA+55aFx-9A0xknhX7z9KmLAoGMf5GXhuFgroZUixHtevGAFsOQ@mail.gmail.com> <1353083773.2332.40.camel@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=Xl6CY73p/JNePkgrLumtvkGDtSuHOjGUchNTqO6YMXQ=;
        b=o9ACKlT6O5rQw5KMVlJWlED1Aeq4FzToTWS+V5P5ZmOA6LOQ4q6AsgYv+fzViBw1tO
         CnPTX7EJ2z6HD0/HgFUDi65oqJjd/akN3RbcA37EpBMJ4EF4kzery9Iw+k2lhV85xEEh
         HD4I5xZdEjmEoYQZHoPTZoPDdZCCVCf8sNgN0IKYJhKk7uy2OUETCMrS8IkbGJX2slAe
         DhqjFrbNIiHc7PQbFkNOGefzJmkGmJNFFb8xJpIu/N2Sc4gjxS2JOurk1A+37PfzuyYJ
         XRnQtNsbC2fz+LJ3p7Y9ai2kGnwavjfnYwLJ9z/yfTY9LBDk5DQ5Y5UnIkx9mS0BJhbf
         i2vA==
In-Reply-To: <1353083773.2332.40.camel@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <ikent@redhat.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>

On Fri, Nov 16, 2012 at 8:36 AM, Ian Kent <ikent@redhat.com> wrote:
>
> Sure, are you recommending I alter the fs/libfs.c functions to add a
> function that doesn't have the outer lock, and have simple_empty() call
> that, then use it in autofs?

Yup. That's the standard pattern, although usually we *strive* to make
the unlocked versions be static to the internal code, and then use
them there for the various helpers. In your case that seems
impossible, since you do depend on holding the d_lock in the caller
after the tests. But at least we don't have to duplicate the code and
have it in two unrelated places.

Al? Comments?

            Linus
