From: raven@themaw.net
Subject: Re: autofs4 patch: autofs4_wait can leak memory
Date: Mon, 7 Mar 2005 16:15:18 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0503071612570.23607@donald.themaw.net>
References: <16936.33587.974061.237160@segfault.boston.redhat.com>
Mime-Version: 1.0
In-Reply-To: <16936.33587.974061.237160@segfault.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org

On Fri, 4 Mar 2005, Jeff Moyer wrote:

> Hi,
>
> There is a memory in the autofs4_wait function, if multiple processes are
> waiting on the same queue:
>

Well done Jeff.

I'll update my retrospective patch set.

Ian
