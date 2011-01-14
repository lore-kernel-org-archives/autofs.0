From: Nick Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 09/18] autofs4: Add d_manage() dentry operation [ver #4]
Date: Sat, 15 Jan 2011 02:47:25 +1100
Message-ID: <AANLkTi=uLNWffT-gcSa5nWPA5qs7pAKTa6GVhDfxcaSH@mail.gmail.com>
References: <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
	<20110113215448.19406.58770.stgit@warthog.procyon.org.uk>
	<1295013099.2794.6.camel@perseus>
	<AANLkTin7GaJq6RuQdWkzY7XnH12-=8Gebr24Pyy+fWG+@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UOa9HjmOgZ+2y6UpZSUaYxwaLW/2I5hnqiCxtd/wCIE=;
        b=dBjt8YP/Hcqoiy4cJ5b4PhdlXEEnRE1NpCzlMvNyAQZRVl5LzyVwnenSo8TAMrAU9Z
         D3+PLi/33ssMVmLGWzp0GUOvC0pBDRZCBJpOhZS0hmdzD9xBs9CYsESbH+LtJBKMiTHE
         bhtwE47UCkUB9rS+XNlQC+ZXUgRAKJobknHS0=
In-Reply-To: <AANLkTin7GaJq6RuQdWkzY7XnH12-=8Gebr24Pyy+fWG+@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Sat, Jan 15, 2011 at 1:37 AM, Nick Piggin <npiggin@gmail.com> wrote:
> Although you can also just look at locking in fs/dcache.c and
> convert code from that.

Sorry, when I say this I mean locking *documentation* there. If anything
is unclear or unobvious, let me know and I'll try to improve documentation.

Thanks,
Nick
