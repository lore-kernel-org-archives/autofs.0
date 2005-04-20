From: Jeff Layton <jtlayton@poochiereds.net>
Subject: Re: replicated mounts patch
Date: Tue, 19 Apr 2005 21:30:13 -0400
Message-ID: <1113960613.5879.14.camel@tleilax.poochiereds.net>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net>
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net>
	<1113941787.1274.84.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.58.0504200922220.7460@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504200922220.7460@wombat.indigo.net.au>
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
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Wed, 2005-04-20 at 09:25 +0800, Ian Kent wrote:
> But, I've had complaints about it in the past.
> Call it an added feature.
> 
> If we choose to not require it we will need to be clear about it in the 
> doco. 
> 
> Personally, I like to be able to add a space after each comma for 
> readability.
> 
> Ian
> 

It's certainly possible to do it, but will probably require rewriting
the entire parser since my current approach probably won't work if we
allow for it. Using POSIX regex'es might make it easier, but I'll need
to look at how you use them under C.
-- Jeff
