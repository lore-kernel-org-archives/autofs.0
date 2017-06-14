From: Chuck Lever <chuck.lever-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: Proposal for end-of-life for fedfs-utils development
Date: Wed, 14 Jun 2017 16:53:07 -0400
Message-ID: <43E4D612-8CCD-4511-9E1D-265F4D459EE6@oracle.com>
References: <56804FBE-34B2-47FB-96EF-013D4476D89A@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Transfer-Encoding: 7bit
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56804FBE-34B2-47FB-96EF-013D4476D89A-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: fedfs-utils Developers <fedfs-utils-devel-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>, Linux NFS Mailing List <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "fedfs-utils;release announcements" <fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>, autofs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chuck Lever via samba-technical <samba-technical-w/Ol4Ecudpl8XjKLYN78aQ@public.gmane.org>


> On Jun 2, 2017, at 11:01 AM, Chuck Lever <chuck.lever-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> 
> Upstream fedfs-utils has not been under active development for
> two years or more, and there is a scant user base. I'd like to
> propose making 0.10 the final major release of fedfs-utils.
> 
> The plan:
> 
> - Since 0.10 is in at least one major enterprise distribution,
> I will remain available to integrate security fixes and make
> new minor releases in the 0.10 line, as needed, for one to
> two more years.
> 
> - Retire and remove fedfs-utils from upstream mirror distros
> such as Fedora rawhide.
> 
> - Transfer utilities such as nfsref into nfs-utils, with
> support for FedFS junctions removed.
> 
> - Announcements of the change in status will be made on
> fedfs-utils-announce and on the wiki.linux-nfs.org site.
> 
> 
> 
> Comments welcome!

This was meant as a Request For Comments, but the cat is
out of bag now:

https://lwn.net/Articles/725411/rss

;-)

I haven't heard any objections to this proposal, so let's
go with it. Consider this the official announcement of
the end-of-life of fedfs-utils.


--
Chuck Lever



--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
