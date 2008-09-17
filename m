From: Ian Kent <raven@themaw.net>
Subject: Re: latest autofs from centos 4
Date: Thu, 18 Sep 2008 00:36:23 +0800
Message-ID: <1221669383.3001.35.camel@raven.themaw.net>
References: <alpine.LRH.2.00.0809161716010.13560@q7.q7.com>
	<1221621937.3001.3.camel@raven.themaw.net>
	<alpine.LRH.2.00.0809170858590.29177@q7.q7.com>
	<1221668372.3001.28.camel@raven.themaw.net>
	<alpine.LRH.2.00.0809170920230.12947@q7.q7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LRH.2.00.0809170920230.12947@q7.q7.com>
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
To: Joe Pruett <joey@clean.q7.com>
Cc: autofs@linux.kernel.org

On Wed, 2008-09-17 at 09:22 -0700, Joe Pruett wrote:
> >> i was to onervous to try the real patch for now.  so i just quickly hacked
> >> in another buffer using the MAX_IFC_LEN.  so far it seems to be happy.  i
> >> guess i'll find out about the new malloc setup when i go to 5.3.
> >
> > Don't get me wrong, I think your caution is a sensible and responsible
> > approach to an unknown patch. I understand this only too well.
> 
> on my server with 1000 ips, the ip i care about is near the front, so 2048 
> is plenty big enough to find it.

Hehe, but the ioctl will fail with that many interfaces so you'll still
have the same problem. You would need to make the buffer larger than 42k
for this case.

The patch I sent was for version 5 but should be the same for recent
versions of RHEL-4 v4. It may need some work.

> 
> i am still having some kind of issue where at boot time, it can't seem to 
> find a server or talk to mountd or something like that and then won't try 
> again.  it looks like maybe this is the negative caching feature?  is that 
> new as well?

Jeff is more familiar with the RHEL-4 v4 code than I am, I'll have to
leave this to him. In any case we'd need to see a debug log.

Ian
