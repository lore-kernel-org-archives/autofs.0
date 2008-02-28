From: Ian Kent <raven@themaw.net>
Subject: Re: SEGV when auto.master in yp-server is with a
	blank	line at last
Date: Thu, 28 Feb 2008 22:05:40 +0900
Message-ID: <1204203941.3501.92.camel@raven.themaw.net>
References: <47C61723.2010006@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47C61723.2010006@oracle.com>
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


On Thu, 2008-02-28 at 10:06 +0800, wengang wang wrote:
> Hi experts,
> 
> Recently I met a problem on RHEL5.1 with autofs-5.0.1-0.rc2.55
> 
> automount SEGV core dumps when running with configs:
> 
> /etc/auto.master
> ===
> +auto.master
> ===
> 
> 
> /etc/nsswitch.conf
> ===
> automount:  files nis
> ===
> 
> 
> ypcat -k auto.master | cat -A
> ===
> /nfs/opsutils auto.opsutils^I^I-rw,soft$
> /nfs/private auto.private^I-rw,intr,nosuid$
> /nfs/roview auto.roview        -rw,intr,nosuid$
> /nfs/group auto.group^I^I-rw,intr$
> /nfs/floor auto.floor^I^I-ro,soft$
> /nfs/net -hosts^I^I^I-ro,soft,nosuid$
> /nfs/log auto.log-hq^I-rw,intr$
> /netvobs auto.vobs^I-rw,hard,intr,nosuid$
> /netview auto.view^I-rw,hard,intr,nosuid$
> /home auto.home^I^I-rw,intr,nosuid$
> /SCM auto.scm^I-rw,hard,intr,nosuid$
> $
> 
> I found the core dump is caused by the last blank line in auto.master. 
> and I wrote a patch on it.
> --- ./modules/lookup_yp.c.bug   2008-02-27 22:50:26.000000000 -0500
> +++ ./modules/lookup_yp.c       2008-02-27 22:51:40.000000000 -0500
> @@ -175,6 +175,9 @@
>         if (*ypkey == '+')
>                 return 0;
>  
> +       if (ypkeylen == 0)
> +               return 0;
> +
>         *(ypkey + ypkeylen) = '\0';
>         *(val + vallen) = '\0';
>  
> and seems this patch fixes the problem.
> 
> Is there anything wrong with the patch?

Ha, you may have spotted a NIS module bug that I couldn't find ages ago.
Well done.

Looks like this is the right thing to do in this case, yes, I think it's
fine.

Thanks.
Ian
