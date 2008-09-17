From: Joe Pruett <joey@clean.q7.com>
Subject: Re: latest autofs from centos 4
Date: Wed, 17 Sep 2008 11:50:07 -0700 (PDT)
Message-ID: <alpine.LRH.2.00.0809171142290.12947@q7.q7.com>
References: <alpine.LRH.2.00.0809161716010.13560@q7.q7.com>
	<1221621937.3001.3.camel@raven.themaw.net>
	<alpine.LRH.2.00.0809170858590.29177@q7.q7.com>
	<1221668372.3001.28.camel@raven.themaw.net>
	<alpine.LRH.2.00.0809170920230.12947@q7.q7.com>
	<1221669383.3001.35.camel@raven.themaw.net>
	<x49od2m7m88.fsf@segfault.boston.devel.redhat.com>
	<alpine.LRH.2.00.0809171021540.12947@q7.q7.com>
	<x49prn2br6i.fsf@segfault.boston.devel.redhat.com>
	<alpine.LRH.2.00.0809171049520.12947@q7.q7.com>
	<x49d4j2bqft.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49d4j2bqft.fsf@segfault.boston.devel.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

> Details would be welcome.  The biggest offender we found was that the
> portmapper interfaces would use reserved ports.  That is simply not
> necessary, and those issues have been fixed in autofs and mount.nfs.  In
> fact, we've got regression tests that make sure that this is the case.

yes, i have found that as well.  i think the biggest consumer is ypserv 
tcp connections for doing a full map dump.

here is my rpcinfo:

    program vers proto   port
     100000    2   tcp    111  portmapper
     100000    2   udp    111  portmapper
     100024    1   udp    844  status
     100024    1   tcp    847  status
     100004    2   udp    994  ypserv
     100004    1   udp    994  ypserv
     100004    2   tcp    997  ypserv
     100004    1   tcp    997  ypserv
     100007    2   udp   1007  ypbind
     100007    1   udp   1007  ypbind
     100007    2   tcp   1010  ypbind
     100007    1   tcp   1010  ypbind
     100011    1   udp    835  rquotad
     100011    2   udp    835  rquotad
     100011    1   tcp    838  rquotad
     100011    2   tcp    838  rquotad
     100003    2   udp   2049  nfs
     100003    3   udp   2049  nfs
     100003    4   udp   2049  nfs
     100003    2   tcp   2049  nfs
     100003    3   tcp   2049  nfs
     100003    4   tcp   2049  nfs
     100021    1   udp  39755  nlockmgr
     100021    3   udp  39755  nlockmgr
     100021    4   udp  39755  nlockmgr
     100021    1   tcp  32773  nlockmgr
     100021    3   tcp  32773  nlockmgr
     100021    4   tcp  32773  nlockmgr
     100005    1   udp    852  mountd
     100005    1   tcp    855  mountd
     100005    2   udp    852  mountd
     100005    2   tcp    855  mountd
     100005    3   udp    852  mountd
     100005    3   tcp    855  mountd
