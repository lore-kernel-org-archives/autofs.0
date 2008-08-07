From: Ian Kent <raven@themaw.net>
Subject: Re: program map | cifs | autofs4
Date: Thu, 07 Aug 2008 14:05:41 +0800
Message-ID: <1218089142.2981.6.camel@raven.themaw.net>
References: <4899BC0A.8020303@math.uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4899BC0A.8020303@math.uni-muenster.de>
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
To: Nail El-Sourani <sourani@math.uni-muenster.de>
Cc: autofs@linux.kernel.org


On Wed, 2008-08-06 at 16:58 +0200, Nail El-Sourani wrote:
> Hi Guys,
> 
> maybe some of u gurus can help. This is a mixed environment, suse10.2 
> (so im stuck with autofs4), userinfo is stored in an ldap db.
> 
> current auto.master
> # $Id: auto.master,v 1.1 2001/04/17 11:43:02 arvin Exp arvin $
> # Sample auto.master file
> # Format of this file:
> # mountpoint map options
> # Also see variable AUTOFS_OPTIONS in /etc/sysconfig/autofs
> # For details of the format look at autofs(8).
> /rz     ldap    nisMapName=auto_rz,ou=ivv5,dc=uni-muenster,dc=de
> /share  ldap    nisMapName=auto_packages,ou=ivv5,dc=uni-muenster,dc=de 
> -nosuid,hard,intr,rsize=8192,wsize=8192,tcp
> /u      ldap    nisMapName=auto_home,ou=ivv5,dc=uni-muenster,dc=de 
> -rw,hard,intr,nosuid,retry=2,rsize=8192,wsize=8192,tcp
> 
> everything is working fine like this, but homes in /u/$username are 
> mounted via nfs. i want this to be mounted via cifs.
> 
> so i changed the last line of auto.master to:
> /u /etc/auto.cifs
> 
> compiled a pam_storepw module to save a credentials-file to 
> /var/run/pw/$user
> 
> then wrote a auto.cifs file like this:
> ____________________________________________________________________________
> #!/bin/bash
> key=$1
> username=$key
> userpass=from credentialsfile
> dom=MATH
> mountoptions=-fstype=cifs,file_mode=0644,dir_mode=0755,username=$username,password=$password,dom=$dom 
> 
> echo "$username $mountoptions /$username ://sambaserver/$username

Try:
echo "$mountoptions ://sambaserver/$username"

Username is already the key, as in /u/<key> so it shouldn't be returned.
I don't know why you think you need to add /$username in the middle?

> _____________________________________________________________________________
> 
> the sambaserver exports homes via /$username
> 
> all i want is this to mount the home of user "test" to /u/test from 
> ://sambaserver/test as soon as test logs in.
> 
> this doesnt seem to work. i tried all possible combinations of the 
> echo-line in above auto.cifs, all i get is some weird mounts like home 
> getting mountet to /u/test/test oder /u/test/bin/test/test - totally 
> weird. what's the correct syntax? i thought the above as stated by manpage.
> 
> i tried all this with a direct map as in:
> test 
> -fstype=cifs,file_mode=0644,dir_mode=0755,username=test,password=$password,dom=MATH 
> ://sambaserver/tesst
> 
> and it worked. where's the difference? putting the same syntax into a 
> program map gives me a program lookup error on syslog.

This isn't a direct map entry, it's what a program map should return.

> 
> this seems outta reach for me, any hints?
> 
> sincerely,
> *nail
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
