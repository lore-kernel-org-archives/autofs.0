From: Ian Kent <raven@themaw.net>
Subject: Re: multi-level deep ldap automount possible?
Date: Thu, 05 Jun 2008 15:55:02 +0800
Message-ID: <1212652503.3047.64.camel@raven.themaw.net>
References: <10badf220806042312p6ca4adf0h5836a8e046f2075a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <10badf220806042312p6ca4adf0h5836a8e046f2075a@mail.gmail.com>
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
To: Shane <squindler@gmail.com>
Cc: autofs@linux.kernel.org


On Thu, 2008-06-05 at 15:42 +0930, Shane wrote:
> Hello,
> 
> Hoping someone can help me figure out if its possible to do
> multi-level deep automounts via ldap. I've seen a few examples of this
> using files but can't get it to work using LDAP.
> 
> eg I want:
> server1:/export/protemp  -  /nfs/tmp/production
> server2:/export/tmp/weekly  -  /nfs/tmp/weekly
> server2:/export/tmp/hourly  -  /nfs/tmp/hourly
> 

It isn't clear what you're saying.

> pseudo ldap implementation
> cn=nfs,ou=auto.master: ldap: ou=auto.nfs  objectClass = automountMap

Do you mean something like:

dn: ou=auto.master,dc=bogus
objectClass: top
objectClass: automountMap
ou: ldap:ou=auto.master

dn: cn=/nfs/tmp,ou=auto.master,dc=bogus
objectClass: automount
cn: /nfs/tmp
automountInformation: ldap:ou=auto.tmp

which might not work, I can't remember, there is one case where a
partial dn doesn't work, you'll need to test it out. This is a master
map entry so you need to use the path to the indirect mount, /nfs/tmp.

> cn=tmp,ou=auto.nfs: ldap ou=outo.tmp,ou=auto.nfs  objectClass = automount
> ou=auto.tmp,ou=auto.nfs: objectClass automountMap
> cn=production,ou=auto.tmp,ou=auto.nfs: -rw,hard,intr,tcp
> server1:/export/protemp  objectClass = automount

I have no idea what you're trying to say above.

Perhaps this is close to what you're looking for:

dn: ou=auto.tmp,dc=bogus
objectClass: top
objectClass: automountMap
ou: auto.tmp

dn: cn=production,ou=auto.tmp,dc=bogus
objectClass: automount
cn: production
automountInformation:   server1:/export/protemp

dn: cn=weekly,ou=auto.tmp,dc=bogus
objectClass: automount
cn: weekly
automountInformation:   server1:/export/tmp/weekly

dn: cn=hourly,ou=auto.tmp,dc=bogus
objectClass: automount
cn: hourly
automountInformation:   server1:/export/tmp/hourly

This is the indirect map so you must use keys that correspond to the
mount point directories, not a path.

Ian
