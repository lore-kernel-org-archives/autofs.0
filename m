From: Ian Kent <raven@themaw.net>
Subject: Re: bind mounts apparently not working
Date: Tue, 26 Feb 2008 11:01:53 +0900
Message-ID: <1203991313.3173.0.camel@raven.themaw.net>
References: <alpine.LRH.0.9999.0802240858190.1590@vger.vgersoft.com>
	<1203906836.3087.27.camel@raven.themaw.net>
	<alpine.LRH.0.9999.0802250621050.22906@vger.vgersoft.com>
	<1203941638.3087.81.camel@raven.themaw.net>
	<alpine.LRH.0.9999.0802251845440.2244@vger.vgersoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LRH.0.9999.0802251845440.2244@vger.vgersoft.com>
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


On Mon, 2008-02-25 at 18:55 -0500, Steve Thompson wrote:
> >
> > That's because v4 doesn't check the each interface to determine if the
> > hostname is really local.
> 
> Let me follow up on this a little more. The NFS server (and client) has 
> three network interfaces, with IP addresses (say) 192.168.1.1, 192.168.2.1 
> and 192.168.3.1 (netmask 255.255.255.0 for each subnet). The server's FQDN 
> is foo.domain.org. Then what I actually had was:
> 
>  	# getent hosts 192.168.1.1
>  	192.168.1.1	foo.domain.org
> 
>  	# getent hosts 192.168.2.1
>  	192.168.2.1	foo.domain.org
> 
>  	# getent hosts 192.168.3.1
>  	192.168.3.1	foo.domain.org foo
> 
> The third of these is apparently sufficient to stop autofs5 from doing a 
> bind mount. After removing the short name "foo" from the third entry, it 
> works. This doesn't seem right; after all, the FQDN of the server does 
> match one of the names for each of the entries. The NFS server name is the 
> map is "foo.domain.org". Or is that right after all?

This should work OK.
I'll check it out.
At least you have a workaround, for now.

Ian
