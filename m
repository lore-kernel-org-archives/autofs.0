From: Joe Pruett <joey@clean.q7.com>
Subject: Re: latest autofs from centos 4
Date: Tue, 18 Nov 2008 11:22:15 -0800 (PST)
Message-ID: <alpine.LRH.2.00.0811181114320.18255@q7.q7.com>
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
	<alpine.LRH.2.00.0811181056070.18255@q7.q7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LRH.2.00.0811181056070.18255@q7.q7.com>
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

>> Details would be welcome.  The biggest offender we found was that the
>> portmapper interfaces would use reserved ports.  That is simply not
>> necessary, and those issues have been fixed in autofs and mount.nfs.  In
>> fact, we've got regression tests that make sure that this is the case.
>
> since i had my hang last night i have dug back into this.  the big culprit
> is getgrouplist (or so it seems) that opens the group.byname map with a yp
> all call and it does that from a privileged port.  watching my mail
> server, i see it burn through priv ports at quite a rapid clip (5 per
> second or so).  i am going to see why it doesn't use the netid map.  it
> could just be glibc not having that feature.

aha!  there is a file /etc/default/nss where you can enable nis to use the 
netid map.  NETID_AUTHORITATIVE=TRUE is the key.  and that has made a huge 
difference on my server.
