From: Ian Kent <raven@themaw.net>
Subject: Re: Map file search list question
Date: Fri, 14 Nov 2008 10:54:00 +0900
Message-ID: <1226627640.2906.10.camel@zeus.themaw.net>
References: <46171233.15261226615003069.JavaMail.root@postoffice>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46171233.15261226615003069.JavaMail.root@postoffice>
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
To: Peter Schmidt <schmidt@pasemi.com>
Cc: autofs@linux.kernel.org

On Thu, 2008-11-13 at 14:23 -0800, Peter Schmidt wrote:
> (Sorry if this turns up as a double post as I first tried to post from a non list account)
> 
> I think what I want is provided by the replicated server feature but I can't get it to work.
> 
> I want to search multiple map files that refer to the same mount point.
> e.g  in the auto.master file can I do something like:
> 
> /home   yp:auto.home1,ldap:nisMapName=auto.home2,ou=mygroup,o=mycompany
> 
> If it can't find the entry in auto.home1 then query auto.home2

Maybe something like (the old method):
/home   multi: yp:auto.home1 -- ldap:nisMapName=auto.home2,ou=mygroup,o=mycompany

should do it.

But you should also be able to use:
In /etc/nsswitch.conf
automount: files nis ldap

and in /etc/auto.master:
/home /etc/auto.home

and in /etc/auto.home
+auto.home1
+auto.home2

If entries in your maps are all fully qualified you should be able to
set "automount: files" in /etc/nsswitch and in /etc/auto.home do:
+yp:auto.home1
+ldap:nisMapName=auto.home2,ou=mygroup,o=mycompany

Ian
