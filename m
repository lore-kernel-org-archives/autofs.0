From: Steve Dickson <SteveD-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Libtirpc-devel] [PATCH] Autofs configure fails to detect IPv6
 when libtirpc is enabled
Date: Tue, 26 Jul 2011 17:13:10 -0400
Message-ID: <4E2F2DE6.5030500@RedHat.com>
References: <1311683346-16881-1-git-send-email-steved@redhat.com> <8A84CF7D-9579-4645-AE5D-FE8358F466C0@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8A84CF7D-9579-4645-AE5D-FE8358F466C0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Chuck Lever <chucklever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Libtirpc Devel List <libtirpc-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux NFS Mailing List <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, autofs mailing list <autofs-CPWUtch7KCBzeIdxy0IIJw@public.gmane.org>



On 07/26/2011 10:50 AM, Chuck Lever wrote:
> 
> On Jul 26, 2011, at 2:29 PM, Steve Dickson wrote:
> 
>> From: Ian Kent <raven-PKsaG3nR2I+sTnJN9+BGXg@public.gmane.org>
>>
>> The IPv6 client functions clntudp6_bufcreate(), clntudp6_create and
>> clnttcp6_create and the server functions svcudp6_bufcreate(),
>> svctcp6_create() and svcudp6_create() are not included in the library
>> whe libtirpc is built.
> 
> Are these part of the libtirpc standard API?  I'm not sure why we would need them if, say, Solaris does not support these.
It appears they are not since they are not mentioned the man pages.....
But, at least in the autofs code, they are expected
   https://bugzilla.redhat.com/show_bug.cgi?id=711956#c0

Ian, where else are these routines defined? 

steved

> 
>> Signed-off-by: Steve Dickson <steved-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>> src/rpc_soc.c |    4 ++--
>> 1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/rpc_soc.c b/src/rpc_soc.c
>> index c678429..584ac71 100644
>> --- a/src/rpc_soc.c
>> +++ b/src/rpc_soc.c
>> @@ -236,7 +236,7 @@ clnttcp_create(raddr, prog, vers, sockp, sendsz, recvsz)
>>
>> /* IPv6 version of clnt*_*create */
>>
>> -#ifdef INET6_NOT_USED
>> +#ifdef INET6
>>
>> CLIENT *
>> clntudp6_bufcreate(raddr, prog, vers, wait, sockp, sendsz, recvsz)
>> @@ -392,7 +392,7 @@ svcraw_create()
>>
>>
>> /* IPV6 version */
>> -#ifdef INET6_NOT_USED
>> +#ifdef INET6
>> SVCXPRT *
>> svcudp6_bufcreate(fd, sendsz, recvsz)
>> 	int fd;
>> -- 
>> 1.7.6
>>
>>
>> ------------------------------------------------------------------------------
>> Magic Quadrant for Content-Aware Data Loss Prevention
>> Research study explores the data loss prevention market. Includes in-depth
>> analysis on the changes within the DLP market, and the criteria used to
>> evaluate the strengths and weaknesses of these DLP solutions.
>> http://www.accelacomm.com/jaw/sfnl/114/51385063/
>> _______________________________________________
>> Libtirpc-devel mailing list
>> Libtirpc-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> https://lists.sourceforge.net/lists/listinfo/libtirpc-devel
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
