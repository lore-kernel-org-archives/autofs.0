From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] autofs4: Use no_printk() for no-op DPRINTK() and use
 __VA_ARGS__ too
Date: Mon, 8 Aug 2011 09:09:04 -0700
Message-ID: <CA+55aFz1aoSMLHwD1BrNpGO95k+_PYqFG0fySNMh6dT5JVGJuQ@mail.gmail.com>
References: <20110808151038.17366.38130.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110808151038.17366.38130.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

On Mon, Aug 8, 2011 at 8:10 AM, David Howells <dhowells@redhat.com> wrote:
> Use no_printk() for autofs's no-op DPRINTK() to prevent unused statements from
> becoming accidentally obsolete, and use __VA_ARGS__ too as that's the standard
> way.

Gaah. May I suggest just avoiding the duplication by doing

   #ifdef DEBUG
   # define autofs_debug_printk printk
   #else
   # define autofs_debug_printk no_printk
   #endif

   #define DPRINTK(fmt, ...)                                      \
       autofs_debug_printk(KERN_DEBUG "pid %d: %s: " fmt "\n",           \
                 current->pid, __func__, ##__VA_ARGS__)

which also drops the pointless do { } while (0) protection since it's
already a well-formed statement?

                         Linus
