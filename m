From: Chuck Lever <chuck.lever-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [ANNOUNCE] fedfs-utils for Linux
Date: Tue, 12 Apr 2011 12:48:18 -0400
Message-ID: <8086DF6B-252D-4746-AA6E-A6A85FEDAAE5@oracle.com>
References: <AB0460DE-A056-47AA-B387-156D35334E04@oracle.com> <20110412155431.GA8583@infradead.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Transfer-Encoding: 8BIT
Return-path: <util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110412155431.GA8583-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Linux NFS Mailing List <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, autofs-CPWUtch7KCBzeIdxy0IIJw@public.gmane.org, util-linux-ng-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


On Apr 12, 2011, at 11:54 AM, Christoph Hellwig wrote:

> On Thu, Apr 07, 2011 at 04:24:29PM -0400, Chuck Lever wrote:
>> See http://oss.oracle.com/projects/fedfs-utils for more information and source code downloads.  Two mailman mailing lists are also available:
>> 
>>  fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org
>>  fedfs-utils-devel-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org
> 
> Is it really a good idea to not just one but two separate mailinglist
> for something tightly integrated with nfs anyway?  Why not just use
> linux-nfs for the small amount of additional traffic?

FedFS is agnostic to the underlying file protocol.  The current Linux FedFS prototype happens to be NFS-only, but we don't expect it to stay that way.

-- 
Chuck Lever
chuck[dot]lever[at]oracle[dot]com




--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
