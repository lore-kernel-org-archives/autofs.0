From: Ian Kent <raven@themaw.net>
Subject: Re: autofs: make the autofsv5 packet file descriptor use a
 packetized pipe
Date: Mon, 30 Apr 2012 13:57:58 +0800
Message-ID: <1335765478.2281.13.camel@perseus.themaw.net>
References: <20120429205429.63CCD7C0064@ra.kernel.org>
	 <4F9DD994.70202@zytor.com>
	 <CA+55aFy72rPMq3M2_PU0ue45Fb38_Effrfhu2uOpdVXt9H1XOg@mail.gmail.com>
	 <4F9DDCB6.1070908@zytor.com>
	 <CA+55aFwGZm4+rdJ+xArhsVJ8P5gH3xxCfuoHibotr0Sik484=w@mail.gmail.com>
	 <4F9DDE47.5060008@zytor.com>
	 <CA+55aFzDhkVzaUYQwKbkUqoRNb223+w0-k=pOxTZHja75JOMvQ@mail.gmail.com>
	 <1335749398.2281.0.camel@perseus.themaw.net>
	 <CA+55aFzEefQWk+0EB2+dcL8DZcn+B7=1HZ1MV0HVMX7prhrmVA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=9jkPtO52hdkQ26DC26+czS/jlGU=; b=U6r4dqOwkUwNi0KDTddCP0L7cvcN
	bJuktPrO2ETpureDcAL7X30QDwSJOtXXxkYIuZi61wDDCP5RoYg7XSzvKiiHvnEp
	lgky2wKlRqBxxPTqZdb+0V5nLjY5sToLrSyYpvFMrGIX1KCo0R0i2UrkhM0Iq6nb
	C9zgduKUg8YfpQE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=9jkPtO52hdkQ26DC26+czS/jlGU=; b=iZH
	RvnxXf/0LP20sU8GkppplQnkvXhafZQP7B1qoa2jBbWU8Y81acqINudTgVoZL+0/
	gNUjZrSU8mcT8P20r9eyOp7RJjUFE+976NvR4s+hp3x9uT4nihKjIuP9hcnT8jDx
	TVS5NSf5kfraDCABnAyYN0pzOEqCYai5XE8WmLCs=
In-Reply-To: <CA+55aFzEefQWk+0EB2+dcL8DZcn+B7=1HZ1MV0HVMX7prhrmVA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Meyer <thomas@m3y3r.de>, autofs@vger.kernel.org

On Sun, 2012-04-29 at 18:56 -0700, Linus Torvalds wrote:
> On Sun, Apr 29, 2012 at 6:29 PM, Ian Kent <raven@themaw.net> wrote:
> >
> > autodir looks ok as well.
> >
> > http://sourceforge.net/projects/intraperson/files/latest/download
> 
> That looks odd, but safe.
> 
> Why does the code make the pipe file descriptor non-blocking, when it
> then always reads it using that odd "poll_read()" function that does a
> loop with poll() and read(). I guess there is some 1-second timeout
> thing.
> 
> It's a bit odd in other ways too. The "handle_events()" function is
> passed the fd, but then it never actually uses it, and uses
> 'autodir.k_pipe' instead.
> 
> So I'm having a bit of trouble following the *logic* to any of that,
> but the only reads I found did seem to match the "read whole packet"
> model, so it does look ok too.

I'm only aware that autodir uses the module and wasn't involved in the
development.

I didn't look closely at it at all, just enough to check for reads to
the kernel pipe, so I don't know either.

I'm not sure that autodir is still maintained so the only thing I'll do
is include a cc to the autodir mailing list in a any follow up mail to
the autofs list explaining the outcome of this work.

Ian

