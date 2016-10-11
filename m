From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/8] vfs - change d_manage() to take a struct path
Date: Wed, 12 Oct 2016 07:47:29 +0800
Message-ID: <1476229649.3108.1.camel@themaw.net>
References: <20161011053352.27645.83962.stgit@pluto.themaw.net>
         <87zimazxcc.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=ynWJn6fdXVQNANi86BrYpaklKEE=; b=Ieo859
        25jV1jGl++tUJkxSUvPEs85+4+lwt+V7M+JZlGlRRL4eZyhPrqPFMdB8EHN0lsl1
        4+ZB7aNXyEICXBo7XxJqRnMKgXDgTntucQpsUxNAsvH1qrMffhgjfvZSYtED9w1X
        Uam4cwazBR25fUekFp2qvbnzSMhNZi90w255c=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ynWJn6fdXVQNANi
        86BrYpaklKEE=; b=fMT9C/nDEI4SPOHGLEY5LmIHw7vqFEKMufWGbulDIs9j06h
        NuNGzQX6YPcYdoAoQP0lQaAGg8V4atk2VtJPO2ifHVwckqjofDmKz30EIYwofjVX
        hhFqHhSHPnM0LrleVQPVdcGZJU/cg2ybw/zEEUmFqcsPUwAjFSCjNaxnCEPY=
In-Reply-To: <87zimazxcc.fsf@x220.int.ebiederm.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

On Tue, 2016-10-11 at 11:04 -0500, Eric W. Biederman wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > For the autofs module to be able to reliably check if a dentry is a
> > mountpoint in a multiple namespace environment the ->d_manage() dentry
> > operation will need to take a path argument instead of a dentry.
> 
> Taking a quick look overall I see no issues with this series.  Overall
> it seems straight forward.
> 
> On the nit side I expect saying const struct path * in the functions
> that now take a struct path would be useful.
> 
> I suspect it would also be useful to say
> 	const struct path *path;
>         path = &file->f_path;
> 
> In the one part of the code where you do that.  Instead of copying the
> path out of the struct file.
> 
> Overall I expect that will keep down bugs at no reduction in usability.
> Just a statement that the struct path won't change when it is passed
> to various functions.

Thanks Eric, that's a good suggestion for a follow up patch, will do.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
