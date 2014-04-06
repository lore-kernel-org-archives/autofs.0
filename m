From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [PATCH] autofs4: check dev ioctl size before allocating
Date: Sat, 05 Apr 2014 23:11:03 -0400
Message-ID: <5340C5C7.9010203@oracle.com>
References: <1394934021-16965-1-git-send-email-sasha.levin@oracle.com>	 <53401C11.7010601@oracle.com> <1396753403.24991.3.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1396753403.24991.3.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, akpm@linux-foundation.org

On 04/05/2014 11:03 PM, Ian Kent wrote:
> On Sat, 2014-04-05 at 11:06 -0400, Sasha Levin wrote:
>> Ping? Anyone wants to take this?
> 
> Is this causing a problem for users?
> If it is I'll send it to Andrew straight away.
> 
> I do have this on my queue but don't have any other patches to send so
> it's just sitting there.
> 
> If it worries you I'll send it to Andrew now.

It's not really a pressing issue since /dev/autofs is accessible only to
root. I also doubt that it causes problems for actual users.

If there are no issues with the patch, I think it's best if you could
ack/sign off on it and if Andrew wants to take it now, he could. If he
doesn't, it could wait for whenever.

I just don't want it getting lost somewhere and never making it upstream.


Thanks,
Sasha
