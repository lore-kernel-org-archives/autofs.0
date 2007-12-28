From: Fabio Olive Leite <fleite@redhat.com>
Subject: Re: [autofs] [PATCH 1/4] fs/autofs: Use time_before, time_before_eq, etc.
Date: Fri, 28 Dec 2007 12:21:09 -0200
Message-ID: <20071228142109.GA3801@sleipnir.redhat.com>
References: <Pine.LNX.4.58.0712261621000.1185@pc-041.diku.dk> <2c0942db0712261158q34cddebeifceef6ceda683320@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754687AbXL1OWF@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2c0942db0712261158q34cddebeifceef6ceda683320@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Julia Lawall <julia@diku.dk>, autofs@linux.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com

On Wed, Dec 26, 2007 at 11:58:56AM -0800, Ray Lee wrote:
>=20
> On Dec 26, 2007 7:21 AM, Julia Lawall <julia@diku.dk> wrote:
> > -               if (jiffies - ent->last_usage < timeout)
> > +               if (time_before(jiffies, ent->last_usage + timeout)=
)
>=20
> I don't think this is a safe change? subtraction is always safe (if
> you think about it as 'distance'), addition isn't always safe unless
> you know the range.

This thinking is wrong, and is exactly the kind of wrong thinking that
led to the time_{before,after}{,_eq} macros. If jiffies just wrapped,
your safe subtraction will underflow, and you'll be comparing very
different unsigned values.

This is only a concern for 32bit architectures, of course. With 64bit
jiffies, even if HZ is set to 1000000 in the far future, this
civilization will still not outlive the jiffies counter (insert
shocking soundtrack!) as it will wrap in half a million years.

Sadly with 32bit jiffies it currently wraps every 50 days, and the
sign (if cast to signed) changes every 25 days.

> The time_before macro will expand that out to
> (effectively):
>=20
>   if ( (long)(ent->last_usage + timeout) - (long)(jiffies) < 0 )

After contemplating this for a very long time (for an NFS fix at the
time) I _think_ the magic is in the casts to signed. The construct
manages to compare correctly any given jiffie values within 2^31 of
each other (on 32bit arches) even with wraps, assuming you really have
timestamps where the second one is taken less than 2^31 jiffies after
the first.

Of course, if the highest jiffies bit wraps twice between the first
and second timestamps, you'll be comparing apples and oranges. If the
timing is right this can happen if you compare two timestamps i.e. 26
days from each other, but I think only NFS is wicked enough to produce
such long living (and stale) kernel data structures.

So in summary: don't question time_after and friends. Not without a
very good analysis and testing with a matrix of timestamps. :)

Cheers!
=46=E1bio Oliv=E9
--=20
ex sed lex awk yacc, e pluribus unix, amem
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
