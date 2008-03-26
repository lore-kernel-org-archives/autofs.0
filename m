From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Long timeout on broken DNS server
Date: Tue, 25 Mar 2008 20:34:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0803252017580.12176@xena.cft.ca.us>
References: <20080320050635.E2FA33C3B0@xena.cft.ca.us> 
	<1205995564.30292.10.camel@raven.themaw.net>
	<Pine.LNX.4.64.0803200846190.16309@simba.math.ucla.edu>
	<1206329131.2993.3.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1206329131.2993.3.camel@raven.themaw.net>
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

On Mon, 24 Mar 2008, Ian Kent wrote:
> On Thu, 2008-03-20 at 08:51 -0700, Jim Carter wrote:
> > On Thu, 20 Mar 2008, Ian Kent wrote:
> > > On Wed, 2008-03-19 at 22:06 -0700, Jim Carter wrote:
> > > > Today I upgraded one of my three DNS servers, the first listed in
> > > > /etc/resolv.conf, and until I got it back on the air, autofs mounting
> > > > was glacial...
--snip--
> 
> Try this patch and let me know what happens.
> Not sure it will actually make much difference.
> I've made it against the autofs in opensuse, revision 30.2.

Patch and build were clean.  I installed it on a machine running 
autofs-5.0.2-30.2 and it worked.  To test, I prepended to /etc/resolv.conf 
a nameserver (IP address) which was known to not exist, and then 
automounted something.  This took 10.093 secs elapsed, corresponding to one 
timeout (default length 5 secs) when autofs resolves the hostname, and a 
second timeout when mount resolves the name.  This is the best that can be 
done.  

Thanks very much for looking into this!  When the lead nameserver dies the 
user experience will be much improved, even if not perfect.  

I think the real solution is for us to have a forwarding nameserver on 
every Linux box.  /etc/resolv.conf would point only to it.  BIND learns 
which forwarder gives the quickest response, so when that one is lost the 
situation is self-healing, in contrast to resolv.conf which has no memory.  

The only problem is with Windows: it only has an equivalent of
resolv.conf.  But it would be pointing to the domain controller(s), which 
forward to the Linux DNS servers.  I hope the Windows DNS server can 
re-order the forwarders like BIND can.  In our "experiment" it wasn't 
possible to tell one way or the other due to not properly using the 
available redundancy.  

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
