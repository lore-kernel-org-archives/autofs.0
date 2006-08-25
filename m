From: Ian Kent <raven@themaw.net>
Subject: Re: autofs 5.0.1-rc1 still doesn't find master map in	ldap
	automatically
Date: Sat, 26 Aug 2006 01:28:52 +0800
Message-ID: <1156526932.31377.17.camel@raven.themaw.net>
References: <44EDB98B.8050201@inria.fr>
	<Pine.LNX.4.64.0608250923480.6382@raven.themaw.net>
	<44EEA538.8090203@inria.fr>
	<Pine.LNX.4.64.0608251920210.30523@raven.themaw.net>
	<44EEEC55.2040101@inria.fr>
	<Pine.LNX.4.64.0608252033290.30811@raven.themaw.net>
	<44EEF1E6.7040008@inria.fr>
	<1156511928.30971.12.camel@raven.themaw.net>
	<1156512652.30971.19.camel@raven.themaw.net>
	<44EF1747.5010103@inria.fr>
	<E1GGe66-00006L-00@mta2.cl.cam.ac.uk>  <44EF1F75.5090902@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44EF1F75.5090902@inria.fr>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

On Fri, 2006-08-25 at 18:04 +0200, Guillaume Rousse wrote:
> Piete.Brooks--autofs@cl.cam.ac.uk wrote:
> >> OK, I found the issue: when all you have is mapname, and you have to use
> >> default server and base, you should use LDAP_SCOPE_SUBTREE scope for
> >> your query, not LDAP_SCOPE_ONELEVEL
> > 
> > Why?
> Because using LDAP_SCOPE_ONELEVEL assume your master map is directly
> beyond your default base, which is likely to be wrong.

Ha, of course, and I thought that would be more efficient.
Pity it just doesn't work.

I'll fix it.

Ian
