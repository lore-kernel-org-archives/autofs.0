From: raven@themaw.net
Subject: Re: Proposal for map refresh logic
Date: Mon, 14 Jun 2004 19:04:29 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406141857480.14098@donald.themaw.net>
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

> don't know about LDAP.  Suggestion for ghost mounts: only refresh the map 
> when a userspace process does opendir on the containing directory, as in 
> "ls /net/hostname".  In any other case, outdated or missing ghost mounts 
> cannot be seen by userspace, so let sleeping dogs lie.

I wonder how many of those opendir events are actually userspace 
requests not themselves initiated by the daemon?

I'll investigate this a little further!

What were your thoughts about frequent opendir events, many users, or just 
many ls commands?

Perhaps a map needs to be considered up to date for some amount of time 
after a map re-read?

Thoughts?

Ian
