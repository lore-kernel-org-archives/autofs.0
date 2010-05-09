From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5 variable substitution
Date: Sun, 09 May 2010 11:56:32 +0800
Message-ID: <1273377392.3851.70.camel@localhost>
References: <4BE4E1C3.8050708@cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=Ck4dfS1Gj9VGEmvQo/y20KWdHTY=;
	b=VBjvRavZIStGHy8WFA82XWKbQbqrfLhFYm8EHv2N75zY9fKmOKaO3gomppi2ELmOxdKdAsYHuhhFu4Ib/CRFUN1pWaiHkx0iAnAZkjB4RODkbSKN6r1YCjMDdmDb7E6lQ1oocp6bZk55phf7hl0i5Jy+ke70Rf+TvtwtC3nbQ+o=
In-Reply-To: <4BE4E1C3.8050708@cs.umn.edu>
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
To: Peter Bajurny <bajurny@cs.umn.edu>
Cc: autofs@linux.kernel.org

On Fri, 2010-05-07 at 23:00 -0500, Peter Bajurny wrote:
> I apologize if this is the wrong place for this, but my Googling has 
> come up empty and I find myself at a loss.
> 
> In our enviroment we do automounts based on the OSNAME and OSREL 
> variables.  With autofs4 and the sun automounter we manually specify the 
> values of OSNAME and OSREL in the init scripts.  In the autofs4 init.d 
> script there is a line for 'localoptions' where I can set '-DOSNAME=name 
> -DOSREL=rel'.  But I can't for the life of me figure out how to set this 
> with an autofs5 init script.  The init script specifies a confdir and 
> the autofs file there.  I tried adding 'OPTIONS="-DOSNAME=name 
> -DOSREL=rel"' to that line, and the automountd process started with 
> those correct flags, but then it wasn't able to mount anything from my 
> automount maps.  I also tried using LOCALOPTIONS instead of OPTIONS and 
> that didn't do anything.

Yes, the OPTIONS configuration entry probably needs a bit of explanation
in the comments.

See automount(8) or automount5(8), as the case may be, for the -O
option.

Use OPTIONS="-O -DOSNAME=name -DOSREL=rel".

Not sure about if you will need separate quotes around the options
themselves but give it a try.
