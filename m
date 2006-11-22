From: Ian Kent <raven@themaw.net>
Subject: Re: Automount with a local NFS export and a remote
	NFS	export using the same mount path name over LDAP
Date: Wed, 22 Nov 2006 17:18:48 +0800
Message-ID: <1164187128.9969.7.camel@localhost>
References: <E2AC825D4FC7764DA86D9C8ECA27A2DE065AFA@catoexm05.noam.corp.platform.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E2AC825D4FC7764DA86D9C8ECA27A2DE065AFA@catoexm05.noam.corp.platform.com>
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
To: Shawn Starr <sstarr@platform.com>
Cc: autofs@linux.kernel.org

On Tue, 2006-11-21 at 15:12 -0500, Shawn Starr wrote:
> Hi Jeff, Here's what I'm trying to do:
> 
> On a local machine (10.1.1.75) I have the following configuration:
> 
> /etc/exports:
> =========
> /export 10.0.0.0/255.0.0.0(rw,async)
> 
> 
> /etc/auto.home:
> ===========
> 
> install         10.1.1.75:/export/home/&
> +auto.home
> 
> /etc/auto.master:
> ============
> /home  /etc/auto.home --ghost
> 
> On the local machine, /home is NFS exported so: /home/install is visible when using automount.
> 
> 
> On a remote machine (somehostname.platform.com) I have the following configuration:
> 
> /etc/exports:
> =========
> /home   *(rw,async)
> 
> 
> auto.master: LDAP map
> ===============
> 
> dn: ou=autofs,dc=platform,dc=com
> objectClass: top
> objectClass: organizationalUnit
> ou: autofs
> 
> dn: ou=auto.master,ou=autofs,dc=platform,dc=com
> objectClass: top
> objectCLass: automountMap
> ou: auto.master
> 
> dn: cn=/home,ou=auto.master,ou=autofs,dc=platform,dc=com
> objectClass: top
> objectClass: automount
> cn: /home
> automountInformation: ldap:ou=auto.home,ou=autofs,dc=platform,dc=com
> 
> auto.home:  LDAP map
> ===============
> 
> dn: ou=auto.home,ou=autofs,dc=platform,dc=com
> objectClass: top
> objectClass: automountMap
> ou: auto.home
> 
> dn: cn=sstarr,ou=auto.home,ou=autofs,dc=platform,dc=com
> objectClass: top
> objectClass: automount
> cn: sstarr
> automountInformation: -fstype=nfs,hard,intr,nodev,nosuid somehostname.platform.com:/home:&
-----------------------------------------------------------------------------------------^
What's this?

I don't understand what your trying to do either!
Tell me, on "remote machine" how should the exported /home filesystem be
accessible after an autofs filesystem is mounted over the top of it.

Or am I missing something in this description.

Ian
