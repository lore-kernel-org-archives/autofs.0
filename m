From: Ian Kent <raven@themaw.net>
Subject: Re: bind mounts apparently not working
Date: Mon, 25 Feb 2008 11:33:56 +0900
Message-ID: <1203906836.3087.27.camel@raven.themaw.net>
References: <alpine.LRH.0.9999.0802240858190.1590@vger.vgersoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LRH.0.9999.0802240858190.1590@vger.vgersoft.com>
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


On Sun, 2008-02-24 at 09:13 -0500, Steve Thompson wrote:
> Everything works fine, but doing, for example, a large "make -j2" within 
> /fs/home/username results in several nfsd threads consuming approximately 
> 80% of one CPU, and performance drops through the floor. Autofs not 
> recognizing the server-fqdn as the name corresponding to the primary IP on 
> each interface? Worked properly with autofs4. Thoughts? TIA,

What does "getent <the-ip-address>" return?

Ian
