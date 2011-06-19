From: Ian Kent <raven@themaw.net>
Subject: Re: Odd NIS map failure with mount point creation time in
 the future?
Date: Sun, 19 Jun 2011 11:18:08 +0800
Message-ID: <1308453488.3300.3.camel@perseus.themaw.net>
References: <4DFB60C1.4080801@moving-picture.com>
	<1308392316.12881.14.camel@perseus.themaw.net>
	<4DFCCB4A.4030900@moving-picture.com>
	<4DFD05CE.4060905@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=MKWJ4XHUDFilMvWcf1kj6Nq7u/4=;
	b=dw/I5aWnV2uOUFEK7o7c2RACYjZjK0DGHuNHdOU9wK5KWE6yfL/GdanA0zWYXWHWwPP5lnLQm8+J6Uam+vfBRFcsvkJ7l1C2eqr9J/2CBGDvhlql2sygBVPH71YEYpso8Lc/qXEr72qehBsDFPSt7wg1n8v5QIEcdQxScj/OrWg=
In-Reply-To: <4DFD05CE.4060905@moving-picture.com>
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

On Sat, 2011-06-18 at 21:08 +0100, James Pearson wrote:
> James Pearson wrote:
> > 
> > Sorry, I should have said - this is CentOS 5.5 with autofs 
> > 5.0.1-0.rc2.143.el5_5.6 - and I've also tried it with 
> > 5.0.1-0.rc2.143.el5_6.2 - with the same result.
> > 
> > It is easy to reproduce - with an included NIS map - if I do:
> > 
> > /etc/init.d/autofs stop; date -s "1 minute"; /etc/init.d/autofs start; 
> > date -s "-1 minute"
> > 
> > This creates the automount mount point 1 minute into the future.
> > 
> > Then if I try to access a server defined in the NIS map, the mount fails.
> > 
> > However, if I wait a minute (i.e until the system clock passes the date 
> > stamp of the mount point), the automount of file systems in the NIS map 
> > works fine.
> > 
> > Is it possible to get a copy of the autofs RPM for RHEL-5.7 to test?
> 
> I had a look at the RHEL5 5.0.1-0.rc2.143.el5_6.2 source - and the 
> following patch appears to 'fix' my problem - it's a bit of a hack - as 
> in the included NIS map case, it just resets the age of the map to 
> 'now', if it is in the future.
> 
> James Pearson
> 
> plain text document attachment (autofs-5.0.1-future.patch)
> --- ./daemon/lookup.c.mpc	2011-06-18 20:04:51.076507000 +0100
> +++ ./daemon/lookup.c	2011-06-18 20:52:18.436154033 +0100
> @@ -848,6 +848,12 @@ int lookup_nss_mount(struct autofs_point
>  	struct map_source *map;
>  	enum nsswitch_status status;
>  	int result = 0;
> +	time_t now = time(NULL);
> +
> +	if (entry->age > now) {
> +		debug(ap->logopt, "map %s age in the future - changing it to now", entry->path);
> +		entry->age = now;
> +	}
>  
>  	/*
>  	 * For each map source (ie. each entry for the mount

That sounds a bit like bug
https://bugzilla.redhat.com/show_bug.cgi?id=632471

It was fixed in development revision 152, which I happen to have on
people.redhat.com. You could give that a try.

http://people.redhat.com/~ikent/autofs-5.0.1-0.rc2.152.el5/

Keep in mind that there were a few other fixes that went into the final
release version so your mileage may vary.

Ian
