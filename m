From: Ian Kent <raven@themaw.net>
Subject: Re: Is autofs4 8-bit compatible?
Date: Thu, 10 Mar 2005 16:51:38 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0503101631470.15884@wombat.indigo.net.au>
References: <422F6A27.000001.27417@mfront8.yandex.ru>
Mime-Version: 1.0
In-Reply-To: <422F6A27.000001.27417@mfront8.yandex.ru>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: atlantos41 <atlantos41@yandex.ru>
Cc: autofs@linux.kernel.org

On Thu, 10 Mar 2005, atlantos41 wrote:

> On Sunday 06 March 2005 05:10, raven@themaw.net wrote:
> > Could you try this patch for me please.
> >
> > Ian
> >
> > --- autofs-4.1.4_beta2/modules/lookup_file.c.char-compare	2005-03-06
> > 11:06:19.000000000 +0800 +++
> > autofs-4.1.4_beta2/modules/lookup_file.c	2005-03-06 11:06:57.000000000
> > +0800 @@ -147,7 +147,7 @@
> >   				else if (ch == '*') {
> >   					state = st_star;
> >   					*(kptr++) = ch;
> > -				} else if (isprint((char) ch)) {
> > +				} else if (!iscntrl((char) ch)) {
> >   					state = st_compare;
> >   					*(kptr++) = ch;
> >   				}
> 
> 
> I've tried your patch and there are no difference - autofs continue to fail on mount as before.
> 

OK. I'll look a bit further.

You did mention that autofs 3.1.7 did not have this problem correct?
Did you ever try autofs 4.0.0?

Would you be willing to use the "--debug" option on one of your master map 
entries and send me the log?

Ian
