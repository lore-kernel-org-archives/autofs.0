From: Ian Kent <raven@themaw.net>
Subject: Re: Problems with Autofs and .hidden files
Date: Tue, 02 Oct 2007 12:46:35 +0800
Message-ID: <1191300395.26331.21.camel@raven.themaw.net>
References: <200709291742.54831.lists@fabis-site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200709291742.54831.lists@fabis-site.net>
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
To: Fabian Steiner <lists@fabis-site.net>
Cc: autofs@linux.kernel.org

On Sat, 2007-09-29 at 17:42 +0200, Fabian Steiner wrote:
> Hello!
> 
> We are using autofs in order to mount the user's home drive via NFS after a
> successfull login authenticated by ldap.
> 
> /etc/auto.master looks like this:
> 
> # AUOTOFS-MAPPING
> /home/schueler  /etc/auto.schueler
> /home/lehrer    /etc/auto.lehrer
> /home/maerkte   /etc/auto.maerkte
> 
> /etc/auto.schueler has the following content (the same also applies for the
> other files):
> 
> *       -fstype=nfs,rw,hard,intr,nodev,nosuid,exec,acl         
> server.domain.de:/home/schueler/&
> 
> Generally speaking this setup works like a charm but from time to time we
> encounter the following messages in syslog:
> 
> Sep 24 16:46:57 server mountd[8818]: authenticated mount request from
> client.domain.de:559 for /home/schueler/.directory (/home/schueler)
> Sep 24 16:46:57 server mountd[8818]: can't stat exported
> dir /home/schueler/.directory: No such file or directory
> 
> Our investigations show that these messages are probably to be created
> whenever a user tries to access /home/schueler by using Konqueror or
> Nautilus. The file .directory doesn't exist, however, and that's why these
> messages appaer. Normalley, this wouldn't be a severe problem but the
> entire is completely slowed down so that another kind of error occurs:
> 
> Sep 24 16:47:00 server mountd[8818]: refused mount request from
> client.domain.de for /home/schueler/.directory (/home/schueler): illegal
> port 48337
> 
> Does anybody know this issue and could provide any hints how to solve it?

What is the setup in terms of server and client, OS, export options etc.
What is the version of autofs and the kernel on the clients?

If your you're happy to allow the use of client ports above 1024 then
use the "insecure" export option and see how it goes.

Ian
