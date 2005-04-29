From: Ian Kent <raven@themaw.net>
Subject: Re: Quick question about parsing
Date: Fri, 29 Apr 2005 09:53:17 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504290951140.4749@wombat.indigo.net.au>
References: <20050428142948.GP7317@lenin.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050428142948.GP7317@lenin.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Peter C. Norton" <spacey-autofs@lenin.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 28 Apr 2005, Peter C. Norton wrote:

> Does anyone know if there's a documented behaviour if the same key
> appears more than once in a map?  First, last, all?

This has been discussed a bit lately.

My current understanding is that the first encountered entry should take 
precedence.

> 
> I'm trying to fix an issue in the NIS+ module, and I want to make sure
> I'm doing what the documentation says I should.
> 
> Thanks,
> 
> -Peter
> 
> -- 
> The 5 year plan:
> In five years we'll make up another plan.
> Or just re-use this one.
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
