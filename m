From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Proposal for map refresh logic
Date: Thu, 17 Jun 2004 09:56:15 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406170951550.18774@simba.math.ucla.edu>
References: <Pine.LNX.4.58.0405212143160.1592@donald.themaw.net>
 <Pine.LNX.4.58.0405210855001.28570@simba.math.ucla.edu>
 <Pine.LNX.4.58.0406142246320.16281@donald.themaw.net>
 <Pine.LNX.4.58.0406141255550.3683@xena.cft.ca.us>
 <Pine.LNX.4.58.0406150926540.6253@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406150926540.6253@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 15 Jun 2004, Ian Kent wrote:

> On Mon, 14 Jun 2004, Jim Carter wrote:
> > Item 3 -- we did the NIS lookup on this one entry because the TTL had
> > expired, and NIS gave a different answer than the cache, so every cached
> > entry from that map is probably wrong.  But there's no need to read the
> > whole map; just clear the cached entries that came from it (except the one
> > just read, known to be up to date).
> 
> One thing I had in mind with this is that map updates are generally small, 
> a few records or so.

Only a few records change at any one time.  But which ones changed?  The
only way the client (automounter) can find out is to read the whole map.  
Even NIS itself uploads the whole map every time to its slave servers,
although NIS+ has an incremental update feature.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
