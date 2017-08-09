From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Wed, 09 Aug 2017 09:39:09 +0100
Message-ID: <4689.1502267949@warthog.procyon.org.uk>
References: <150216641255.11652.4204561328197919771.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <150216641255.11652.4204561328197919771.stgit@pluto.themaw.net>
Content-ID: <4688.1502267949.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Ondrej Holy <oholy@redhat.com>, Colin Walters <walters@redhat.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Ian Kent <raven@themaw.net> wrote:

> In order to handle the AT_NO_AUTOMOUNT for both system calls the
> negative dentry case in follow_automount() needs to be changed to
> return ENOENT when the LOOKUP_AUTOMOUNT flag is clear (and the other
> required flags are clear).

Should the be EREMOTE instead of ENOENT?

David
