From: Ian Kent <raven@themaw.net>
Subject: Re: replicated mounts patch
Date: Wed, 20 Apr 2005 09:21:13 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504200917480.7460@wombat.indigo.net.au>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net> 
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com> 
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net> 
	<1113933871.1274.56.camel@barsoom.rdu.redhat.com> 
	<16997.22261.125769.972792@segfault.boston.redhat.com> 
	<1113940219.1274.70.camel@barsoom.rdu.redhat.com> 
	<16997.25295.980046.503116@segfault.boston.redhat.com>
	<1113941338.1274.79.camel@barsoom.rdu.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1113941338.1274.79.camel@barsoom.rdu.redhat.com>
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
To: Jeffrey Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org

On Tue, 19 Apr 2005, Jeffrey Layton wrote:

> > If the documentation for the Linux automounter conflicts with that of Sun,
> > I would say it is a bug.  Let's fix it.
> > 
> > -Jeff
> > 
> 
> Ahh, I didn't check the Solaris docs. Yes, README.replicated_mounts is
> definitely incorrect then. If/when this patch goes in, I'll plan to
> rewrite that as well to explain the new code.

That documentation came from the original patch.
Having had so much trouble with it I probably should have rewrote it 
wholesale long ago. 

We'll change the documentation to match the implementation when were done.

Ian
