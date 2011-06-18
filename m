From: Ian Kent <raven@themaw.net>
Subject: Re: Odd NIS map failure with mount point creation time in
 the future?
Date: Sat, 18 Jun 2011 18:18:36 +0800
Message-ID: <1308392316.12881.14.camel@perseus.themaw.net>
References: <4DFB60C1.4080801@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=gFg4aVfkwwI3Opnt3a4p/O473ms=;
	b=ggPg5oqkx38bOJtKN1mEQXsqjMKOGowq79YCQvPbwiRfFWZw7skszgUZu1j7AfqrPZtsLV6XHBFMi4SCDe7Sb1DFucltUHjCvr7ARkURENb3s3Jwop5c88yBHuEfwi2J+ba9nyXchE8km9iqyEvzPdojZqIYgf3D7qfGqsQkTTs=
In-Reply-To: <4DFB60C1.4080801@moving-picture.com>
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
To: James Pearson <james-p@moving-picture.com>
Cc: autofs@linux.kernel.org

On Fri, 2011-06-17 at 15:12 +0100, James Pearson wrote:
> I using CentOS 5 on a large number of boxes with a NIS indirect 
> automount map.
> 
> I've been using the following syntax in /etc/auto.master:
> 
> /mntpoint    yp:custom.map
> 
> And this has worked fine for ages
> 
> Recently, I wanted to provide some custom local overrides to mount 
> points in the NIS map, so I've changed /etc/auto.master to be:
> 
> /mntpoint    custom.map
> 
> and created a file called /etc/custom.map which contains something like:
> 
> host1    host:/disk1
> +custom.map
> 
> i.e. include the NIS map after any local mount point settings
> 
> On most machines, this works fine - but on a number of machines, after a 
> reboot, the mounts from the NIS map fail to mount - although the other 
> mounts from /etc/custom.map mount fine.
> 
> One thing I noticed in common on all the machines with this problem is 
> that datestamp on the automount mount point (/mntpoint) was in the 
> future - by an hour or two. I guess the hardware clock is an hour or two 
> ahead of the real time.
> 
> ntp runs on all these boxes - but starts after autofs - however if I 
> change ntp to startup before autofs, then autofs works fine after a 
> reboot ...
> 
> Any idea why autofs fails to read entries from the included NIS map when 
> the creation date of the map mount point is in the future? - but works 
> fine when the same NIS map is referenced directly from /etc/auto.master?

Don't know about the timestamp but there were some included map fixes in
RHEL-5.7, at least one was a fix for a regression.

Versions?

> 
> James Pearson
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
