From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: autofs 5.0.1-rc1 still doesn't find master map in ldap
 automatically
Date: Fri, 25 Aug 2006 14:25:57 +0200
Message-ID: <44EEEC55.2040101@inria.fr>
References: <44EDB98B.8050201@inria.fr>
	<Pine.LNX.4.64.0608250923480.6382@raven.themaw.net>
	<44EEA538.8090203@inria.fr>
	<Pine.LNX.4.64.0608251920210.30523@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608251920210.30523@raven.themaw.net>
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
>> I'll try to run it in the debugger, but I have to fix my debug package
>> first.
gdbdoesn't complain anymore about missing symbols, but despite my
attempts, I've been unable to set a working break point on faulty
function (get_query_dn).

> Can you give a couple of examples of you LDAP entries please.
Here it is:

# autofs, village.inria.fr
dn: ou=autofs,dc=village,dc=inria,dc=fr
ou: autofs
objectClass: top
objectClass: organizationalUnit

# auto.master, autofs, village.inria.fr
dn: ou=auto.master,ou=autofs,dc=village,dc=inria,dc=fr
objectClass: top
objectClass: automountMap
ou: auto.master

# /home/beaune, auto.master, autofs, village.inria.fr
dn: cn=/home/beaune,ou=auto.master,ou=autofs,dc=village,dc=inria,dc=fr
objectClass: top
objectClass: automount
cn: /home/beaune
automountInformation:
ldap:ou=auto.home.beaune,ou=autofs,dc=village,dc=inria,d
 c=fr

# /home/yquem, auto.master, autofs, village.inria.fr
dn: cn=/home/yquem,ou=auto.master,ou=autofs,dc=village,dc=inria,dc=fr
objectClass: top
objectClass: automount
cn: /home/yquem
automountInformation:
ldap:ou=auto.home.yquem,ou=autofs,dc=village,dc=inria,dc
 =fr

# /net/yquem, auto.master, autofs, village.inria.fr
dn: cn=/net/yquem,ou=auto.master,ou=autofs,dc=village,dc=inria,dc=fr
objectClass: top
objectClass: automount
cn: /net/yquem
automountInformation:
ldap:ou=auto.net.yquem,ou=autofs,dc=village,dc=inria,dc=
 fr

etc...
-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
