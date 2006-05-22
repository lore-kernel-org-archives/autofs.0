From: Daniel Qarras <dqarras@yahoo.com>
Subject: Re: AutoFS Problems with Laptops
Date: Mon, 22 May 2006 04:51:06 -0700 (PDT)
Message-ID: <20060522115106.99887.qmail@web36801.mail.mud.yahoo.com>
References: <Pine.LNX.4.64.0605221844210.27006@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605221844210.27006@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

> > #!/bin/sh
> > echo -fstype=nfs,rw,soft,intr 10.0.0.1:/home
> > echo -fstype=nfs,rw,soft,intr 10.0.0.1:/work
> 
> This is not right.
> 
> The script is passed the key and you must emit the mount
> corresponding to that key.
> 
> Look at auto.net for an example.

If I run auto.net from command line with parameter 10.0.0.1 it outputs:

root@laptop# /etc/auto.net 10.0.0.1
-fstype=nfs,hard,intr,nodev,nosuid \
        /home 10.0.0.1:/home \
        /work 10.0.0.1:/work

With any other parameter I just get errors. But when I use auto.net or
my own script to print $1 to /tmp/foo I see that $1 is (null) when
doing ls /var/autofs or home when doind cd /var/autofs/home. Naturally,
nothing gets mounted then.

Too bad that RH Bugzilla is still down and I can't check whether
there's already a bug report about this already.

Thanks.



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
