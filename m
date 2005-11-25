From: Ian Kent <raven@themaw.net>
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Fri, 25 Nov 2005 10:22:27 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0511251021100.3517@wombat.indigo.net.au>
References: <1132670358.4039.37.camel@brilong-lnx>
	<1132674350.4039.52.camel@brilong-lnx>
	<Pine.LNX.4.63.0511222351130.9982@donald.themaw.net>
	<Pine.LNX.4.63.0511231359220.20045@simba.math.ucla.edu>
	<x3kiruhbkzh.fsf@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x3kiruhbkzh.fsf@Psilocybe.Update.UU.SE>
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
To: Thorild Selen <thorild@Update.UU.SE>
Cc: autofs@linux.kernel.org

On Fri, 25 Nov 2005, Thorild Selen wrote:

> jimc@math.ucla.edu (Jim Carter) writes:
> > [...] Or since userspace has to obtain the whole map anyway to
> > recognize deletions, maybe it should cache the map, but only in the
> > case of browsing should it install every row in the kernel.
> 
> I believe that LCUP (LDAP Client Update Protocol, RFC 3928) could be
> used for this purpose. This LDAP extension would make it possible for
> a client to request the server to notify it of any modifications to a
> map, including deletion of entries.
> 
> This only applies to LDAP of course, and far from all LDAP servers
> support LCUP. However, situations like this look like just what LCUP
> was designed for.

But, at this stage, autofs isn't going to be listening it's going to be 
asking?

Ian
