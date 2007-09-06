From: Ian Kent <raven@themaw.net>
Subject: Re: basedn in /etc/sysconfig/autofs
Date: Thu, 06 Sep 2007 11:41:01 +0800
Message-ID: <1189050061.3102.27.camel@raven.themaw.net>
References: <46DE1128.2020109@oracle.com>
	<1188994602.3119.5.camel@raven.themaw.net>
	<46DF5F67.7030901@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46DF5F67.7030901@oracle.com>
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
To: wengang wang <wen.gang.wang@oracle.com>
Cc: autofs@linux.kernel.org

On Thu, 2007-09-06 at 10:01 +0800, wengang wang wrote:
> Hi Ian,
> 
> here is the exchangings:

It's not clear from this what the problem is.

snip ...

> *** PLAKDAWA  08/14/07 02:06 pm *** 
> Just to give you a little more information: Our automount schema is
> based on 
> the "automountmapname", "automountkey" and "automountinformation"
> attributes. 
> This works properly with the relevant settings in
> the /etc/sysconfig/autofs 
> file on RHEL5 if the basedn is set manually in
> the /etc/openldap/ldap.conf 

But doesn't work if you don't set basdn in ldap.conf?
Are you saying that there are multiple master maps and maps of the same
name under different basedns in this setup?

> file. However, since the openldap/ldap.conf file can be used by other 
> applications, we don't want our automounter's basedn to depend on
> this. 
> 
> The LDAP attributes of the automount maps are as shown below: 
> 
> [porus@rattlebag ~]$ ldapsearch -LLL -x -b 
> "ou=sc,ou=ca,ou=na,dc=hyperion,dc=com"
> "automountmapname=auto_nfshome" 
> dn:
> automountMapName=auto_nfshome,ou=sc,ou=ca,ou=na,dc=hyperion,dc=com 
> objectClass: top 
> objectClass: automountMap 
> automountMapName: auto_nfshome 
>   
> [porus@rattlebag ~]$ ldapsearch -LLL -x -b 
> "automountmapname=auto_nfshome,ou=sc,ou=ca,ou=na,dc=hyperion,dc=com" 
> "automountkey=plakdawa" 
> dn: 
> automountkey=plakdawa,automountMapName=auto_nfshome,ou=sc,ou=ca,ou=na,dc=h 
>  yperion,dc=com 
> automountInformation: scfs3:/vol/vol2/homes/& 
> automountKey: plakdawa 
> objectClass: top 
> objectClass: automount 

snip ...

> *** PLAKDAWA  08/20/07 11:51 am *** 
> The other issue with the DEFAULT_MASTER_MAP_NAME is that providing the full 
> URL, will prevent the failover to the secondary LDAP server should the one 
> mentioned in the URL fail. Or is it possible to add secondary entries?

It's possible to specify the map (master or other) without the server
name.

eg.
MASTER_MAP_NAME="ou=auto.master,dc=themaw,dc=net"

This will then use the above basedn for finding the master map.

However, this can't be used when autofs searches for the basedn for the
maps referred to in the above master map which may not be a sensible
thing to do but cannot be practically done another way. 

The only workaround for this at the moment would be to specify the
basedn in the master map entries as well as in the master map as above.

eg.
# /ldap, auto.master, themaw.net
dn: cn=/ldap,ou=auto.master,dc=themaw,dc=net
objectClass: automount
cn: /ldap
automountInformation: ou=auto.indirect,dc=themaw,dc=net

Ian
