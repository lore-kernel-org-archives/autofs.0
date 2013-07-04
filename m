From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 04/12] auto-fs: rename d_count field of dentry to d_refcount
Date: Wed, 3 Jul 2013 20:50:07 -0700
Message-ID: <CA+55aFzKfPG=CH+vZBUQMNd32qsuxPF1D3c3DB2Dm8w1QCb1+w@mail.gmail.com>
References: <1372908808-33304-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=kRLBQGE7MG0HeXai7q11CyaianrXyHaA2EehJo6cEUw=;
        b=Hjuu3ZAdk1vduxJR5J7Ui6QhYqA8WFcH7SiEMaZB9gr89s46GRD9cOG/ACLHISsKP+
         v69Y1fu1N4z4as9d6rakcqWz4bJXORlA63a+X5f3bIDPeoji+7TasaqeiIsSJWhyKZ3V
         7eGrZvUXQrSHgQdGO6Xzqreuf3bFa/B1MA04pYDmtUxxVZVNITFdtRSMTBt93QpmCBC1
         NnagZQ2M4rrciJ1L9pVyxB+Rkvh4lORlsfpMRuW2OczRaSu6ErwzjRMSx50UlxtKVDQP
         V8GNyXTv9BN2kGwHj9u6fMhv7eZG7M+gksaBwUbg1XFYZom9xZ0Wr4IH5vtVKL0fQ2It
         yCdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=kRLBQGE7MG0HeXai7q11CyaianrXyHaA2EehJo6cEUw=;
        b=bgxWuwEGTuEMQNOBM2XCVfZbyJOQcLq657QMHz5F9BDkt4MRcJvcBmBoCEwmM/hjTx
         e0BnegQ9r8E94kl80bl6aOKzTL9c52s3/cuwDNOpY6HZ0WkGapcNhuI1DN0itEyBQi9M
         b2m6qwAgd9QxDDvTIDDBnfEmOydkatT+mbwTs=
In-Reply-To: <1372908808-33304-1-git-send-email-Waiman.Long@hp.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Waiman Long <Waiman.Long@hp.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@redhat.com>, Miklos Szeredi <mszeredi@suse.cz>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ian Kent <raven@themaw.net>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andi Kleen <andi@firstfloor.org>, "Chandramouleeswaran, Aswin" <aswin@hp.com>, "Norton, Scott J" <scott.norton@hp.com>

On Wed, Jul 3, 2013 at 8:33 PM, Waiman Long <Waiman.Long@hp.com> wrote:
> Because of the d_count name change made in dcache.h, all references
> to d_count have to be changed to d_refcount.  There is no change in
> logic and everything should just work.

These filesystem patches need to be just joined into the same patch
that does the d_count -> d_refcount change.

Otherwise the kernel won't build in lots of configurations for some
commits, which makes things like bisecting much more painful than it
should be.

So we can't do piece-meal changes that break the build for parts of the tree.

              Linus
