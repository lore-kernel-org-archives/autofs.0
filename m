From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] small patch for documenting weighted maps
Date: Tue, 25 Jan 2005 09:05:00 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0501250904250.21644@wombat.indigo.net.au>
References: <41F56D27.1080005@redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <41F56D27.1080005@redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Feist <cfeist@redhat.com>
Cc: autofs@linux.kernel.org

On Mon, 24 Jan 2005, Chris Feist wrote:

> In the linux automounter if you have something like this in a map file:
> 
> /test  hosta(10):/export localhost(20):/export hostb(30):/export
> 
> the automounter will ignore the weighting and always pick the localhost. 
> The Sun automounter also behaves in this way.  The patch I'm submitted 
> just clarifies the documentation so the user is not surprised when it 
> happens.
>

Thanks Chris

I'll apply this as well.

Ian
