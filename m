From: raven@themaw.net
Subject: Re: Proposal for map refresh logic
Date: Mon, 14 Jun 2004 22:52:11 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406142249350.16281@donald.themaw.net>
References: <Pine.LNX.4.58.0405212143160.1592@donald.themaw.net>
 <Pine.LNX.4.58.0405210855001.28570@simba.math.ucla.edu>
 <Pine.LNX.4.58.0405221120001.1524@donald.themaw.net>
 <Pine.LNX.4.58.0405231647030.4243@xena.cft.ca.us>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405231647030.4243@xena.cft.ca.us>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Sun, 23 May 2004, Jim Carter wrote:

> 
> Forgive my meager kernel knowledge, but even if opendir is the same for
> both uses, isn't there a separate object method implementing readdir,
> versus looking up a file by name?  Readdir should bypass the cache, reading 
> the NIS or LDAP map directly, while lookup should and does use the cache.
>

Yes. A directory inode gets assigned the directory methods.

Ian
