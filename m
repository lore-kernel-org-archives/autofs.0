From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: autofs 5.0.1-rc1 still doesn't find master map in ldap
 automatically
Date: Fri, 25 Aug 2006 14:49:42 +0200
Message-ID: <44EEF1E6.7040008@inria.fr>
References: <44EDB98B.8050201@inria.fr>
	<Pine.LNX.4.64.0608250923480.6382@raven.themaw.net>
	<44EEA538.8090203@inria.fr>
	<Pine.LNX.4.64.0608251920210.30523@raven.themaw.net>
	<44EEEC55.2040101@inria.fr>
	<Pine.LNX.4.64.0608252033290.30811@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608252033290.30811@raven.themaw.net>
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

Ian Kent wrote:
> On Fri, 25 Aug 2006, Guillaume Rousse wrote:
> 
>> Ian Kent wrote:
>>>> I'll try to run it in the debugger, but I have to fix my debug package
>>>> first.
>> gdbdoesn't complain anymore about missing symbols, but despite my
>> attempts, I've been unable to set a working break point on faulty
>> function (get_query_dn).
> 
> Is your LDAP client able to query this stuff with only the information 
> used in the autofs queries (the ones you see in the debug output)?
Not sure to understand you here. I get nothing else in my debug output
than: failed to get query dn

Using informations from the config file, however, such as the automount
map class, I can retrieve all those maps easily from ldapsearch:
[rousse@alceste ~]$ ldapsearch -x objectClass=automountMap
# extended LDIF
#
# LDAPv3
# base <> with scope subtree
# filter: objectClass=automountMap
# requesting: ALL
#

# auto.master, autofs, village.inria.fr
dn: ou=auto.master,ou=autofs,dc=village,dc=inria,dc=fr
objectClass: top
objectClass: automountMap
ou: auto.master

# auto.home.beaune, autofs, village.inria.fr
dn: ou=auto.home.beaune,ou=autofs,dc=village,dc=inria,dc=fr
objectClass: top
objectClass: automountMap
ou: auto.home.beaune
...
# search result
search: 2
result: 0 Success

# numResponses: 7
# numEntries: 6

-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
