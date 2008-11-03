From: Ian Kent <raven@themaw.net>
Subject: Re: another make issue
Date: Mon, 03 Nov 2008 11:20:04 +0900
Message-ID: <1225678804.2911.24.camel@zeus.themaw.net>
References: <510ca9b40811021718j43583340p38cec31f35cc87ff@mail.gmail.com>
	<1225676646.2911.4.camel@zeus.themaw.net>
	<510ca9b40811021805o2eb86f11x3b0eff0f676a8e22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <510ca9b40811021805o2eb86f11x3b0eff0f676a8e22@mail.gmail.com>
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
To: Paul Wankadia <junyer@gmail.com>
Cc: autofs@linux.kernel.org

On Mon, 2008-11-03 at 13:05 +1100, Paul Wankadia wrote:
> On Mon, Nov 3, 2008 at 12:44 PM, Ian Kent <raven@themaw.net> wrote:
> 
> > Yeah, but there's an assumption that at least one of the directories
> > that is checked will exist on any system, which is obviously wrong. I
> > could add /etc to the end of the list but, really what we need is a list
> > of appropriate directories for various distributions, so if I do that
> > I'll never find out what they are.
> 
> If you follow the FHS, then you can let package maintainers worry
> about anything specific to their distributions.

This has been discussed and at the moment that isn't the way it is being
done. When I separate the configuration into daemon specific and init
script specific bits I'll deal with the above.

Note that I don't want to separate the configuration but concede that I
need to, to accommodate package maintainers needs.

> 
> > What distribution are you using?
> 
> FWIW, I'm using Ubuntu.

And you don't have a directory /etc/conf.d, has that changed somehow,
does it not exist at your build time?

Ian
