From: raven@themaw.net
Subject: Re: Proposal for map refresh logic
Date: Mon, 14 Jun 2004 22:48:49 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406142246320.16281@donald.themaw.net>
References: <Pine.LNX.4.58.0405212143160.1592@donald.themaw.net>
 <Pine.LNX.4.58.0405210855001.28570@simba.math.ucla.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405210855001.28570@simba.math.ucla.edu>
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

On Fri, 21 May 2004, Jim Carter wrote:

> 
> > For a a cache hit we can:
> > 
> > 1. Check if the map entry has exceeded a given time to live, say
> >    the map expire time.
> > 2. If not continue as normal otherwise lookup the individual map
> >    entry and compare it to the cached entry.
> > 3. If they are identical continue as normal otherwise it's a hint
> >    the map has changed so re-read it.
> 
> Suggestion: set a flag saying "we know that this map is out of date", but 
> only re-read the whole thing when userspace expects to see up-to-date ghost 
> mounts.  Understood, that to read any one row from a file map you have to 
> read the whole thing; the suggestion makes a difference only for NIS and 
> LDAP -- where it makes a big difference.
> 

What were you thinking of as defining "out of date" Jim?

Ian
