From: Ian Kent <raven@themaw.net>
Subject: Re: multi-level deep ldap automount possible?
Date: Thu, 05 Jun 2008 18:26:28 +0800
Message-ID: <1212661589.3047.70.camel@raven.themaw.net>
References: <10badf220806042312p6ca4adf0h5836a8e046f2075a@mail.gmail.com>
	<1212652503.3047.64.camel@raven.themaw.net>
	<10badf220806050153v3a0d3242t44e6e34b8ae3adc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <10badf220806050153v3a0d3242t44e6e34b8ae3adc@mail.gmail.com>
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


On Thu, 2008-06-05 at 18:23 +0930, Shane wrote:
> apologies that my first message wasn't as clear as I'd hoped ...
> 
> currently the setup basically is as below just with lots more mounts etc ...
> 
> dn: ou=auto.master,dc=blah
> objectClass: automountMap
> objectClass: top
> ou=auto.master
> 
> dn: cn=/nfs,ou=auto.master,dc=blah
> automountInformation: ldap:ou=auto.nfs,dc=blah
> objectClass: automount
> 
> dn: ou=auto.nfs,dc=blah
> objectClass: automountMap
> objectClass: top
> ou=auto.nfs
> 
> dn: cn=tmp,ou=auto.nfs,dc=blah
> automountInformation: -rw,hard,intr,tcp,vers=3 server1:/export/tmp
> objectClass: automount
> 
> The problem is that one or two dirs in our tmp structure have become
> project dependencies & are put under very high load which our tmp
> server can't handle - simply moving the data would be awesome but
> unfortunately the paths have been hard coded into a few apps which
> will take longer to fix & re-deploy than re-doing mount exports
> (hopefully) ...
> 
> Basically I'm trying to achieve in LDAP the equivalent of this little
> example from a files way of doing things:
> tmp    -rw,hard,intr    / -ro myserver.me.org:/ \
>            /usr myserver.me.org:/usr \
>            /home myserver.me.org:/home

If you need an explicit mount for tmp / (the root of the multi-mount
tree) you have no choice but to use a multi-mount entry.

If you don't then you can use a submount (aka -fstype=autofs) with the
location being an autofs map instead of the file system to be mounted.

> 
> I was *hoping* this [below] would work, as its a little more readable
> than jamming everything into an automountInformation attribute ...
> 
> dn: cn=tmp,ou=auto.nfs,dc=blah
> automountInformation: ldap:ou=auto.tmp,ou=auto.nfs,dc=blah
> objectClass: automount
> 
> dn: ou=auto.tmp,ou=auto.nfs,dc=blah
> objectClass: automountMap
> objectClass: top
> ou=auto.tmp
> 
> dn: cn=weekly,ou=auto.tmp,ou=auto.nfs,dc=blah
> automountInformation: -rw,hard,intr,tcp,vers=3 server1:/export/tmp/weekly
> objectClass: automount
> 
> dn: ... one for each /nfs/tmp/* mount
> 
> I guess if it comes to it
> 
> dn: cn=tmp,ou=auto.nfs,dc=blah
> automountInformation: -rw,hard,intr,tcp,vers=3  /weekly
> server1:/export/tmp/weekly  /hourly server1:/export/tmp/hourly
> /production server2:/export/prodTemp
> objectClass: automount
> 
> isn't *too* bad ...
> 
> TIA,
> Shane
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
