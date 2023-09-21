From: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/8] autofs - convert to to use mount api
Date: Thu, 21 Sep 2023 11:13:38 +0200
Message-ID: <20230921-altpapier-knien-1dd29cd78a2f@brauner>
References: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695287623;
        bh=q2nhZdZLMhYsgMyxe8nWUqtPJJSWYahI8Lr6GNIBT08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z87N/f3S15x2plk1l4lRfyhavKz2IPlPrEe0n53pLdrguqLTt3q2ferBn0MvbaZyL
         XgKc5FJxx+MHtO94ZxeAA9Y08GTz79Yj6Pmv5JE9LTlvanUgBGJ60UUxWqwET016kT
         cxXCVfpydzG+QAWdmq6za+YvIY3m7wH+hJDxkaZL38SyoDzAXntAz0DaCciH7hsPB7
         iCWLxfqcDRVYtbDhpFg5u9KjLgchQbB7Vh7RiNt7153NUGKo6c9lIIjei3XhHnC7IX
         p6cgV1bDik2OqtQ+JBf3OJxfIMPvtXVEfvqpL7Gkv7s427bp8RAEP5BGyp9GfiBrra
         tkdAWS7vhQyyA==
Content-Disposition: inline
In-Reply-To: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Bill O'Donnell <billodo@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>

On Thu, Sep 21, 2023 at 03:03:26PM +0800, Ian Kent wrote:
> There was a patch from David Howells to convert autofs to use the mount
> api but it was never merged.
> 
> I have taken David's patch and refactored it to make the change easier
> to review in the hope of having it merged.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
> 
> Ian Kent (8):
>       autofs: refactor autofs_prepare_pipe()
>       autofs: add autofs_parse_fd()
>       autofs - refactor super block info init
>       autofs: reformat 0pt enum declaration
>       autofs: refactor parse_options()
>       autofs: validate protocol version
>       autofs: convert autofs to use the new mount api
>       autofs: fix protocol sub version setting
> 

Yeah sure, but I only see 4 patches on the list? Is my setup broken or
did you accidently forget to send some patches?
