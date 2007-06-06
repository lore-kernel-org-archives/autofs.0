From: Ian Kent <raven@themaw.net>
Subject: Re: autofs and ldap in fedora 7
Date: Wed, 06 Jun 2007 21:03:12 +0800
Message-ID: <1181134992.3699.16.camel@raven.themaw.net>
References: <465EC7F9.6020400@int-edu.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <465EC7F9.6020400@int-edu.eu>
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
To: jehan procaccia <jehan.procaccia@int-edu.eu>
Cc: autofs@linux.kernel.org

On Thu, 2007-05-31 at 15:04 +0200, jehan procaccia wrote:
> Hello, I am trying to read autofs map from an ldap server on the brand 
> new fedora core 7 system .
>  but it doesn't work :-(
> Is there a way to check / debug what the automount process reads ? in 
> fedora core 5 the init.d autofs script showed interesting information:

autofs version 5 is a single process now.
You can find out what autofs mount points have been mounted by looking
at /proc/mounts.

You should be able to find out what's wrong by checking the log, if that
doesn't get you anything enable debug and check the log again.
Directions for getting debug output can be found at
http://people.redhat.com/jmoyer.

> 
> [root@b02-05 ~]# cat /etc/redhat-release
> Fedora Core release 5 (Bordeaux)
> [root@b02-05 ~]# /etc/init.d/autofs status
> Configured Mount Points:
> ------------------------
> /usr/sbin/automount --timeout=60 /net program /etc/auto.net
> /usr/sbin/automount --timeout=60 /mci ldap 
> ou=auto.mci,ou=automount,dc=int-evry,dc=fr
> 
> Active Mount Points:
> --------------------
> /usr/sbin/automount --timeout=60 /net program /etc/auto.net
> /usr/sbin/automount --timeout=60 /mci ldap 
> ou=auto.mci,ou=automount,dc=int-evry,dc=fr
> 
> now, in fedora 7  it only show "running" :-( ...
> [root@b008-04 ~]# uname -a
> Linux b008-04.int-evry.fr 2.6.20-1.3104.fc7 #1 SMP Sat Apr 21 22:20:43 
> EDT 2007 i686 i686 i386 GNU/Linux
> [root@b008-04 ~]# cat /etc/redhat-release
> Fedora release 7 (Rawhide)
> [root@b008-04 ~]# /etc/init.d/autofs status
> automount (pid 19446) running...
> 
> 
> Thanks to let me know how to check what the autmount process actually sees .
>  .
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
