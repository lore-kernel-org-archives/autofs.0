From: Ian Kent <raven@themaw.net>
Subject: Re: autofs and ldap
Date: Tue, 13 May 2008 11:15:11 +0800
Message-ID: <1210648511.3006.129.camel@raven.themaw.net>
References: <482059CB.8050808@cptec.inpe.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <482059CB.8050808@cptec.inpe.br>
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
To: Luciana Romeiro Rodrigues <luciana.romeiro@cptec.inpe.br>
Cc: autofs@linux.kernel.org


On Tue, 2008-05-06 at 10:14 -0300, Luciana Romeiro Rodrigues wrote:
> Hi!
> I run SLES 10.0 with openldap-stable-20071118.
> 
> Could anyone offer me some advice, or point me in the right direction?

Provide the information, not already included here, specified at
http://people.redhat.com/jmoyer.

> 
> Thanks,
> 
> Luciana
> 
> 
> 
> Follows the settings:
> 
> 
> 1- /etc/nsswitch.conf:
> automount: ldap
> 
> 2- ldif:
> 
> dn: ou=automount,dc=cp,dc=br
> ou: automount
> objectClass: top
> objectClass: organizationalUnit
> 
> dn: ou=auto.master,ou=automount,dc=cp,dc=br
> ou: auto.master
> objectClass: top
> objectClass: automountMap
> 
> dn: cn=/home, ou=auto.master,ou=automount,dc=cp,dc=br
> objectClass: top
> objectClass: automount
> automountInformation: ldap:
> server-ldap.cp.br:ou=auto.home,ou=automount,dc=
> cp,dc=br
> cn: /home
> 
> dn: ou=auto.home, ou=automount,dc=cp,dc=br
> ou: auto.home
> objectClass: top
> objectClass: automountMap
> 
> 
> Users:
> 
> dn: uid=lu,ou=auto.home,ou=automount,dc=cp,dc=br
> uid: lu
> cn: teste
> objectClass: automount
> automountInformation: -rw,soft,retrans=10,intr
> nfsserver.cp.br:/extra/home/lu
> 
> 3- /etc/ldap.conf
> 
> host    127.0.0.1 
> base    dc=cp,dc=br
> 
> 
> 4-
> 
> 
> tembiru:/home # service autofs status
> 
> Checking for service autofs:
> unused
> 
> Configured Mount Points:
> 
> ------------------------
> 
> /usr/sbin/automount  /home ldap:
> "server-ldap.cp.br:ou=auto.home,ou=automount,dc=cp,dc=br"
> 
> Active Mount Points:
> 
>  
> 
> 5- su - lu
>  warning: cannot change directory to /home/lu: No such file or
> directory
> 
> 
> 
> 
> -- 
> ========================================================
> Luciana F.Romeiro Rodrigues
> Analista de Suporte
> Fone: 3186-8513 - 
> 
> Novo Email: luciana.romeiro@cptec.inpe.br
> ========================================================
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
