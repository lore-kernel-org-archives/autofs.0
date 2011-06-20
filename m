From: Ian Kent <raven@themaw.net>
Subject: Re: Odd NIS map failure with mount point creation time in
 the future?
Date: Mon, 20 Jun 2011 21:40:08 +0800
Message-ID: <1308577208.3306.44.camel@perseus.themaw.net>
References: <4DFB60C1.4080801@moving-picture.com>
	<1308392316.12881.14.camel@perseus.themaw.net>
	<4DFCCB4A.4030900@moving-picture.com>	<4DFD05CE.4060905@moving-picture.com>
	<1308453488.3300.3.camel@perseus.themaw.net>
	<4DFF24E7.4020407@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=IIcxFNIvMe/oGPZB1jvQ3fBjdV8=;
	b=DEiWXhfgpZ56zX7t2X9Y2QT30zNa7o+sNDtkeoa/Sa+Vi18C9OoErhrOlQkvmRzzR/lq/9rOBvs4iMpoSgdppcR9BIuigIIZXGLuViTWy1T4jJIODFBU1S6KIkc+Apl2TmEiI/N42c9aSzhmMT8tFf09HQkAn6aGXypgIbKYTPA=
In-Reply-To: <4DFF24E7.4020407@moving-picture.com>
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

On Mon, 2011-06-20 at 11:45 +0100, James Pearson wrote:
> Ian Kent wrote:
> > 
> > That sounds a bit like bug
> > https://bugzilla.redhat.com/show_bug.cgi?id=632471
> 
> I don't have permission to view that bug ...
> 
> > It was fixed in development revision 152, which I happen to have on
> > people.redhat.com. You could give that a try.
> > 
> > http://people.redhat.com/~ikent/autofs-5.0.1-0.rc2.152.el5/
> 
> Unfortunately, this version doesn't help ...

OK, I'll try and reproduce it.

> 
> Thanks
> 
> James Pearson
