From: Joe Pruett <joey@clean.q7.com>
Subject: Re: latest autofs from centos 4
Date: Wed, 17 Sep 2008 09:22:18 -0700 (PDT)
Message-ID: <alpine.LRH.2.00.0809170920230.12947@q7.q7.com>
References: <alpine.LRH.2.00.0809161716010.13560@q7.q7.com>
	<1221621937.3001.3.camel@raven.themaw.net>
	<alpine.LRH.2.00.0809170858590.29177@q7.q7.com>
	<1221668372.3001.28.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1221668372.3001.28.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

>> i was to onervous to try the real patch for now.  so i just quickly hacked
>> in another buffer using the MAX_IFC_LEN.  so far it seems to be happy.  i
>> guess i'll find out about the new malloc setup when i go to 5.3.
>
> Don't get me wrong, I think your caution is a sensible and responsible
> approach to an unknown patch. I understand this only too well.

on my server with 1000 ips, the ip i care about is near the front, so 2048 
is plenty big enough to find it.

i am still having some kind of issue where at boot time, it can't seem to 
find a server or talk to mountd or something like that and then won't try 
again.  it looks like maybe this is the negative caching feature?  is that 
new as well?
