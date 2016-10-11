From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 1/8] vfs - change d_manage() to take a struct path
Date: Tue, 11 Oct 2016 11:04:03 -0500
Message-ID: <87zimazxcc.fsf@x220.int.ebiederm.org>
References: <20161011053352.27645.83962.stgit@pluto.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20161011053352.27645.83962.stgit@pluto.themaw.net> (Ian Kent's
        message of "Tue, 11 Oct 2016 13:33:52 +0800")
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

Ian Kent <raven@themaw.net> writes:

> For the autofs module to be able to reliably check if a dentry is a
> mountpoint in a multiple namespace environment the ->d_manage() dentry
> operation will need to take a path argument instead of a dentry.

Taking a quick look overall I see no issues with this series.  Overall
it seems straight forward.

On the nit side I expect saying const struct path * in the functions
that now take a struct path would be useful.

I suspect it would also be useful to say
	const struct path *path;
        path = &file->f_path;

In the one part of the code where you do that.  Instead of copying the
path out of the struct file.

Overall I expect that will keep down bugs at no reduction in usability.
Just a statement that the struct path won't change when it is passed
to various functions.

Eric
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
