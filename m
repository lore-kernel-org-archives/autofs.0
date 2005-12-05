From: Ian Kent <raven@themaw.net>
Subject: Re: OpenSolaris code importation
Date: Mon, 5 Dec 2005 09:32:04 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0512050930020.26570@wombat.indigo.net.au>
References: <7F0AA25C9B1706448E8B73DFDD109B31017DED98@EXCHANGE.TIGR.ORG>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <7F0AA25C9B1706448E8B73DFDD109B31017DED98@EXCHANGE.TIGR.ORG>
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
To: "Gomez, Daniel" <dgomez@tigr.org>
Cc: autofs@linux.kernel.org

On Thu, 1 Dec 2005, Gomez, Daniel wrote:

> I was wondering, now that solaris is opensource are there any plans of
> importing some of the functionality found only in the solaris version
> for linux?

I have looked briefly at it but I shouldn't have due to the licencing.

Fortuneately it's different enough to not influence Linux autofs.

>  
> (For example, solaris can will lookup both local file and ldap maps for
> a single mount space and will allow one to override the settings for the
> other, but in linux the first db location found for the particular mount
> point in question is used exclusively and thus forcing you to use either
> purely local file maps or ldap maps for the same name space. Thus if you
> have a site wide ldap automount policy but wish to override say the
> write permission for a subset of hosts through a local configuration
> file you can't. I don't expect an answer for this problem, but it did
> cause me to wonder raise the question above.)
> 

Coming hopefully.
First the basic functionality needs to be completed.

Ian
