From: Ian Kent <raven@themaw.net>
Subject: Re: multi-mount not working on autofs-3.1.7-900.1
Date: Mon, 20 Sep 2010 09:51:45 +0800
Message-ID: <1284947505.3095.10.camel@localhost>
References: <517808.86831.qm@web35601.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=DxvI1Km4PNxJw0ZMFEg20/Mfgnk=;
	b=ad3jbNpH73wue0GZwZ77+vxIznPz+ZYSrpGxrRDkwfF3MdMRgTWZE+iisIfe9o6XzGqGLS32t9wsPza1eHgvc6BnGTAv8laZGSKHEDLTyqsr12DjkA95I/nQt8+ydsd+qzNdE1XUKtLDSc5PrW9iaQGg+uQ3lDsXBLrRaNptmEY=
In-Reply-To: <517808.86831.qm@web35601.mail.mud.yahoo.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: M N KIRAN <kiranmn@yahoo.com>
Cc: autofs@linux.kernel.org

On Sat, 2010-08-07 at 03:32 -0700, M N KIRAN wrote:
> Hi,
> 
> on SLES 9 having autofs-3.1.7-900.1
> 
> content of /etc/auto.master is :
> 
> /home1         /etc/auto/map.home1
> 
> content of /etc/auto/map.home1 is:
> 
> tt        /  -rw,soft,intr    10.XX.XX.XX:/local/scratch /point -rw,soft,intr  10.XX.XX.XX:/local/scratch1
> 
> 
> Both /local/scratch and /local/scratch1 are coming from same nfs server.
> 
> when i access /home1/tt, /local/scratch gets mounted, but when i access
> /home1/tt/point it will not mount /local/scratch1.
> 
> But same setup works on RHEL4 version autofs-4.1.3-169
> and  RHEL5 version autofs-5.0.1-0.rc2.88
> 
> multimount is it supported in autofs-3.1.7-900.1 ? if it not supported what is work around?

Don't know but I don't think so.
I don't see how there could be a workaround either.
If the automount daemon doesn't understand mount hierarchies then it
can't work.
 
> 
> Thanking you,
> regards,
> kiran
> 
> 
> 
>       
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
