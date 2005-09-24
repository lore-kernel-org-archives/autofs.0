From: "Ryan Pisani" <autofs@thepisanis.com>
Subject: Re: nfs bindresvport: Address already in use
Date: Sat, 24 Sep 2005 11:01:56 -0500 (CDT)
Message-ID: <2293.24.223.199.54.1127577716.squirrel@thepisanis.com>
References: <FB7BDBB2C6034E44B36CFDCF09256BCF029E982C@NYCPEXV003.na.blkint.com>
Reply-To: autofs@thepisanis.com
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <FB7BDBB2C6034E44B36CFDCF09256BCF029E982C@NYCPEXV003.na.blkint.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: "Breitman, Jason" <Jason.Breitman@blackrock.com>
Cc: autofs@linux.kernel.org

I saw this too when switching the default mount type from udp to tcp. We
have an application that mounts over 200 file systems in a for loop, and
it attempts to do it very fast. After the tcp switch there was about a 30%
failure rate. I ended up putting in a .1 sleep in the for loop and that
was enough for the kernel to release the bind port. That little bit of a
sleep did the trick, it's not pretty but it works.

Ryan



> rpm -q autofs
> autofs-4.1.3-131
>
> uname -r
> 2.6.9-5.Elsmp
>
> /etc/auto.master
> /usr/local              program:/usr/bin/autofs_local   --timeout=3600
> --debug
>
> /var/log/messages
> Sep 22 09:41:18 bbc003 automount[4774]: >> nfs bindresvport: Address
> already in use
> Sep 22 09:41:18 bbc003 automount[4774]: mount(nfs): nfs: mount failure
> nfs:/clients/local/data on /usr/local/data
> Sep 22 09:41:18 bbc003 automount[4774]: failed to mount /usr/local/data
>
> Configured Mount Points:
> ------------------------
> /usr/sbin/automount --timeout=3600 --debug /usr/local program
> /usr/bin/autofs_local
>
> Active Mount Points:
> --------------------
> /usr/sbin/automount --timeout=3600 --debug /usr/local program
> /usr/bin/autofs_local
>
> ps -ef | grep automount
> root      2175     1  0 09:38 ?        00:00:00 /usr/sbin/automount
> --timeout=3600 --debug /usr/local program /usr/bin/autofs_local
>
>
> Problem
> Automount fails to mount directories and application fail to run.
>
> Bugzilla ID That appears to be similar
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=128966
>
> Jason Breitman
> jason.breitman@blackrock.com
>
>
> THE INFORMATION CONTAINED IN THIS MESSAGE AND ANY ATTACHMENT MAY BE
> PRIVILEGED, CONFIDENTIAL, PROPRIETARY OR OTHERWISE PROTECTED FROM
> DISCLOSURE. If the reader of this message is not the intended recipient,
> you are hereby notified that any dissemination, distribution, copying or
> use of this message and any attachment is strictly prohibited. If you have
> received this message in error, please notify us immediately by replying
> to the message and permanently delete it from your computer and destroy
> any printout thereof._______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
