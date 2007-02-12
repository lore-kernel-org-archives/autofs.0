From: Shane <squindler@gmail.com>
Subject: Re: LDAP automountMap or nisMap
Date: Mon, 12 Feb 2007 16:32:25 +1030
Message-ID: <10badf220702112202j6d10ec54if5e71740634dc5b5@mail.gmail.com>
References: <10badf220702092315xa680710i211a575d4117297d@mail.gmail.com>
	<1171247834.18376.1.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1171247834.18376.1.camel@raven.themaw.net>
Content-Disposition: inline
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On 12/02/07, Ian Kent <raven@themaw.net> wrote:
> On Sat, 2007-02-10 at 17:45 +1030, Shane wrote:
> > Hey All,
> >
> > I've been googling around trying to find out what is the "better"
> > option between using LDAP automountMap's or nisMap's. I can get either
> > / both working, the question is more for being able to find / get good
> > support should we need it, which of these maps is the preferred map to
> > use by autofs? ...does the answer change between autofs 3 and 4?
>
> There's more than one variant of the automountMap type.
> I believe the rfc2307bis is the most recent.
>
> Ian

Thanks for the reply - is this confirmation that automountMap's are
the better / preferred option for autofs though?

Also, we're using a "default" autofs schema provided by redhat (it is
a RHEL4 box) when we do a ldapsearch over the automount's in ldap the
automountInformation coming back is hashed somehow. I've been googling
a fair bit and can't find a way around this - any ideas on how / why
and how to get around it?

TIA
Shane.
