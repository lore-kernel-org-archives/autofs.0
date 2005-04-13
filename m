From: Ian Kent <raven@themaw.net>
Subject: Re: Is autofs4 8-bit compatible?
Date: Wed, 13 Apr 2005 12:44:09 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504131243030.10508@wombat.indigo.net.au>
References: <425BEC5A.000002.24005@mfront7.yandex.ru>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <425BEC5A.000002.24005@mfront7.yandex.ru>
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


Thanks for the feedabck.

I took the chance and included this in the 4.1.4 release.

Ian

On Tue, 12 Apr 2005, atlantos41 wrote:

> On Tuesday 05 April 2005 16:51, raven@themaw.net wrote:
> >
> > I don't really think this will do the trick but please try it anyway.
> >
> > It includes the first patch and removes another isprint call.
> >
> > Ian
> >
> > --- autofs-4.1.3/lib/cat_path.c.wide-char      2005-04-05 21:28:36.000000000
> > +0800 +++ autofs-4.1.3/lib/cat_path.c  2005-04-05 21:29:01.000000000 +0800
> > @@ -48,7 +48,7 @@ int _strlen(const char *str, int max)
> >   {
> >        char *s = (char *) str;
> >
> > -      while (isprint(*s++) && max--) ;
> > +      while (*s++ && max--) ;
> >
> >        if (max < 0)
> >                return 0;
> > --- autofs-4.1.3/modules/lookup_file.c.wide-char       2005-04-05
> > 21:30:10.000000000 +0800 +++ autofs-4.1.3/modules/lookup_file.c        2005-04-05
> > 21:30:45.000000000 +0800 @@ -148,7 +148,7 @@ static int read_one(FILE *f,
> > char *key,
> >                                else if (ch == '*') {
> >                                        state = st_star;
> >                                        *(kptr++) = ch;
> > -                              } else if (isprint((char) ch)) {
> > +                              } else {
> >                                        state = st_compare;
> >                                        *(kptr++) = ch;
> >                                }
> > @@ -164,7 +164,7 @@ static int read_one(FILE *f, char *key,
> >                                getting = got_real;
> >                                state = st_entspc;
> >                        } else if (escape == esc_char);
> > -                      else if (isprint((char) ch))
> > +                      else
> >                                *(kptr++) = ch;
> >                        break;
> 
> 
> With this patch everything is OK. It mounts and umounts shares with 8-bit chars in share's name.
> 
