From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/9] Use %pd in AutoFS
Date: Wed, 11 Dec 2013 12:09:26 +0000
Message-ID: <1177.1386763766@warthog.procyon.org.uk>
References: <1386727713.2478.0.camel@perseus.fritz.box> <20131210152612.4916.80435.stgit@warthog.procyon.org.uk> <20131210152626.4916.67655.stgit@warthog.procyon.org.uk>
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1386727713.2478.0.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:

> > Use the new %pd printk() specifier in AutoFS to replace passing of dentry name
> > or dentry name and name length * 2 with just passing the dentry.
> > 
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Ian Kent <raven@themaw.net>
> > cc: autofs@vger.kernel.org
> 
> Looks sensible.
> 
> Acked-by: Ian Kent <raven@themaw.net>

Can you take the autofs bit through your tree?

David
