From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: autofs 5.0.1-rc1 still doesn't find master map in ldap
 automatically
Date: Fri, 25 Aug 2006 18:04:05 +0200
Message-ID: <44EF1F75.5090902@inria.fr>
References: <44EDB98B.8050201@inria.fr>
	<Pine.LNX.4.64.0608250923480.6382@raven.themaw.net>
	<44EEA538.8090203@inria.fr>
	<Pine.LNX.4.64.0608251920210.30523@raven.themaw.net>
	<44EEEC55.2040101@inria.fr>
	<Pine.LNX.4.64.0608252033290.30811@raven.themaw.net>
	<44EEF1E6.7040008@inria.fr>
	<1156511928.30971.12.camel@raven.themaw.net>
	<1156512652.30971.19.camel@raven.themaw.net>
	<44EF1747.5010103@inria.fr> <E1GGe66-00006L-00@mta2.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1GGe66-00006L-00@mta2.cl.cam.ac.uk>
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
To: autofs@linux.kernel.org

Piete.Brooks--autofs@cl.cam.ac.uk wrote:
>> OK, I found the issue: when all you have is mapname, and you have to use
>> default server and base, you should use LDAP_SCOPE_SUBTREE scope for
>> your query, not LDAP_SCOPE_ONELEVEL
> 
> Why?
Because using LDAP_SCOPE_ONELEVEL assume your master map is directly
beyond your default base, which is likely to be wrong.

> As I said before, it works for me as it is. I see no need to change it.
> 
> I've just had my wrist slapped for suggesting doing three queries for the 
> three "common" schemas, so changing from a one level search (which should be 
> very fast as I'd not expect much at the top level) to searching the WHOLE tree 
> (which I expect to be several orders of magnitude slower) would seem not to be 
> a good idea.
Only once, for the initial master map lookup, and only if no explicit
map name has been given.

> 
> If you do the search manually, does it work?
Yes, because ldapsearch default's scope is sub.

> Are the two programmes using the same conf file (e.g. std /etc/ldap.conf vs 
> /etc/openldap/ldap.conf)?
of course. ldap client use ldap library, as does automount.
-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
