From: Ian Kent <raven@themaw.net>
Subject: Re: bind mounts apparently not working
Date: Mon, 25 Feb 2008 21:13:57 +0900
Message-ID: <1203941638.3087.81.camel@raven.themaw.net>
References: <alpine.LRH.0.9999.0802240858190.1590@vger.vgersoft.com>
	<1203906836.3087.27.camel@raven.themaw.net>
	<alpine.LRH.0.9999.0802250621050.22906@vger.vgersoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LRH.0.9999.0802250621050.22906@vger.vgersoft.com>
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
To: Steve Thompson <smt@vgersoft.com>
Cc: autofs@linux.kernel.org


On Mon, 2008-02-25 at 06:33 -0500, Steve Thompson wrote:
> On Mon, 25 Feb 2008, Ian Kent wrote:
> 
> >
> > On Sun, 2008-02-24 at 09:13 -0500, Steve Thompson wrote:
> >> Everything works fine, but doing, for example, a large "make -j2" within
> >> /fs/home/username results in several nfsd threads consuming approximately
> >> 80% of one CPU, and performance drops through the floor. Autofs not
> >> recognizing the server-fqdn as the name corresponding to the primary IP on
> >> each interface? Worked properly with autofs4. Thoughts? TIA,
> >
> > What does "getent <the-ip-address>" return?
> 
> Aha!
> 
> "getent hosts <ip>" returns the FQDN of the server for two of the three IP 
> addresses (the exact same string as the server name in the map), but the 
> FQDN _and_ the unqualified name for the third IP address. This was because 
> of the setup of the NIS hosts map. On removing the NIS hosts map, and 
> using DNS alone, autofs now does bind mounts properly. Interestingly, this 
> NIS hosts map had been like this for a looong time, and I had forgotten 
> about it; it did not cause autofs4 any problems. Thank you!

That's because v4 doesn't check the each interface to determine if the
hostname is really local.

Ian
